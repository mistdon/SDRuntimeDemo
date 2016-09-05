//
//  NSObject+JSONModel.m
//  SDRunTimeDemo
//
//  Created by shendong on 16/9/5.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import "NSObject+JSONModel.h"
#import <objc/runtime.h>
@implementation NSObject (JSONModel)
//模型转换()
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [self init]) {
        //1.获取类的属性及属性对应的类型
        NSMutableArray *keys       = [NSMutableArray array];
        NSMutableArray *attributes = [NSMutableArray array];
        //2.获取类的属性列表
        unsigned int count = 0;
        objc_property_t *properties = class_copyPropertyList([self class], &count);
        for ( unsigned int index = 0; index < count; index++) {
            objc_property_t property = properties[index];
            NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            [keys addObject:propertyName];
            
            NSString *propertyAttributes = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
            [attributes addObject:propertyAttributes];
            NSLog(@"propertyname = %@, attributes=%@",propertyName, propertyAttributes);
        }
        free(properties);
        //3.赋值
        for (NSString *key in keys) {
            if ([dict valueForKey:key] == nil) continue;
            [self setValue:[dict valueForKey:key] forKey:key];
        }
    }
    return self;
}


@end
