//
//  Person.m
//  SDRunTimeDemo
//
//  Created by shendong on 16/9/2.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import "Person.h"

@implementation Person
- (instancetype)init{
    if (self = [super init]) {
        _name = @"shendong";
        _age  = 18;
    }
    return self;
}
- (void)callPersonalInfo{
    NSLog(@"%@.name=%@, and age is %lu",self.class, self.name, self.age);
}
- (void)configureNewName:(NSString *)newName age:(NSUInteger)newAge{
    self.name = newName;
    self.age = newAge;
    NSLog(@"%@.name=%@, and age is %lu",self.class, self.name, self.age);
}

@end
