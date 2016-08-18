module Kafka
  # A growable list of Topic+Partitions.
  class TopicPartitionList
    def initialize(@rkparlist : LibKafka::TopicPartitionListT)
    end

    # Create a new list/vector Topic+Partition container.
    def initialize(size)
      @rkparlist = LibKafka.topic_partition_list_new(size)
    end

    # Free all resources used by the list and the list itself.
    def destroy
      LibKafka.topic_partition_list_destroy(self)
    end

    # Add topic+partition to list.
    def add(topic : String, partition : Int32)
      LibKafka.topic_partition_list_add(self, topic, partition)
    end

    # Add range of partitions from start to stop inclusive.
    def add_range(topic : String, start : Int32, stop : Int32)
      LibKafka.topic_partition_list_add_range(self, topic, start, stop)
    end

    # Delete partition from list.
    def del(topic : String, partition : Int32)
      LibKafka.topic_partition_list_del(self, topic, partition)
    end

    # Delete partition from list.
    def del_by_idx(idx : LibC::Int)
      LibKafka.topic_partition_list_del_by_idx(self, idx)
    end

    # Make a copy of an existing list.
    def copy : TopicPartitionList
      self.class.new(LibKafka.topic_partition_list_copy(self))
    end

    # Set offset for topic and partition.
    def topic_partition_list_set_offset(topic : String, partition : Int32, offset : Int64)
      LibKafka.topic_partition_list_set_offset(self, topic, partition, offset)
    end

    # Find element by topic and partition.
    def topic_partition_list_find(topic : String, partition : Int32)
      LibKafka.topic_partition_list_find(self, topic, partition)
    end

    def to_unsafe
      @rkparlist
    end
  end
end
