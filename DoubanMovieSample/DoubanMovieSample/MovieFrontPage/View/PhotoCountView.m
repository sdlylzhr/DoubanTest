//
//  PhotoCountView.m
//  DoubanMovieSample
//
//  Created by lzhr on 1PHOTO_COUNT/3/14.
//  Copyright (c) 201PHOTO_COUNT年 lzhr. All rights reserved.
//

#import "PhotoCountView.h"

#define PHOTO_COUNT 4

@interface PhotoCountView ()

@property (nonatomic, retain) UILabel *countLabel;
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;

@end


@implementation PhotoCountView

- (void)dealloc
{
    [_countLabel release];
    [_photosArr release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat length = frame.size.height - 10;
        
        for (NSInteger i = 0 ; i < PHOTO_COUNT; i++) {
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(PHOTO_COUNT + i * length, PHOTO_COUNT, length, length)];
            [self addSubview:imageView];
            [imageView release];
        }
        
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width - length - PHOTO_COUNT, PHOTO_COUNT, length, length)];
        self.countLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_countLabel];
        [_countLabel release];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
        [tap release];
        
        
    }
    return self;
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    if (self.target && [self.target respondsToSelector:self.action]) {
        
        [self.target performSelector:self.action withObject:self];
    }
}

- (void)addTarget:(id)target action:(SEL)action
{
    self.target = target;
    self.action = action;
}


- (void)setPhotosArr:(NSArray *)photosArr
{
    if (_photosArr != photosArr) {
        [_photosArr release];
        _photosArr = [photosArr retain];
    }
    
    
    NSInteger count = self.photosArr.count > PHOTO_COUNT ? PHOTO_COUNT:self.photosArr.count;
    
    for (NSInteger i = 0 ; i < count; i++) {
        
        UIImageView *imageView = [self.subviews objectAtIndex:i];
        
        [imageView setImageWithURLStr:[[self.photosArr objectAtIndex:i] objectForKey:@"icon"]];
    }
    
}


- (void)setPhotosCount:(NSInteger)photosCount
{
    _photosCount = photosCount;
    
    self.countLabel.text = [NSString stringWithFormat:@"%ld >", _photosCount];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
