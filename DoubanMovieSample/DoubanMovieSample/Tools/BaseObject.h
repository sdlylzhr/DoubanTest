//
//  BaseObject.h
//  DoubanMovieSample
//
//  Created by lzhr on 15/3/13.
//  Copyright (c) 2015年 lzhr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseObject : NSObject


- (instancetype)initWithDictionary:(NSDictionary *)dic;
+ (instancetype)objectWithDictionary:(NSDictionary *)dic;
+ (NSMutableArray *)modelArrWithDics:(NSMutableArray *)dicArr;

@end

