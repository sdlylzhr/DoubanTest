//
//  UILabel+InitLabel.m
//  DoubanMovieSample
//
//  Created by lzhr on 15/3/13.
//  Copyright (c) 2015年 lzhr. All rights reserved.
//

#import "UILabel+InitLabel.h"

@implementation UILabel (InitLabel)

+ (instancetype)labelWithFrame:(CGRect)frame color:(UIColor *)color alignment:(NSTextAlignment)alignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    
    label.backgroundColor = color;
    
    label.textAlignment = alignment;
    
    return [label autorelease];
}


@end
