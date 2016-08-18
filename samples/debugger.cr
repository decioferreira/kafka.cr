require "../src/kafka"

puts "Version: #{Kafka.version}"
puts "Version String: #{Kafka.version_str}"
puts "Debug: #{Kafka.get_debug_contexts}"

Kafka.get_err_descs.each do |errdesc|
  puts errdesc
end

puts "Error String: #{Kafka.err2str(Kafka.last_error)}"
puts "Error Name: #{Kafka.err2name(Kafka.last_error)}"
