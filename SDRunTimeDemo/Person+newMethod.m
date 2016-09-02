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
@end
