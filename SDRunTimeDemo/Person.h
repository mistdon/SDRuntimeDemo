//
//  Person.h
//  SDRunTimeDemo
//
//  Created by shendong on 16/9/2.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *age;

- (void)callPersonalInfo;
- (void)setPersonalName;
- (void)configureNewName:(NSString *)newname age:(NSNumber *)age;
@end
