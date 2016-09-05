# SDRuntimeDemo
```
//消息发送,以下三个方法的执行效果是一样的，体验一下
 [mine configureNewName:@"shendong" age:@20];

 [mine performSelector:@selector(configureNewName:age:) withObject:@"shendong" withObject:@20];

 objc_msgSend(mine, @selector(configureNewName:age:),@"shendong",@20);
```

###runtime msg_send的流程

Objective-C 中给一个对象发送消息会经过以下几个步骤：
(1). 在对象类的 *dispatch table* 中尝试找到该消息。如果找到了，跳到相应的函数IMP去执行实现代码；  
(2). 如果没有找到，Runtime 会发送 +resolveInstanceMethod:或者 +resolveClassMethod:尝试去 resolve 这个消息；  
(3). 如果 resolve 方法返回 NO，Runtime 就发送 -forwardingTargetForSelector: 允许你把这个消息转发给另一个对象；  
(4). 如果没有新的目标对象返回， Runtime 就会发送 -methodSignatureForSelector:和 -forwardInvocation:消息；  
   你可以发送 -invokeWithTarget:消息来手动转发消息或者发送 -doesNotRecognizeSelector:抛出异常。   

利用 Objective-C 的 runtime 特性，我们可以自己来对语言进行扩展，解决项目开发中的一些设计和技术问题。

###code list
1.  消息发送机制
2. 动态添加属性
3. 动态获取属性
4. 动态添加方法
5. Method Swizzling
...