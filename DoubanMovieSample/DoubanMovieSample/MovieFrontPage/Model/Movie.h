//
//  Movie.h
//  DoubanMovieSample
//
//  Created by lzhr on 15/3/13.
//  Copyright (c) 2015年 lzhr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"

@interface Movie : BaseObject

// 首页电影类model
@property (nonatomic, retain) NSString *movieId;

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *imagesLarge;
@property (nonatomic, assign) NSInteger stars;
@property (nonatomic, assign) CGFloat rating;

// 详情页面model
@property (nonatomic, assign) NSInteger wish_count;// 多少人想看
@property (nonatomic, assign) NSInteger collect_count;// 多少人评分
@property (nonatomic, retain) NSString *pubdate;


// 数据源: 数组, 处理为字符串
@property (nonatomic, retain) NSString *durations;// 和上映时间拼接
@property (nonatomic, retain) NSString *pub_Durations;// 上映时间/时长
@property (nonatomic, retain) NSString *countries;
@property (nonatomic, retain) NSString *genres;

// 剧照
@property (nonatomic, retain) NSArray *photos;// 只显示4-5个
@property (nonatomic, assign) NSInteger photos_count;// 图片总数

// 简介
@property (nonatomic, retain) NSString *summary;

// 演职人员信息
@property (nonatomic, retain) NSMutableArray *director_casts;// 要将两个数组拼接到一起.
@property (nonatomic, retain) NSMutableArray *directors;
@property (nonatomic, retain) NSMutableArray *casts;

// 评论
@property (nonatomic, retain) NSMutableArray *popular_comments;

@end
