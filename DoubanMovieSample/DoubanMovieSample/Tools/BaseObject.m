//
//  BaseObject.m
//  DoubanMovieSample
//
//  Created by lzhr on 15/3/13.
//  Copyright (c) 2015年 lzhr. All rights reserved.
//

#import "BaseObject.h"

@implementation BaseObject


- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (NSMutableArray *)modelArrWithDics:(NSMutableArray *)dicArr
{
    
    NSMutableArray *moviesArr = [NSMutableArray array];
    for (NSDictionary *movieDic in dicArr) {
        
        @autoreleasepool {
            if ([movieDic isKindOfClass:[NSDictionary class]]) {
                
                id movie = [[self class] objectWithDictionary:movieDic];
                
                [moviesArr addObject:movie];
            } else {
                NSLog(@"不符合方法要求, 请检查数据源"
                      "参数中的所有元素都必须是电影的字典信息");
            }
        }
    }
    
    if (moviesArr.count == 0) {
        NSLog(@"数组个数为空, 请检查数据源");
    }
    
    
    return moviesArr;
}

+ (instancetype)objectWithDictionary:(NSDictionary *)dic
{
    id object = [[[self class] alloc] initWithDictionary:dic];
    return [object autorelease];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

- (void)dealloc
{
    [super dealloc];
}

@end
