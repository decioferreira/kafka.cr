require "./spec_helper"

describe Kafka::Handle do
  it "Produces and consumes a message" do
    conf = Kafka::Configuration.new
    conf.set("broker.version.fallback", "0.9.0.1")
    conf.set("metadata.broker.list", "localhost:9092")

    topic_conf = Kafka::TopicConfiguration.new

    # Consumer
    rk_consumer = Kafka::Consumer.new(conf.dup)
    rkt_consumer = Kafka::Topic.new(rk_consumer, "foobar", topic_conf.dup)

    sent_message = "{ currentTime: #{Time.new().epoch_ms} }"

    conf.set_dr_msg_cb do |producer, message|
      rkt_consumer.consume_start(0, message.offset - 1)
      rkt_consumer.consume(0).to_s.should eq(sent_message)
    end

    # Producer
    rk_producer = Kafka::Producer.new(conf.dup)
    rkt_producer = Kafka::Topic.new(rk_producer, "foobar", topic_conf.dup)

    # Produce
    rkt_producer.produce(0, sent_message)
    rk_producer.poll(-1)
  end
end
