module Kafka
  class TopicConfiguration
    # Create topic configuration object.
    def initialize(@conf = LibKafka.topic_conf_new)
    end

    # Destroys the topic configuration object.
    def destroy
      LibKafka.topic_conf_destroy(self)
    end

    # Creates a copy/duplicate of topic configuration object configuration.
    def dup
      self.class.new(LibKafka.topic_conf_dup(self))
    end

    # Sets a single topic configuration value by property name.
    def set(name : String, value : String)
      errstr = String.new(255) do |buffer|
        LibKafka.topic_conf_set(self, name, value, buffer, LibC::SizeT.new(255))

        len = LibC.strlen(buffer)
        {len, len}
      end
    end

    def to_unsafe
      @conf
    end
  end
end
