require "../src/kafka"

puts "Version: #{Kafka.version_str}"
puts "Debug: #{Kafka.get_debug_contexts}"

conf = Kafka::Configuration.new

conf.set_consume_cb do |message|
  puts "set_consume_cb: #{message}"
end

conf.set("metadata.broker.list", "localhost:9092")
puts "metadata.broker.list set to: '#{conf.get("metadata.broker.list")}'"

conf.set("debug", "all")
puts "debug set to: '#{conf.get("debug")}'"

topicConf = Kafka::TopicConfiguration.new

rk = Kafka::Consumer.new(conf)

rkt = Kafka::Topic.new(rk, "EventsIn", topicConf)

rkt.consume_start(0, -1_i64)

message = rkt.consume(0)
puts "consume: #{message}" unless message.nil?

messages = rkt.consume_batch(0)
messages.each do |message|
  puts "consume_batch: #{message}"
end

rkt.consume_callback(0) do |message|
  puts "consume_callback: #{message}"
end
