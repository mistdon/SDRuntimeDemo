//
//  Person+newProperty.m
//  SDRunTimeDemo
//
//  Created by shendong on 16/9/2.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import "Person+newProperty.h"
#import <objc/runtime.h>

static void *hometownkey    = &hometownkey;
static void *isManKey       = &isManKey;
static void *handleBlockKey = &handleBlockKey;

@implementation Person (newProperty)

@dynamic hometown; //不由系统实现set和get方法，而是手动实现。@synthesize由系统实现
@dynamic flag;
@dynamic handleBlock;

- (void)setHometown:(NSString *)hometown{
    objc_setAssociatedObject(self, &hometownkey, hometown, OBJC_ASSOCIATION_COPY_NONATOMIC);
    /* objc_AssociationPolicy决定了新增实例变量的属性
     分别对应 assign, weak, strong, copy / nonatomic, atomic
     */
}
- (NSString *)hometown{
    return objc_getAssociatedObject(self, &hometownkey);
}
- (BOOL)flag{
    return  objc_getAssociatedObject(self, &isManKey);
}
- (void)setFlag:(BOOL)flag{
    objc_setAssociatedObject(self, &isManKey, @(flag), OBJC_ASSOCIATION_ASSIGN);
    //添加基本数据类型时，需要将所传值转换成oc类型，如上：@(flag)
}
- (void)setHandleBlock:(void (^)(NSString *))handleBlock{
    objc_setAssociatedObject(self, &handleBlockKey, handleBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void(^)(NSString *))handleBlock{
    return objc_getAssociatedObject(self, &handleBlockKey);
}
@end
