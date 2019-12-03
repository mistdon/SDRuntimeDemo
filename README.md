# SDRuntimeDemo

### - Runtime

runtime(简称运行时), 是一套由C语言编写的API，是Objective-C作为一门动态语言的核心；Objc将静态语言在编译和链接时候的工作，放在了runtime运行时处理。

首先来看一个objc_class的结构：

```c
/* 
 *	Class Template
 */
struct objc_class {			
	struct objc_class *isa;	
	struct objc_class *super_class;	
	const char *name;		
	long version;
	long info;
	long instance_size;
	struct objc_ivar_list *ivars;

#if defined(Release3CompatibilityBuild)
	struct objc_method_list *methods;
#else
	struct objc_method_list **methodLists;
#endif

	struct objc_cache *cache;
 	struct objc_protocol_list *protocols;
};
```

可以看到一个objc_class包含了

* isa指针
* super_calss指针
* version， info， instance_size信息
* ivars实例变量列表
* methods和methosLists方法列表
* cache缓存
* protocols协议列表


```
//消息发送,以下三个方法的执行效果是一样的，体验一下
 [mine configureNewName:@"shendong" age:@20];

 [mine performSelector:@selector(configureNewName:age:) withObject:@"shendong" withObject:@20];

 objc_msgSend(mine, @selector(configureNewName:age:),@"shendong",@20);
```

### - 消息发送机制

Objective-C 中给一个对象发送消息会经过以下几个步骤：

1. 在对象类的 *dispatch table* 中尝试找到该消息。如果找到了，跳到相应的函数IMP去执行实现代码；  

2. 如果没有找到，Runtime 会发送 +resolveInstanceMethod:或者 +resolveClassMethod:尝试去 resolve 这个消息；  

3. 如果 resolve 方法返回 NO，Runtime 就发送 -forwardingTargetForSelector: 允许你把这个消息转发给另一个对象；  

4. 如果没有新的目标对象返回， Runtime 就会发送 -methodSignatureForSelector:和 -forwardInvocation:消息；  

5. 你可以发送 -invokeWithTarget:消息来手动转发消息或者发送 -doesNotRecognizeSelector:抛出异常。

### - 应用   

利用 Objective-C 的 runtime 特性，我们可以自己来对语言进行扩展，解决项目开发中的一些设计和技术问题。

### - Code list

1.  消息发送机制
2. 动态添加属性
3. 动态获取属性
4. 动态添加方法
5. Method Swizzling
...

### - Links

- [objc4源码地址](https://github.com/opensource-apple/objc4)