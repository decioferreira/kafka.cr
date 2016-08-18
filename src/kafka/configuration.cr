module Kafka
  class Configuration
    # Create configuration object.
    def initialize(@conf = LibKafka.conf_new)
    end

    # Destroys the configuration object.
    def destroy
      LibKafka.conf_destroy(self)
    end

    # Creates a copy/duplicate of configuration object configuration.
    def dup : Configuration
      self.class.new(LibKafka.conf_dup(self))
    end

    # Sets a configuration property.
    def set(name : String, value : String)
      errstr = String.new(255) do |buffer|
        LibKafka.conf_set(self, name, value, buffer, LibC::SizeT.new(255))

        len = LibC.strlen(buffer)
        {len, len}
      end
    end

    # Retrieve configuration value for property name.
    def get(name : String)
      dest_size = uninitialized LibC::SizeT
      LibKafka.conf_get(self, name, nil, pointerof(dest_size))

      String.new(dest_size) do |dest|
        LibC::SizeT.new(255)
        LibKafka.conf_get(self, name, dest, pointerof(dest_size))

        len = LibC.strlen(dest)
        {len, len}
      end
    end

    # Producer: Set delivery report callback in provided configuration object.
    def set_dr_msg_cb(&dr_msg_cb : Producer, Message ->)
      # We must save this in Crystal-land so the GC doesn't collect it (*)
      @@dr_msg_cb = dr_msg_cb

      # Since Proc is a {Void*, Void*}, we can't turn that into a Void*, so we
      # "box" it: we allocate memory and store the Proc there
      boxed_data = Box.box(dr_msg_cb)

      LibKafka.conf_set_opaque(self, boxed_data)
      LibKafka.conf_set_dr_msg_cb(self, ->(rk, rkmessage, opaque) {
        # Now we turn opaque back into the Proc, using Box.unbox
        opaque_as_callback = Box(typeof(dr_msg_cb)).unbox(opaque)

        opaque_as_callback.call(Producer.new(rk), Message.new(rkmessage))
      })
    end

    # Consumer: Set consume callback for use with `rd_kafka_consumer_poll()`.
    def set_consume_cb(&consume_cb : Message ->)
      # We must save this in Crystal-land so the GC doesn't collect it (*)
      @@consume_cb = consume_cb

      # Since Proc is a {Void*, Void*}, we can't turn that into a Void*, so we
      # "box" it: we allocate memory and store the Proc there
      boxed_data = Box.box(consume_cb)

      LibKafka.conf_set_opaque(self, boxed_data)
      LibKafka.conf_set_consume_cb(self, ->(rkmessage, opaque) {
        # Now we turn opaque back into the Proc, using Box.unbox
        opaque_as_callback = Box(typeof(consume_cb)).unbox(opaque)

        opaque_as_callback.call(Message.new(rkmessage))
      })
    end

    # Consumer: Set rebalance callback for use with coordinated consumer group
    # balancing.
    def set_rebalance_cb(&rebalance_cb : Consumer, LibKafka::RespErrT, TopicPartitionList ->)
      # We must save this in Crystal-land so the GC doesn't collect it (*)
      @@rebalance_cb = rebalance_cb

      # Since Proc is a {Void*, Void*}, we can't turn that into a Void*, so we
      # "box" it: we allocate memory and store the Proc there
      boxed_data = Box.box(rebalance_cb)

      LibKafka.conf_set_opaque(self, boxed_data)
      LibKafka.conf_set_rebalance_cb(self, ->(rk, err, partitions, opaque) {
        # Now we turn opaque back into the Proc, using Box.unbox
        opaque_as_callback = Box(typeof(rebalance_cb)).unbox(opaque)

        opaque_as_callback.call(Consumer.new(rk), err, TopicPartitionList.new(partitions))
      })
    end

    # Consumer: Set offset commit callback for use with consumer groups.
    def set_offset_commit_cb
    end

    # Set error callback in provided configuration object.
    def set_error_cb(&error_cb : Handle, LibC::Int, String ->)
      # We must save this in Crystal-land so the GC doesn't collect it (*)
      @@error_cb = error_cb

      # Since Proc is a {Void*, Void*}, we can't turn that into a Void*, so we
      # "box" it: we allocate memory and store the Proc there
      boxed_data = Box.box(error_cb)

      LibKafka.conf_set_opaque(self, boxed_data)
      LibKafka.conf_set_offset_commit_cb(self, ->(rk, err, reason, opaque) {
        # Now we turn opaque back into the Proc, using Box.unbox
        opaque_as_callback = Box(typeof(error_cb)).unbox(opaque)

        opaque_as_callback.call(Handle.new(rk), err, reason)
      })
    end

    # Set throttle callback.
    def set_throttle_cb
    end

    # Set logger callback.
    def set_log_cb
    end

    # Set statistics callback in provided configuration object.
    def set_stats_cb
    end

    # Set socket callback.
    def set_socket_cb
    end

    # Set open callback.
    def set_open_cb
    end

    # Sets the application's opaque pointer that will be passed to callbacks.
    def set_opaque
    end

    # Sets the default topic configuration to use for automatically
    # subscribed topics (e.g., through pattern-matched topics).
    # The topic configuration object is not usable after this call.
    def set_default_topic_conf
    end

    # Dump the configuration properties and values of configuration to an array
    # with "key", "value" pairs.
    def dump
    end

    def to_unsafe
      @conf
    end
  end
end
