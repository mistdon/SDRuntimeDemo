//
//  Person+newMethod.h
//  SDRunTimeDemo
//
//  Created by shendong on 16/9/2.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import "Person.h"

@interface Person (newMethod)

- (void)anotherMethod; //分类中可以直接添加方法，但不能直接添加属性


//动态添加方法

@end
