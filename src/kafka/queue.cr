module Kafka
  class Queue
    # Create a new message queue.
    def initialize(rk : Consumer | Producer)
      @rkqu = LibKafka.queue_new(rk)
    end

    # Destroys queue, purging all of the enqueued messages.
    def destroy
      LibKafka.queue_destroy(self)
    end

    def to_unsafe
      @rkqu
    end
  end
end
