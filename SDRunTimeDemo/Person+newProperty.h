//
//  Person+newProperty.h
//  SDRunTimeDemo
//
//  Created by shendong on 16/9/2.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import "Person.h"

@interface Person (newProperty)

@property (nonatomic, copy) NSString *hometown;
@property (nonatomic, assign) BOOL flag;
@property (nonatomic, copy) void(^handleBlock)(NSString *text);
@end

/*
  runtime 为类增加新属性的方法，基本就是几下几点
 1.  声明文件中添加属性
 2.  实现文件中声明新增的属性需要自己实现setter和getter方法 @dynamic
 3.  利用runtime的objc_setAssociatedObject 和  objc_getAssociatedObject 方法实现setter和getter方法. 其中必须设置一个指针，作为查询的依据
 
 notice: category不能直接添加属性，但是可以直接添加方法

*/