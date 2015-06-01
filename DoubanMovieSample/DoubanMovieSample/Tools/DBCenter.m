//
//  DBCenter.m
//  DoubanMovieSample
//
//  Created by lzhr on 15/3/17.
//  Copyright (c) 2015年 lzhr. All rights reserved.
//

#import "DBCenter.h"
#import "Movie.h"

@implementation DBCenter

+ (DBCenter *)shareInstance
{
    static DBCenter *center = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[DBCenter alloc] init];
        [center openDB];
        [center createMovieTable];
    });
    return center;
}

- (BOOL)openDB
{
    // 打开数据库
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *dbPath = [docPath stringByAppendingPathComponent:@"DoubanMovie.db"];
    NSLog(@"%@", dbPath);
    
    int result = sqlite3_open([dbPath UTF8String], &dbPoint);
    
    NSLog(@"打开数据库的结果: %d", result);
    
    return [self judgeResult:result type:@"打开数据库"];
}

// 关闭数据库
- (BOOL)closeDB
{
    int result = sqlite3_close(dbPoint);
    
    return [self judgeResult:result type:@"关闭数据库"];
}

- (BOOL)judgeResult:(int)result type:(NSString *)type
{
    if (result == SQLITE_OK) {
        NSLog(@"%@成功", type);
        return YES;
    } else {
        NSLog(@"%@失败, 失败编号: %d", type, result);
        return NO;
    }
}

- (BOOL)createMovieTable
{
    NSString *sqlStr = @"create table movie (movieId interger primary key, title text)";
    return [self helperWithSqlStr:sqlStr type:@"创建表"];
}
- (BOOL)insertMovie:(Movie *)movie
{
    NSString *sqlStr = [NSString stringWithFormat:@"insert into movie values(%@, '%@')", movie.movieId, movie.title];
    return [self helperWithSqlStr:sqlStr type:@"添加一条数据"];
}
- (NSMutableArray *)selectAllMovies
{
    // 查询所有的学生数据
    
    NSString *sqlStr = @"select * from movie";
    
    sqlite3_stmt *stmt = nil;
    
    int result = sqlite3_prepare(dbPoint, [sqlStr UTF8String], -1, &stmt, NULL);
    
    // 建立一个空数组, 用来装学生数据
    NSMutableArray *movieArr = [NSMutableArray array];
    if (result == SQLITE_OK) {
        
        // 遍历结果中的所有数据
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            // 每一条数据都对应一个student对象
            
            Movie *movie = [[Movie alloc] init];
            
            movie.movieId = [NSString stringWithFormat:@"%d", sqlite3_column_int(stmt, 0)];
            
            movie.title = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            
            [movieArr addObject:movie];
            [movie release];
        }
    }
    
    // 回收状态指针的内存, 将sql的改变结果保存到数据库.
    sqlite3_finalize(stmt);
    
    // 将数组返回
    return movieArr;
}
- (BOOL)isContainMovie:(Movie *)movie
{
    NSString *sqlStr = [NSString stringWithFormat:@"select * from movie where movieId = %@", movie.movieId];
    
    sqlite3_stmt *stmt = nil;
    
    int result = sqlite3_prepare(dbPoint, [sqlStr UTF8String], -1, &stmt, NULL);
    
    // 建立一个空数组, 用来装学生数据
    if (result == SQLITE_OK) {
        
        // 遍历结果中的所有数据
        while (sqlite3_step(stmt) == SQLITE_ROW) {
           
            sqlite3_finalize(stmt);
            
            return YES;
        }
    }
    sqlite3_finalize(stmt);
    
    return NO;
}

- (BOOL)helperWithSqlStr:(NSString *)sqlStr type:(NSString *)type
{
    int result = sqlite3_exec(dbPoint, [sqlStr UTF8String], NULL, NULL, NULL);
    
    return [self judgeResult:result type:type];
}

@end
