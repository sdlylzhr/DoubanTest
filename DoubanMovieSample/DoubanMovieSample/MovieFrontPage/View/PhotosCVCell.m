//
//  PhotosCVCell.m
//  DoubanMovieSample
//
//  Created by lzhr on 15/3/16.
//  Copyright (c) 2015年 lzhr. All rights reserved.
//

#import "PhotosCVCell.h"
#import "Photo.h"

@interface PhotosCVCell () <UIScrollViewDelegate>

@property (nonatomic, retain) UIImageView *photoImgV;
@property (nonatomic, retain) UIScrollView *backScrollView;

@end

@implementation PhotosCVCell

- (void)dealloc
{
    [_photo release];
    [_photoImgV release];
    [_backScrollView release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backScrollView = [[UIScrollView alloc] init];
        self.backScrollView.backgroundColor = [UIColor whiteColor];
        self.backScrollView.delegate = self;
        self.backScrollView.maximumZoomScale = 2.0;
        self.backScrollView.minimumZoomScale = 1.0;
        self.backScrollView.userInteractionEnabled = NO;
        self.backScrollView.showsHorizontalScrollIndicator = NO;
        self.backScrollView.showsVerticalScrollIndicator = NO;
        [self.contentView addSubview:self.backScrollView];
        [_backScrollView release];
        
        
        self.photoImgV = [[UIImageView alloc] init];
        _photoImgV.contentMode = UIViewContentModeScaleAspectFill;
        _photoImgV.clipsToBounds = YES;
        [self.contentView addSubview:_photoImgV];
        [self.backScrollView addSubview:_photoImgV];
        [_photoImgV release];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.backScrollView.frame = layoutAttributes.bounds;
    self.photoImgV.frame = CGRectMake(5, 5, layoutAttributes.bounds.size.width - 10, layoutAttributes.bounds.size.height - 10);
}

- (void)setPhoto:(Photo *)photo
{
    if (_photo != photo) {
        [_photo release];
        _photo = [photo retain];
    }
    [self.photoImgV setImageWithURLStr:_photo.image];
}

- (void)setMode:(PhotosCVCellMode)mode
{
    _mode = mode;
    self.backScrollView.zoomScale = 1.0;
    if (mode == PhotosCVCellModeMax) {
        self.backScrollView.userInteractionEnabled = YES;
        self.photoImgV.contentMode = UIViewContentModeScaleAspectFit;
        self.backScrollView.backgroundColor = [UIColor blackColor];
    } else {
        self.backScrollView.userInteractionEnabled = NO;
        self.photoImgV.contentMode = UIViewContentModeScaleAspectFill;
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [self.backScrollView.subviews firstObject];
}



@end
