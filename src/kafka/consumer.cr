require "./handle"

module Kafka
  class Consumer < Handle
    def initialize(handle : LibKafka::RdKafkaT)
      super(handle)
    end

    def initialize(conf : Configuration)
      super(LibKafka::TypeT::RdKafkaConsumer, conf)
    end
  end
end
