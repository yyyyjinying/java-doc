ZOO_TICK_TIME 
默认为2000。tickTime 
一个滴答的长度，这是ZooKeeper使用的基本时间单位，以毫秒为单位。它被用来调节心跳和暂停。例如，最小会话超时将是两个滴答 

ZOO_INIT_LIMIT 
默认值为5。initLimit
允许追随者连接并同步到领导者的时间量，单位为tick(参见tickTime)。如果ZooKeeper管理的数据量较大，可以根据需要增加该值。 
 
ZOO_SYNC_LIMIT 
默认值为2。syncLimit 
允许追随者与ZooKeeper同步的时间量，单位为tick(参见tickTime)。如果追随者远远落后于领导者，他们就会被抛弃。
