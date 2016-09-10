require "./spec_helper"

describe Kafka do
  it "Returns the librdkafka version as integer" do
    Kafka.version.should eq(590335)
  end

  it "Returns the librdkafka version as string" do
    Kafka.version_str.should eq("0.9.1")
  end

  it "Retrieve supported debug contexts" do
    Kafka.get_debug_contexts.should eq(
      "all,generic,broker,topic,metadata,producer,queue,msg,protocol,cgrp,security,fetch"
    )
  end

  pending "Wait for all rd_kafka_t objects to be destroyed" do
  end

  pending "Returns the full list of error codes" do
  end
end
