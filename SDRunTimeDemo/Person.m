//
//  Person.m
//  SDRunTimeDemo
//
//  Created by shendong on 16/9/2.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
@interface Person ()
@property (nonatomic, copy) NSString *personalName;
@end
@implementation Person
- (instancetype)init{
    if (self = [super init]) {
        [self configureDefaultValue];
    }
    return self;
}
- (void)configureDefaultValue{
    self.name         = @"shendong";
    self.age          = @18;
    self.personalName = @"dadongge";
}
- (void)callPersonalInfo{
    NSLog(@"%@.name=%@, and age is %lu",self.class, self.name, [self.age integerValue]);
}
- (void)configureNewName:(NSString *)newName age:(NSNumber *)newAge{
    self.name = newName;
    self.age  = newAge;
    NSLog(@"%@.name=%@, and age is %lu",self.class, self.name, [self.age integerValue]);
}
//解档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int outcount = 0;
    Ivar *ivars = class_copyIvarList([self class], &outcount);
    for (int index = 0; index < outcount; index++) {
        Ivar ivar = ivars[index];
        NSString *key = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
    free(ivars);
}
//归档
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        unsigned int outcount = 0;
        Ivar *ivars = class_copyIvarList([self class], &outcount);
        for(int index = 0; index < outcount; index++){
            Ivar ivar = ivars[index];
            NSString *key = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
        }
        free(ivars);
    }
    return self;
}

@end
