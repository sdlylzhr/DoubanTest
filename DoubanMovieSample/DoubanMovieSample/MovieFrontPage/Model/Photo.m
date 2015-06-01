//
//  Photo.m
//  DoubanMovieSample
//
//  Created by lzhr on 15/3/16.
//  Copyright (c) 2015年 lzhr. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
     
        NSArray *arr = [dic objectForKey:@"link"];
        
        for (NSDictionary *tempDic in arr) {
            
            NSString *key = [tempDic objectForKey:@"@rel"];
            NSString *value = [tempDic objectForKey:@"@href"];
            
            [self setValue:value forKey:key];
            
        }
    }
    return self;
}

- (void)dealloc
{
    [_image release];
    [_cover release];
    [_icon release];
    [_thumb release];
    [super dealloc];
}

@end
