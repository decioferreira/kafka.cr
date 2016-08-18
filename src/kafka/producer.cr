require "./handle"

module Kafka
  class Producer < Handle
    def initialize(handle : LibKafka::RdKafkaT)
      super(handle)
    end

    def initialize(conf : Configuration)
      super(LibKafka::TypeT::RdKafkaProducer, conf)
    end
  end
end
