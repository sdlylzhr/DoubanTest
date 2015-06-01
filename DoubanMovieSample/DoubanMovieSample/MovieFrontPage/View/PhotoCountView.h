//
//  PhotoCountView.h
//  DoubanMovieSample
//
//  Created by lzhr on 15/3/14.
//  Copyright (c) 2015年 lzhr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCountView : UIView

@property (nonatomic, retain) NSArray *photosArr;
@property (nonatomic, assign) NSInteger photosCount;

- (void)addTarget:(id)target action:(SEL)action;

@end
