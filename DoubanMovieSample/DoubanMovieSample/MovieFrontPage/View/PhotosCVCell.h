//
//  PhotosCVCell.h
//  DoubanMovieSample
//
//  Created by lzhr on 15/3/16.
//  Copyright (c) 2015年 lzhr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PhotosCVCellModeMin,
    PhotosCVCellModeMax,
} PhotosCVCellMode;

@class Photo;

@interface PhotosCVCell : UICollectionViewCell

@property (nonatomic, retain) Photo *photo;
@property (nonatomic, assign) PhotosCVCellMode mode;

@end
