module Kafka
  class Message
    def initialize(@rkmessage : LibKafka::MessageT*)
    end

    # Frees resources and hands ownership back to rdkafka.
    def destroy
      LibKafka.message_destroy(self)
    end

    # Returns the error string for an errored rd_kafka_message_t or NULL if
    # there was no error.
    def errstr : String | Nil
      LibKafka.message_errstr(self)
    end

    # Returns the message timestamp for a consumed message.
    def timestamp : Int64
      LibKafka.message_timestamp(self, out tstype)
    end

    def payload
      String.new(@rkmessage.value.payload.as(Pointer(LibC::Char)), @rkmessage.value.len)
    end

    def offset
      @rkmessage.value.offset
    end

    def to_s(io)
      io << payload
    end

    def to_unsafe
      @rkmessage
    end
  end
end
