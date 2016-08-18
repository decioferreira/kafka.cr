module Kafka
  class Topic
    # Creates a new topic handle for topic named topic.
    def initialize(rk : Consumer | Producer, topic : String, conf : TopicConfiguration)
      @rkt = LibKafka.topic_new(rk, topic, conf)
    end

    # Start consuming messages for partition at offset.
    def consume_start(partition : Int32, offset : Int64)
      LibKafka.consume_start(self, partition, offset)
    end

    # Start consuming messages for partition at offset,
    # but re-routes incoming messages to the provided queue rkqu.
    def consume_start(partition : Int32, offset : Int64, rkqu : Queue)
      LibKafka.consume_start_queue(self, partition, offset, rkqu)
    end

    # Consume a single message from partition.
    def consume(partition : Int32, timeout_ms = 1000) : Message | Nil
      rkmessage = LibKafka.consume(self, partition, timeout_ms)
      rkmessage.null? ? nil : Message.new(rkmessage)
    end

    # Consume up to rkmessages_size from partition putting a pointer to each message in the
    # application provided array rkmessages (of size rkmessages_size entries).
    def consume_batch(partition : Int32, timeout_ms = 1000, rkmessages_size = 64) : Array(Message)
      Slice(Pointer(LibKafka::MessageT)).new(rkmessages_size).tap { |rkmessages|
        LibKafka.consume_batch(self, partition, timeout_ms, rkmessages, rkmessages_size)
      }.compact_map { |rkmessage|
        rkmessage.null? ? nil : Message.new(rkmessage)
      }
    end

    # Consumes messages from partition, calling the provided callback for each consumed messsage.
    def consume_callback(partition : Int32, timeout_ms = 1000, &consume_cb : Message ->)
      # We must save this in Crystal-land so the GC doesn't collect it (*)
      @@consume_cb = consume_cb

      # Since Proc is a {Void*, Void*}, we can't turn that into a Void*, so we
      # "box" it: we allocate memory and store the Proc there
      boxed_data = Box.box(consume_cb)

      LibKafka.consume_callback(self, partition, timeout_ms, ->(rkmessage, opaque) {
        # Now we turn opaque back into the Proc, using Box.unbox
        opaque_as_callback = Box(typeof(consume_cb)).unbox(opaque)

        opaque_as_callback.call(Message.new(rkmessage))
      }, boxed_data)
    end

    # Stop consuming messages for partition, purging
    # all messages currently in the local queue.
    def consume_stop(partition : Int32)
      LibKafka.consume_stop(self, partition)
    end

    # Produce and send a single message to broker.
    def produce(partition : Int32, payload : String, key : String = nil, msg_opaque = nil)
      msgflags = 2
      len = payload.size
      keylen = key.nil? ? 0 : key.size

      LibKafka.produce(self, partition, msgflags, payload, len, key, keylen, msg_opaque)
    end

    # Produce multiple messages.
    def produce_batch(partition : Int32)
      LibKafka.produce_batch(self, partition, msgflags)
    end

    def to_unsafe
      @rkt
    end
  end
end
