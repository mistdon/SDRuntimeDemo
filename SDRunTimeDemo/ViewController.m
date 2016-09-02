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
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person *mine = [Person new];
    [mine callPersonalInfo];
/*
   objc_msgSend()如果出现错误信息： Too many arguments to function call, excepected 0, have 2
   fix : Build Setting--> Apple LLVM 6.0 - Preprocessing--> Enable Strict Checking of objc_msgSend Calls  改为 NO
 */
//    objc_msgSend(mine, @selector(setPersonalName));
    objc_msgSend(mine, @selector(configureNewName:age:),@"sddd",20);
    
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
    
    [mine anotherMethod];
    
    //动态添加方法
    [mine performSelector:@selector(fooMethod)];
    
    //获取类目信息
//    char *name = class_getName([mine class]);
//    NSLog(@"class.name = %s",name);
//    //获取类下面所有的成员变量
//    unsigned int count = 0;
//    Class newClass = clas
//    Ivar *ivars = class_copyIvarList(name, &count);
//    for (int index = 0; index< count; index++) {
//        Ivar ivar = ivars[index];
//        NSLog(@"instance vaiable = %s at index = %d",ivar_getName(ivar),index);
//    }
    
    double value = -2.3;
    NSLog(@"fbsa = %lf", fabs(value));
}


@end
