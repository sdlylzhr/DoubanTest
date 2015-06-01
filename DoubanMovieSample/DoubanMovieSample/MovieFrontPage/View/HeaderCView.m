//
//  HeaderCView.m
//  DoubanMovieSample
//
//  Created by lzhr on 15/3/14.
//  Copyright (c) 2015年 lzhr. All rights reserved.
//

#import "HeaderCView.h"

@interface HeaderCView ()

@property (nonatomic, retain) UIImageView *adImageView;

@end

@implementation HeaderCView

- (void)dealloc
{
    [_adImageView release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.adImageView = [[UIImageView alloc] init];

        [self addSubview:_adImageView];
        [_adImageView release];
        
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.adImageView.frame = layoutAttributes.bounds;
    
    [NetHandler getDataWithUrl:@"http://api.douban.com/v2/movie/app_sticky?alt=json&apikey=0df993c66c0c636e29ecbb5344252a4a&app_name=doubanmovie&city=大连&client=e:iPhone6,2|y:iPhone OS_8.2|s:mobile|f:doubanmovie_2|v:3.6.3|m:豆瓣电影|udid:d18a6cc8ac440a9d31f32fa5fe3ccfd675579c07&udid=d18a6cc8ac440a9d31f32fa5fe3ccfd675579c07&version=2" completion:^(NSData *data) {
       
        NSError *error = nil;
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        NSString *imageURL = [[[[result objectForKey:@"entries"] lastObject] objectForKey:@"new_images"] objectForKey:@"extreme"];
        
        
        [self.adImageView setImageWithURLStr:imageURL];
        
        
    }];
    
}



@end
