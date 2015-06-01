//
//  DBCenter.h
//  DoubanMovieSample
//
//  Created by lzhr on 15/3/17.
//  Copyright (c) 2015年 lzhr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@class Movie;

@interface DBCenter : NSObject
{
    sqlite3 *dbPoint;
}

+ (DBCenter *)shareInstance;

- (BOOL)openDB;
- (BOOL)closeDB;

- (BOOL)createMovieTable;
- (BOOL)insertMovie:(Movie *)movie;
- (NSMutableArray *)selectAllMovies;
- (BOOL)isContainMovie:(Movie *)movie;

@end
