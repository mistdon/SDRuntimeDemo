//
//  Person+newMethod.m
//  SDRunTimeDemo
//
//  Created by shendong on 16/9/2.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import "Person+newMethod.h"
#import <objc/runtime.h>
@implementation Person (newMethod)
#pragma mark - 分类中直接添加方法

/*
 在使用method swizzling的过程中，应该保证以下两点
 1. Swizzling 应该总是被保证只执行一次
 2. Swizzling 应该被多线程保护 dispatch_once
 */
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSEL = @selector(callPersonalInfo);
        Method  originalMethod = class_getInstanceMethod([self class], originalSEL);
        
        SEL customSEL = @selector(resetPersonnalinfomation);
        Method customMethod = class_getInstanceMethod([self class], customSEL);
        
        BOOL success = class_addMethod([self class], originalSEL, method_getImplementation(customMethod), method_getTypeEncoding(customMethod));
        if (success) {
            class_replaceMethod([self class], customSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else{
            method_exchangeImplementations(originalMethod, customMethod);
        }
    });
}

- (void)anotherMethod{
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - 分类中动态添加方法
void fooMethod(id obj, SEL _cmd){
    NSLog(@"Doing foo method");
}
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if (sel == @selector(fooMethod)) {
        BOOL isSuccess = class_addMethod(self, sel, (IMP)fooMethod, "v@:@");
        return isSuccess;
    }
    return [super resolveInstanceMethod:sel];
}
#pragma mark - method swizzling -
- (void)resetPersonnalinfomation{
    self.name         = @"jack bid dan ";
    self.age          = @108;
    [self setValue:@"NewYord" forKey:@"personalName"];
    NSLog(@"Swizzling :%@.name=%@, and age is %lu",self.class, self.name, [self.age integerValue]);
    Ivar ivar = class_getInstanceVariable([self class], "personalName");
    NSString *value = object_getIvar(self, ivar);
    NSLog(@"personalName = %@",[self valueForKey:@"personalName"]);
}

@end
