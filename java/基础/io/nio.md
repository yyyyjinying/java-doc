# Selector
Selector能够检测多个注册的通道上是否有事件发生(注意:多个Channel以事件的方式可以注册到同一个Selector)，如果有事件发生，便获取事件，然后针对每个事件进行相应的处理。这样就可以只用一个单线程去管理多个通道，也就是管理多个连接和请求。只有在 连接/通道 真正有读写事件发生时，才会进行读写，就大大地减少了系统开销，并且不必为每个连接都创建一个线程，不用去维护多个线程。
# NIO api的核心抽象
Buffers：缓冲区，是数据的容器; position:下一个要读或写的元素的索引; limit：第一个不应该读或写的元素的索引； clearing, flipping, and rewinding, for marking the current position, and for resetting the position to the previous mark（清除、翻转和倒回、标记当前位置以及将位置重置为前一个标记的方法）compacting, duplicating, and slicing a buffer,allocating a new buffer, wrapping an existing array(压缩，复制，分片，分配，数组包装),

Charsets and their associated decoders and encoders,
which translate between bytes and Unicode characters;字符集及其相关的解码器和编码器，在字节和Unicode字符之间转换;
各种类型的通道(Channels)：它们表示连接`能够执行I/O操作的实体`;
选择器和选择键(Selectors and selection keys):与可选通道一起定义了多路复用、非阻塞I/O设备。
java.nio包定义了在整个nio api中使用的缓冲类。字符集API定义在java.nio.charset包中, channel和selector API定义在java.nio.channels包中。这些子包中的每一个子包都有自己的服务提供者(SPI)子包，其中的内容可用于扩展平台的默认实现或构造替代实现。
SelectableChannel：
可以通过选择器进行多路复用的通道。为了与选择器一起使用，该类的实例必须首先通过register方法注册。该方法返回一个新的SelectionKey对象，该对象表示频道与选择器的注册。 一旦向选择器注册，通道将保持注册状态，直到取消注册。这涉及到释放选择器分配给通道的任何资源。不能直接注销通道;相反，必须取消代表其注册的键。取消键要求在选择器的下一个选择操作期间注销通道。可以通过调用键的cancel方法显式地取消键。当通道关闭时，通道的所有键都将隐式取消，无论是通过调用其close方法，还是通过中断在通道上的I/O操作中阻塞的线程。如果选择器本身被关闭，那么通道将被取消注册，表示其注册的键将无效，不再有进一步的延迟。 一个通道最多只能向任何特定的选择器注册一次。 通道是否向一个或多个选择器注册可以通过调用isRegistered方法来确定。 可选通道对于多个并发线程使用是安全的。

Selector：
选择器可以通过调用该类的open方法来创建，该方法将使用系统的默认选择器提供程序来创建一个新的选择器。还可以通过调用自定义选择器提供程序的openSelector方法来创建选择器。选择器一直保持打开状态，直到通过close方法关闭为止。 可选择通道在选择器上的注册由SelectionKey对象表示；

SelectionKey: 表示SelectableChannel注册到选择器的标记。
每次向选择器注册通道时，都会创建一个选择键。一个键在通过调用它的cancel方法、关闭它的通道或关闭它的选择器来取消它之前一直有效。取消一个键不会立即将其从选择器中移除;相反，它被添加到选择器的取消键集中，以便在下一个选择操作期间删除。一个键的有效性可以通过调用它的isValid方法来测试。 一个选择键包含两个用整数值表示的操作集。操作集的每一位表示键的通道支持的可选操作的类别。兴趣集决定在下次调用选择器的选择方法时测试哪些操作类别是否就绪。兴趣集在创建键时使用给定的值进行初始化;稍后可以通过interestOps(int)方法进行更改。就绪集标识由密钥选择器检测到密钥的通道已就绪的操作类别。创建键时，就绪集初始化为零;它可以稍后由选择器在选择操作期间更新，但不能直接更新
channel().返回为其创建此键的通道