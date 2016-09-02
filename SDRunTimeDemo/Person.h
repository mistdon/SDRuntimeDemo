//
//  Person.h
//  SDRunTimeDemo
//
//  Created by shendong on 16/9/2.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger age;

- (void)callPersonalInfo;
- (void)setPersonalName;
- (void)configureNewName:(NSString *)newname age:(NSUInteger)age;
@end
