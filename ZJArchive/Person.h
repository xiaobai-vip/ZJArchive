//
//  Person.h
//  ZJArchive
//
//  Created by ad on 17/7/17.
//  Copyright © 2017年 zjhcsoftios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

/// 姓名
@property (nonatomic,strong) NSString *name;
/// 年龄
@property (nonatomic,assign) int age;
/// 身高
@property (nonatomic,assign) int height;

@end
