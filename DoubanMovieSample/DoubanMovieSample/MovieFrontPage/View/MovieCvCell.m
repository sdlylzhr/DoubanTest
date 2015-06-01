//
//  MovieCvCell.m
//  DoubanMovieSample
//
//  Created by lzhr on 15/3/13.
//  Copyright (c) 2015年 lzhr. All rights reserved.
//

#import "MovieCvCell.h"
#import "Movie.h"
#import "StarView.h"

@interface MovieCvCell ()

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) StarView *starsView;

@end

@implementation MovieCvCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView = [[UIImageView alloc] init];
//        _imageView.backgroundColor = TEST_IMAGECOLOR;
        [self.contentView addSubview:_imageView];
        [_imageView release];
        
        self.titleLabel = [[UILabel alloc] init];
//        _titleLabel.backgroundColor = TEST_LABELCOLOR;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
//        _titleLabel.text = TEST_TITLE;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel release];
        
        self.starsView = [[StarView alloc] init];
//        _starsView.backgroundColor = TEST_LABELCOLOR;
        [self.contentView addSubview:_starsView];
        [_starsView release];
        
        
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    CGFloat width = layoutAttributes.bounds.size.width - 10;
    CGFloat height = layoutAttributes.bounds.size.height - 10;
    
    CGFloat blank = layoutAttributes.bounds.size.height / 4;
    
    _imageView.frame = CGRectMake(5, 5, width, height - blank);
    
    _titleLabel.frame = CGRectMake(5, height - blank + 5, width, blank / 2);
    
    _starsView.frame = CGRectMake(15, height - blank + 5 + blank / 2, width - 20, blank / 2);
    
    
    
}

- (void)setMovie:(Movie *)movie
{
    if (_movie != movie) {
        [_movie release];
        _movie = [movie retain];
    }
    
    [_imageView setImageWithURLStr:self.movie.imagesLarge];
    _titleLabel.text = self.movie.title;
    _starsView.starNumber = _movie.stars;
    _starsView.rating = _movie.rating;
    
}

- (void)dealloc
{
    [_movie release];
    [_starsView release];
    [_imageView release];
    [_titleLabel release];
    [super dealloc];
}

@end
