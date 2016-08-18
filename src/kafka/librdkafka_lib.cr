@[Link("rdkafka")]
lib LibKafka
  fun version = rd_kafka_version : LibC::Int
  fun version_str = rd_kafka_version_str : LibC::Char*
  fun get_debug_contexts = rd_kafka_get_debug_contexts : LibC::Char*

  alias S = Void
  alias TopicS = Void
  alias ConfS = Void
  alias TopicConfS = Void
  alias QueueS = Void

  struct ErrDesc
    code : RespErrT
    name : LibC::Char*
    desc : LibC::Char*
  end

  enum RespErrT
    RdKafkaRespErrBegin                        = -200
    RdKafkaRespErrBadMsg                       = -199
    RdKafkaRespErrBadCompression               = -198
    RdKafkaRespErrDestroy                      = -197
    RdKafkaRespErrFail                         = -196
    RdKafkaRespErrTransport                    = -195
    RdKafkaRespErrCritSysResource              = -194
    RdKafkaRespErrResolve                      = -193
    RdKafkaRespErrMsgTimedOut                  = -192
    RdKafkaRespErrPartitionEof                 = -191
    RdKafkaRespErrUnknownPartition             = -190
    RdKafkaRespErrFs                           = -189
    RdKafkaRespErrUnknownTopic                 = -188
    RdKafkaRespErrAllBrokersDown               = -187
    RdKafkaRespErrInvalidArg                   = -186
    RdKafkaRespErrTimedOut                     = -185
    RdKafkaRespErrQueueFull                    = -184
    RdKafkaRespErrIsrInsuff                    = -183
    RdKafkaRespErrNodeUpdate                   = -182
    RdKafkaRespErrSsl                          = -181
    RdKafkaRespErrWaitCoord                    = -180
    RdKafkaRespErrUnknownGroup                 = -179
    RdKafkaRespErrInProgress                   = -178
    RdKafkaRespErrPrevInProgress               = -177
    RdKafkaRespErrExistingSubscription         = -176
    RdKafkaRespErrAssignPartitions             = -175
    RdKafkaRespErrRevokePartitions             = -174
    RdKafkaRespErrConflict                     = -173
    RdKafkaRespErrState                        = -172
    RdKafkaRespErrUnknownProtocol              = -171
    RdKafkaRespErrNotImplemented               = -170
    RdKafkaRespErrAuthentication               = -169
    RdKafkaRespErrNoOffset                     = -168
    RdKafkaRespErrOutdated                     = -167
    RdKafkaRespErrEnd                          = -100
    RdKafkaRespErrUnknown                      =   -1
    RdKafkaRespErrNoError                      =    0
    RdKafkaRespErrOffsetOutOfRange             =    1
    RdKafkaRespErrInvalidMsg                   =    2
    RdKafkaRespErrUnknownTopicOrPart           =    3
    RdKafkaRespErrInvalidMsgSize               =    4
    RdKafkaRespErrLeaderNotAvailable           =    5
    RdKafkaRespErrNotLeaderForPartition        =    6
    RdKafkaRespErrRequestTimedOut              =    7
    RdKafkaRespErrBrokerNotAvailable           =    8
    RdKafkaRespErrReplicaNotAvailable          =    9
    RdKafkaRespErrMsgSizeTooLarge              =   10
    RdKafkaRespErrStaleCtrlEpoch               =   11
    RdKafkaRespErrOffsetMetadataTooLarge       =   12
    RdKafkaRespErrNetworkException             =   13
    RdKafkaRespErrGroupLoadInProgress          =   14
    RdKafkaRespErrGroupCoordinatorNotAvailable =   15
    RdKafkaRespErrNotCoordinatorForGroup       =   16
    RdKafkaRespErrTopicException               =   17
    RdKafkaRespErrRecordListTooLarge           =   18
    RdKafkaRespErrNotEnoughReplicas            =   19
    RdKafkaRespErrNotEnoughReplicasAfterAppend =   20
    RdKafkaRespErrInvalidRequiredAcks          =   21
    RdKafkaRespErrIllegalGeneration            =   22
    RdKafkaRespErrInconsistentGroupProtocol    =   23
    RdKafkaRespErrInvalidGroupId               =   24
    RdKafkaRespErrUnknownMemberId              =   25
    RdKafkaRespErrInvalidSessionTimeout        =   26
    RdKafkaRespErrRebalanceInProgress          =   27
    RdKafkaRespErrInvalidCommitOffsetSize      =   28
    RdKafkaRespErrTopicAuthorizationFailed     =   29
    RdKafkaRespErrGroupAuthorizationFailed     =   30
    RdKafkaRespErrClusterAuthorizationFailed   =   31
    RdKafkaRespErrInvalidTimestamp             =   32
    RdKafkaRespErrUnsupportedSaslMechanism     =   33
    RdKafkaRespErrIllegalSaslState             =   34
    RdKafkaRespErrUnsupportedVersion           =   35
    RdKafkaRespErrEndAll                       =   36
  end

  fun get_err_descs = rd_kafka_get_err_descs(errdescs : ErrDesc**, cntp : LibC::SizeT*)
  fun err2str = rd_kafka_err2str(err : RespErrT) : LibC::Char*
  fun err2name = rd_kafka_err2name(err : RespErrT) : LibC::Char*
  fun last_error = rd_kafka_last_error : RespErrT
  fun errno2err = rd_kafka_errno2err(errnox : LibC::Int) : RespErrT
  fun errno = rd_kafka_errno : LibC::Int

  struct TopicPartitionT
    topic : LibC::Char*
    partition : Int32T
    offset : Int64T
    metadata : Void*
    metadata_size : LibC::SizeT
    opaque : Void*
    err : RespErrT
    _private : Void*
  end

  alias Int32T = LibC::Int
  alias Int64T = LibC::LongLong

  struct TopicPartitionListT
    cnt : LibC::Int
    size : LibC::Int
    elems : TopicPartitionT*
  end

  # type TopicPartitionT = TopicPartitionS

  fun topic_partition_list_new = rd_kafka_topic_partition_list_new(size : LibC::Int) : TopicPartitionListT*

  # type TopicPartitionListT = TopicPartitionListS

  fun topic_partition_list_destroy = rd_kafka_topic_partition_list_destroy(rkparlist : TopicPartitionListT*)
  fun topic_partition_list_add = rd_kafka_topic_partition_list_add(rktparlist : TopicPartitionListT*, topic : LibC::Char*, partition : Int32T) : TopicPartitionT*
  fun topic_partition_list_add_range = rd_kafka_topic_partition_list_add_range(rktparlist : TopicPartitionListT*, topic : LibC::Char*, start : Int32T, stop : Int32T)
  fun topic_partition_list_del = rd_kafka_topic_partition_list_del(rktparlist : TopicPartitionListT*, topic : LibC::Char*, partition : Int32T) : LibC::Int
  fun topic_partition_list_del_by_idx = rd_kafka_topic_partition_list_del_by_idx(rktparlist : TopicPartitionListT*, idx : LibC::Int) : LibC::Int
  fun topic_partition_list_copy = rd_kafka_topic_partition_list_copy(src : TopicPartitionListT*) : TopicPartitionListT*
  fun topic_partition_list_set_offset = rd_kafka_topic_partition_list_set_offset(rktparlist : TopicPartitionListT*, topic : LibC::Char*, partition : Int32T, offset : Int64T) : RespErrT
  fun topic_partition_list_find = rd_kafka_topic_partition_list_find(rktparlist : TopicPartitionListT*, topic : LibC::Char*, partition : Int32T) : TopicPartitionT*

  struct MessageT
    err : RespErrT
    rkt : RdKafkaTopicT
    partition : Int32T
    payload : Void*
    len : LibC::SizeT
    key : Void*
    key_len : LibC::SizeT
    offset : Int64T
    _private : Void*
  end

  type RdKafkaTopicT = Void*

  fun message_destroy = rd_kafka_message_destroy(rkmessage : MessageT*)

  # type MessageT = MessageS

  fun message_errstr = rd_kafka_message_errstr(rkmessage : MessageT*) : LibC::Char*
  fun message_timestamp = rd_kafka_message_timestamp(rkmessage : MessageT*, tstype : TimestampTypeT*) : Int64T

  enum TimestampTypeT
    RdKafkaTimestampNotAvailable  = 0
    RdKafkaTimestampCreateTime    = 1
    RdKafkaTimestampLogAppendTime = 2
  end

  fun conf_new = rd_kafka_conf_new : RdKafkaConfT

  type RdKafkaConfT = Void*

  fun conf_destroy = rd_kafka_conf_destroy(conf : RdKafkaConfT)
  fun conf_dup = rd_kafka_conf_dup(conf : RdKafkaConfT) : RdKafkaConfT
  fun conf_set = rd_kafka_conf_set(conf : RdKafkaConfT, name : LibC::Char*, value : LibC::Char*, errstr : LibC::Char*, errstr_size : LibC::SizeT) : ConfResT

  enum ConfResT
    RdKafkaConfUnknown = -2
    RdKafkaConfInvalid = -1
    RdKafkaConfOk      =  0
  end

  # TODO: NOT IMPLEMENTED FROM HERE!!!
  fun conf_set_dr_cb = rd_kafka_conf_set_dr_cb(conf : RdKafkaConfT, dr_cb : (RdKafkaT, Void*, LibC::SizeT, RespErrT, Void*, Void* -> Void))

  type RdKafkaT = Void*

  fun conf_set_dr_msg_cb = rd_kafka_conf_set_dr_msg_cb(conf : RdKafkaConfT, dr_msg_cb : (RdKafkaT, MessageT*, Void* -> Void))
  fun conf_set_consume_cb = rd_kafka_conf_set_consume_cb(conf : RdKafkaConfT, consume_cb : (MessageT*, Void* -> Void))
  fun conf_set_rebalance_cb = rd_kafka_conf_set_rebalance_cb(conf : RdKafkaConfT, rebalance_cb : (RdKafkaT, RespErrT, TopicPartitionListT*, Void* -> Void))
  fun conf_set_offset_commit_cb = rd_kafka_conf_set_offset_commit_cb(conf : RdKafkaConfT, offset_commit_cb : (RdKafkaT, RespErrT, TopicPartitionListT*, Void* -> Void))
  fun conf_set_error_cb = rd_kafka_conf_set_error_cb(conf : RdKafkaConfT, error_cb : (RdKafkaT, LibC::Int, LibC::Char*, Void* -> Void))
  fun conf_set_throttle_cb = rd_kafka_conf_set_throttle_cb(conf : RdKafkaConfT, throttle_cb : (RdKafkaT, LibC::Char*, Int32T, LibC::Int, Void* -> Void))
  fun conf_set_log_cb = rd_kafka_conf_set_log_cb(conf : RdKafkaConfT, log_cb : (RdKafkaT, LibC::Int, LibC::Char*, LibC::Char* -> Void))
  fun conf_set_stats_cb = rd_kafka_conf_set_stats_cb(conf : RdKafkaConfT, stats_cb : (RdKafkaT, LibC::Char*, LibC::SizeT, Void* -> LibC::Int))
  fun conf_set_socket_cb = rd_kafka_conf_set_socket_cb(conf : RdKafkaConfT, socket_cb : (LibC::Int, LibC::Int, LibC::Int, Void* -> LibC::Int))
  fun conf_set_open_cb = rd_kafka_conf_set_open_cb(conf : RdKafkaConfT, open_cb : (LibC::Char*, LibC::Int, ModeT, Void* -> LibC::Int))

  alias X__Uint16T = LibC::UShort
  alias X__DarwinModeT = X__Uint16T
  alias ModeT = X__DarwinModeT

  fun conf_set_opaque = rd_kafka_conf_set_opaque(conf : RdKafkaConfT, opaque : Void*)
  fun opaque = rd_kafka_opaque(rk : RdKafkaT) : Void*
  fun conf_set_default_topic_conf = rd_kafka_conf_set_default_topic_conf(conf : RdKafkaConfT, tconf : RdKafkaTopicConfT)

  type RdKafkaTopicConfT = Void*

  fun conf_get = rd_kafka_conf_get(conf : RdKafkaConfT, name : LibC::Char*, dest : LibC::Char*, dest_size : LibC::SizeT*) : ConfResT
  fun topic_conf_get = rd_kafka_topic_conf_get(conf : RdKafkaTopicConfT, name : LibC::Char*, dest : LibC::Char*, dest_size : LibC::SizeT*) : ConfResT
  fun conf_dump = rd_kafka_conf_dump(conf : RdKafkaConfT, cntp : LibC::SizeT*) : LibC::Char**
  fun topic_conf_dump = rd_kafka_topic_conf_dump(conf : RdKafkaTopicConfT, cntp : LibC::SizeT*) : LibC::Char**
  fun conf_dump_free = rd_kafka_conf_dump_free(arr : LibC::Char**, cnt : LibC::SizeT)
  fun conf_properties_show = rd_kafka_conf_properties_show(fp : File*)

  struct X__Sfile
    _p : UInt8*
    _r : LibC::Int
    _w : LibC::Int
    _flags : LibC::Short
    _file : LibC::Short
    _bf : X__Sbuf
    _lbfsize : LibC::Int
    _cookie : Void*
    _close : (Void* -> LibC::Int)
    _read : (Void*, LibC::Char*, LibC::Int -> LibC::Int)
    _seek : (Void*, FposT, LibC::Int -> FposT)
    _write : (Void*, LibC::Char*, LibC::Int -> LibC::Int)
    _ub : X__Sbuf
    _extra : X__Sfilex*
    _ur : LibC::Int
    _ubuf : UInt8[3]
    _nbuf : UInt8[1]
    _lb : X__Sbuf
    _blksize : LibC::Int
    _offset : FposT
  end

  type File = X__Sfile

  struct X__Sbuf
    _base : UInt8*
    _size : LibC::Int
  end

  alias X__Int64T = LibC::LongLong
  alias X__DarwinOffT = X__Int64T
  alias FposT = X__DarwinOffT
  alias X__Sfilex = Void

  fun topic_conf_new = rd_kafka_topic_conf_new : RdKafkaTopicConfT
  fun topic_conf_dup = rd_kafka_topic_conf_dup(conf : RdKafkaTopicConfT) : RdKafkaTopicConfT
  fun topic_conf_destroy = rd_kafka_topic_conf_destroy(topic_conf : RdKafkaTopicConfT)
  fun topic_conf_set = rd_kafka_topic_conf_set(conf : RdKafkaTopicConfT, name : LibC::Char*, value : LibC::Char*, errstr : LibC::Char*, errstr_size : LibC::SizeT) : ConfResT
  fun topic_conf_set_opaque = rd_kafka_topic_conf_set_opaque(conf : RdKafkaTopicConfT, opaque : Void*)
  fun topic_conf_set_partitioner_cb = rd_kafka_topic_conf_set_partitioner_cb(topic_conf : RdKafkaTopicConfT, partitioner : (RdKafkaTopicT, Void*, LibC::SizeT, Int32T, Void*, Void* -> Int32T))
  fun topic_partition_available = rd_kafka_topic_partition_available(rkt : RdKafkaTopicT, partition : Int32T) : LibC::Int
  fun msg_partitioner_random = rd_kafka_msg_partitioner_random(rkt : RdKafkaTopicT, key : Void*, keylen : LibC::SizeT, partition_cnt : Int32T, opaque : Void*, msg_opaque : Void*) : Int32T
  fun msg_partitioner_consistent = rd_kafka_msg_partitioner_consistent(rkt : RdKafkaTopicT, key : Void*, keylen : LibC::SizeT, partition_cnt : Int32T, opaque : Void*, msg_opaque : Void*) : Int32T
  fun msg_partitioner_consistent_random = rd_kafka_msg_partitioner_consistent_random(rkt : RdKafkaTopicT, key : Void*, keylen : LibC::SizeT, partition_cnt : Int32T, opaque : Void*, msg_opaque : Void*) : Int32T
  fun new = rd_kafka_new(type : TypeT, conf : RdKafkaConfT, errstr : LibC::Char*, errstr_size : LibC::SizeT) : RdKafkaT

  enum TypeT
    RdKafkaProducer = 0
    RdKafkaConsumer = 1
  end

  fun destroy = rd_kafka_destroy(rk : RdKafkaT)
  fun name = rd_kafka_name(rk : RdKafkaT) : LibC::Char*
  fun memberid = rd_kafka_memberid(rk : RdKafkaT) : LibC::Char*
  fun topic_new = rd_kafka_topic_new(rk : RdKafkaT, topic : LibC::Char*, conf : RdKafkaTopicConfT) : RdKafkaTopicT
  fun topic_destroy = rd_kafka_topic_destroy(rkt : RdKafkaTopicT)
  fun topic_name = rd_kafka_topic_name(rkt : RdKafkaTopicT) : LibC::Char*
  fun topic_opaque = rd_kafka_topic_opaque(rkt : RdKafkaTopicT) : Void*
  fun poll = rd_kafka_poll(rk : RdKafkaT, timeout_ms : LibC::Int) : LibC::Int
  fun yield = rd_kafka_yield(rk : RdKafkaT)
  fun pause_partitions = rd_kafka_pause_partitions(rk : RdKafkaT, partitions : TopicPartitionListT*) : RespErrT
  fun resume_partitions = rd_kafka_resume_partitions(rk : RdKafkaT, partitions : TopicPartitionListT*) : RespErrT
  fun query_watermark_offsets = rd_kafka_query_watermark_offsets(rk : RdKafkaT, topic : LibC::Char*, partition : Int32T, low : Int64T*, high : Int64T*, timeout_ms : LibC::Int) : RespErrT
  fun get_watermark_offsets = rd_kafka_get_watermark_offsets(rk : RdKafkaT, topic : LibC::Char*, partition : Int32T, low : Int64T*, high : Int64T*) : RespErrT
  fun mem_free = rd_kafka_mem_free(rk : RdKafkaT, ptr : Void*)
  fun queue_new = rd_kafka_queue_new(rk : RdKafkaT) : RdKafkaQueueT

  type RdKafkaQueueT = Void*

  fun queue_destroy = rd_kafka_queue_destroy(rkqu : RdKafkaQueueT)
  fun consume_start = rd_kafka_consume_start(rkt : RdKafkaTopicT, partition : Int32T, offset : Int64T) : LibC::Int
  fun consume_start_queue = rd_kafka_consume_start_queue(rkt : RdKafkaTopicT, partition : Int32T, offset : Int64T, rkqu : RdKafkaQueueT) : LibC::Int
  fun consume_stop = rd_kafka_consume_stop(rkt : RdKafkaTopicT, partition : Int32T) : LibC::Int
  fun seek = rd_kafka_seek(rkt : RdKafkaTopicT, partition : Int32T, offset : Int64T, timeout_ms : LibC::Int) : RespErrT
  fun consume = rd_kafka_consume(rkt : RdKafkaTopicT, partition : Int32T, timeout_ms : LibC::Int) : MessageT*
  fun consume_batch = rd_kafka_consume_batch(rkt : RdKafkaTopicT, partition : Int32T, timeout_ms : LibC::Int, rkmessages : MessageT**, rkmessages_size : LibC::SizeT) : SsizeT

  alias X__DarwinSsizeT = LibC::Long
  alias SsizeT = X__DarwinSsizeT

  fun consume_callback = rd_kafka_consume_callback(rkt : RdKafkaTopicT, partition : Int32T, timeout_ms : LibC::Int, consume_cb : (MessageT*, Void* -> Void), opaque : Void*) : LibC::Int
  fun consume_queue = rd_kafka_consume_queue(rkqu : RdKafkaQueueT, timeout_ms : LibC::Int) : MessageT*
  fun consume_batch_queue = rd_kafka_consume_batch_queue(rkqu : RdKafkaQueueT, timeout_ms : LibC::Int, rkmessages : MessageT**, rkmessages_size : LibC::SizeT) : SsizeT
  fun consume_callback_queue = rd_kafka_consume_callback_queue(rkqu : RdKafkaQueueT, timeout_ms : LibC::Int, consume_cb : (MessageT*, Void* -> Void), opaque : Void*) : LibC::Int
  fun offset_store = rd_kafka_offset_store(rkt : RdKafkaTopicT, partition : Int32T, offset : Int64T) : RespErrT
  fun subscribe = rd_kafka_subscribe(rk : RdKafkaT, topics : TopicPartitionListT*) : RespErrT
  fun unsubscribe = rd_kafka_unsubscribe(rk : RdKafkaT) : RespErrT
  fun subscription = rd_kafka_subscription(rk : RdKafkaT, topics : TopicPartitionListT**) : RespErrT
  fun consumer_poll = rd_kafka_consumer_poll(rk : RdKafkaT, timeout_ms : LibC::Int) : MessageT*
  fun consumer_close = rd_kafka_consumer_close(rk : RdKafkaT) : RespErrT
  fun assign = rd_kafka_assign(rk : RdKafkaT, partitions : TopicPartitionListT*) : RespErrT
  fun assignment = rd_kafka_assignment(rk : RdKafkaT, partitions : TopicPartitionListT**) : RespErrT
  fun commit = rd_kafka_commit(rk : RdKafkaT, offsets : TopicPartitionListT*, async : LibC::Int) : RespErrT
  fun commit_message = rd_kafka_commit_message(rk : RdKafkaT, rkmessage : MessageT*, async : LibC::Int) : RespErrT
  fun committed = rd_kafka_committed(rk : RdKafkaT, partitions : TopicPartitionListT*, timeout_ms : LibC::Int) : RespErrT
  fun position = rd_kafka_position(rk : RdKafkaT, partitions : TopicPartitionListT*) : RespErrT
  fun produce = rd_kafka_produce(rkt : RdKafkaTopicT, partition : Int32T, msgflags : LibC::Int, payload : Void*, len : LibC::SizeT, key : Void*, keylen : LibC::SizeT, msg_opaque : Void*) : LibC::Int
  fun produce_batch = rd_kafka_produce_batch(rkt : RdKafkaTopicT, partition : Int32T, msgflags : LibC::Int, rkmessages : MessageT*, message_cnt : LibC::Int) : LibC::Int

  struct MetadataBroker
    id : Int32T
    host : LibC::Char*
    port : LibC::Int
  end

  struct MetadataPartition
    id : Int32T
    err : RespErrT
    leader : Int32T
    replica_cnt : LibC::Int
    replicas : Int32T*
    isr_cnt : LibC::Int
    isrs : Int32T*
  end

  struct MetadataTopic
    topic : LibC::Char*
    partition_cnt : LibC::Int
    partitions : MetadataPartition*
    err : RespErrT
  end

  struct Metadata
    broker_cnt : LibC::Int
    brokers : MetadataBroker*
    topic_cnt : LibC::Int
    topics : MetadataTopic*
    orig_broker_id : Int32T
    orig_broker_name : LibC::Char*
  end

  fun metadata = rd_kafka_metadata(rk : RdKafkaT, all_topics : LibC::Int, only_rkt : RdKafkaTopicT, metadatap : Metadata**, timeout_ms : LibC::Int) : RespErrT
  fun metadata_destroy = rd_kafka_metadata_destroy(metadata : Metadata*)

  struct GroupMemberInfo
    member_id : LibC::Char*
    client_id : LibC::Char*
    client_host : LibC::Char*
    member_metadata : Void*
    member_metadata_size : LibC::Int
    member_assignment : Void*
    member_assignment_size : LibC::Int
  end

  struct GroupInfo
    broker : MetadataBroker
    group : LibC::Char*
    err : RespErrT
    state : LibC::Char*
    protocol_type : LibC::Char*
    protocol : LibC::Char*
    members : GroupMemberInfo*
    member_cnt : LibC::Int
  end

  struct GroupList
    groups : GroupInfo*
    group_cnt : LibC::Int
  end

  fun list_groups = rd_kafka_list_groups(rk : RdKafkaT, group : LibC::Char*, grplistp : GroupList**, timeout_ms : LibC::Int) : RespErrT
  fun group_list_destroy = rd_kafka_group_list_destroy(grplist : GroupList*)
  fun brokers_add = rd_kafka_brokers_add(rk : RdKafkaT, brokerlist : LibC::Char*) : LibC::Int
  fun set_logger = rd_kafka_set_logger(rk : RdKafkaT, func : (RdKafkaT, LibC::Int, LibC::Char*, LibC::Char* -> Void))
  fun set_log_level = rd_kafka_set_log_level(rk : RdKafkaT, level : LibC::Int)
  fun log_print = rd_kafka_log_print(rk : RdKafkaT, level : LibC::Int, fac : LibC::Char*, buf : LibC::Char*)
  fun log_syslog = rd_kafka_log_syslog(rk : RdKafkaT, level : LibC::Int, fac : LibC::Char*, buf : LibC::Char*)
  fun outq_len = rd_kafka_outq_len(rk : RdKafkaT) : LibC::Int
  fun dump = rd_kafka_dump(fp : File*, rk : RdKafkaT)
  fun thread_cnt = rd_kafka_thread_cnt : LibC::Int
  fun wait_destroyed = rd_kafka_wait_destroyed(timeout_ms : LibC::Int) : LibC::Int
  fun poll_set_consumer = rd_kafka_poll_set_consumer(rk : RdKafkaT) : RespErrT
end
