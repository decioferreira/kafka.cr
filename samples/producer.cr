require "../src/kafka"

puts "Version: #{Kafka.version_str}"
puts "Debug: #{Kafka.get_debug_contexts}"

conf = Kafka::Configuration.new

conf.set_dr_msg_cb do |producer, message|
  puts "set_dr_msg_cb: #{producer}, #{message}"
end

conf.set("debug", "all")
puts "debug set to: '#{conf.get("debug")}'"

topic_conf = Kafka::TopicConfiguration.new
topic_conf.set("produce.offset.report", "true")

rk = Kafka::Producer.new(conf)
rk.set_log_level(7) # LOG_DEBUG

rk.brokers_add("localhost:9092")

rkt = Kafka::Topic.new(rk, "foobar", topic_conf)

rkt.produce(0, "{}")

rk.poll(0)

10.times do
  puts rk.outq_len
  rk.poll(100)
  sleep 0.2
end
