//
//  ViewController.m
//  SDRunTimeDemo
//
//  Created by shendong on 16/9/2.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import "Person+newMethod.h"
#import "Person+newProperty.h"
#import <math.h>
#import "NSObject+JSONModel.h"


/*
 Notice:
     objc_msgSend()如果出现错误信息： Too many arguments to function call, excepected 0, have 2
     fix : Build Setting--> Apple LLVM 6.0 - Preprocessing--> Enable Strict Checking of objc_msgSend Calls  改为 NO
 */


@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self theLoopOfRuntime];  //消息发送机制

    [self dynamicAddNewProperties]; //动态添加属性
    
    [self dynamicGetProperties]; //动态获取属性

    [self dynamicAddNewMethod]; //动态添加方法
    
    [self methodSwizzling];  //方法置换
}
//! 发送消息的本质
- (void)theLoopOfRuntime{
    Person *mine = [Person new];
    //消息发送,以下三个方法的执行效果是一样的，体验一下
    [mine configureNewName:@"shendong" age:@20];
    [mine performSelector:@selector(configureNewName:age:) withObject:@"shendong" withObject:@20];
    objc_msgSend(mine, @selector(configureNewName:age:),@"shendong",@20);
    
    /*
     
     Objective-C 中给一个对象发送消息会经过以下几个步骤：
     
     在对象类的 dispatch table 中尝试找到该消息。如果找到了，跳到相应的函数IMP去执行实现代码；
     如果没有找到，Runtime 会发送 +resolveInstanceMethod: 或者 +resolveClassMethod: 尝试去 resolve 这个消息；
     如果 resolve 方法返回 NO，Runtime 就发送 -forwardingTargetForSelector: 允许你把这个消息转发给另一个对象；
     如果没有新的目标对象返回， Runtime 就会发送 -methodSignatureForSelector: 和 -forwardInvocation: 消息。你可以发送 -invokeWithTarget: 消息来手动转发消息或者发送 -doesNotRecognizeSelector: 抛出异常。
     利用 Objective-C 的 runtime 特性，我们可以自己来对语言进行扩展，解决项目开发中的一些设计和技术问题。下一篇文章，我会介绍 Method Swizzling 技术以及如何利用 Method Swizzling 做 Logging。
     
     */
}
//! 动态获取属性
- (void)dynamicAddNewProperties{
     Person *mine = [Person new];
    //动态添加属性
    [mine setHometown:@"gansu"];
    NSLog(@"hometown = %@",mine.hometown);
    [mine setFlag:YES];
    NSLog(@"isMan = %d",mine.flag);
    
    void(^tempBlock)(NSString *) = ^void(NSString *value){
        NSLog(@"add new text value = %@",value);
    };
    
    [mine setHandleBlock:tempBlock];
    mine.handleBlock(@"china");
}
//! 动态获取属性
- (void)dynamicGetProperties{
    NSDictionary *dict = @{@"name":@"shednong",
                           @"age":@20};
    Person *mine = [[Person alloc] initWithDict:dict];
    NSLog(@"mine = %@",mine);

    Ivar ivar = class_getInstanceVariable([mine class], "_personalName");
    //设置成员变量属性
    object_setIvar(mine, ivar, @"British");
    //访问成员变量
    NSString *value = object_getIvar(mine, ivar);
    NSLog(@"value= %@",value);
}
//! 动态添加方法
- (void)dynamicAddNewMethod{
    Person *mine = [Person new];
    [mine performSelector:@selector(fooMethod)];
}
- (void)methodSwizzling{
    Person *mine = [Person new];
    [mine callPersonalInfo];
}
@end
