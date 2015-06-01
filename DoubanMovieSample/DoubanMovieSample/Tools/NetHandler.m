//
//  NetHandler.m
//  网络请求封装
//
//  Created by lzhr on 14/12/4.
//  Copyright (c) 2014年 www.lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "NetHandler.h"

@implementation NetHandler

+ (void)getDataWithUrl:(NSString *)str completion:(void (^)(NSData *))block
{
    
    NSString *urlStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    
    request.HTTPMethod = @"GET";
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSLog(@"%@", connectionError);
        // 处理数据
        // 确定地址
        
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        // 这里使用一个NSObject的方法-(NSUInteger)hash;获取一个字符串的哈希值, 当两个字符串完全一致的时候, 返回的哈希值是完全一样的, 每当有一点不同哈希值就完全不同.
        // 哈希值和MD5一样, 过程是不可逆的, 但是都可以产生同样的字符串返回的值是一样的结果.
        NSString *path = [NSString stringWithFormat:@"%@/%ld.aa", docPath, [str hash]];
        
        
        if (data != nil) {
            // 当返回的数据不是空, 就调用block.
            
            BOOL result = [NSKeyedArchiver archiveRootObject:data toFile:path];
            NSLog(@"存储成功: %d", result);
            
            NSLog(@"%@", path);
            block(data);
        } else {
            
            // 没有网络/请求失败 就从本地读取最近的一次成功数据
            NSData *pickData = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
            if (pickData != nil) {
                // 确保有数据才返回.
                block(pickData);
            }
        }
        
    }];

    
}








@end
