//
//  NSObject+ZJExtension.m
//  ZJArchive
//
//  Created by ad on 17/7/17.
//  Copyright © 2017年 zjhcsoftios. All rights reserved.
//

#import "NSObject+ZJExtension.h"
#import <objc/message.h>

@implementation NSObject (ZJExtension)

//  归档必须实现
-(void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count = 0;
    // 获取对象属性数组
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        // 取出属性名称
        const char * name = ivar_getName(ivar);
        // 转成nsstring 转成key
        NSString *KEY = [NSString stringWithUTF8String:name];
        // 归档
        [aCoder encodeObject:[self valueForKey:KEY] forKey:KEY];
    }
    free(ivars);
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if ([self init]) {
        unsigned int count = 0;
        // 获取对象属性数组
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            // 取出属性名称
            const char * name = ivar_getName(ivar);
            // 转成nsstring 转成key
            NSString *KEY = [NSString stringWithUTF8String:name];
            // 解档
            id value = [aDecoder decodeObjectForKey:KEY];
            if (value) {
                // 设置到自己的属性上去
                [self setValue:value forKey:KEY];
            }
        }
    }
    return self;
}


@end
