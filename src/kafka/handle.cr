module Kafka
  class Handle
    @handle : LibKafka::RdKafkaT

    def initialize(@handle : LibKafka::RdKafkaT)
    end

    # Creates a new Kafka handle and starts its operation according to the specified type.
    def initialize(type : LibKafka::TypeT, conf : Configuration)
      errstr = Pointer(LibC::Char).malloc(255)
      @handle = LibKafka.new(type, conf, errstr, LibC::SizeT.new(255))

      if @handle.null?
        raise String.new(errstr, LibC.strlen(errstr))
      end
    end

    # Destroy Kafka handle.
    def destroy
      LibKafka.destroy(self)
    end

    # Returns Kafka handle name.
    def name : String
      LibKafka.name(self)
    end

    # Returns this client's broker-assigned group member id.
    def member_id
      LibKafka.memberid(self)
    end

    # Returns the current out queue length.
    def outq_len
      LibKafka.outq_len(self)
    end

    # Adds one or more brokers to the kafka handle's list of initial
    # bootstrap brokers.
    def brokers_add(brokerlist : String)
      LibKafka.brokers_add(self, brokerlist)
    end

    # Polls the provided kafka handle for events.
    # Events will cause application provided callbacks to be called.
    def poll(timeout_ms = 1000)
      LibKafka.poll(self, timeout_ms)
    end

    def set_log_level(level : LibC::Int)
      LibKafka.set_log_level(self, level)
    end

    def to_unsafe
      @handle
    end
  end
end
