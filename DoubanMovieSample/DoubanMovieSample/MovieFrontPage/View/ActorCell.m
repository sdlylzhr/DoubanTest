//
//  ActorCell.m
//  DoubanMovieSample
//
//  Created by lzhr on 15/3/14.
//  Copyright (c) 2015年 lzhr. All rights reserved.
//

#import "ActorCell.h"

@interface ActorCell ()

@property (nonatomic, retain) UIImageView *actorImageView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *enLabel;

@end

@implementation ActorCell

- (void)dealloc
{
    [_actorImageView release];
    [_nameLabel release];
    [_enLabel release];
    
    [_actorInfo release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.actorImageView = [[UIImageView alloc] init];
        _actorImageView.contentMode =  UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_actorImageView];
        [_actorImageView release];
        
        self.nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel release];
        
        self.enLabel = [[UILabel alloc] init];
        _enLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_enLabel];
        [_enLabel release];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.contentView.bounds.size.width;
    CGFloat height = self.contentView.bounds.size.height;
    self.actorImageView.frame = CGRectMake(5, 5, height - 10, height - 10);
    
    self.nameLabel.frame = CGRectMake(5 + height - 10 + 5, 5, width - height, height / 2 - 7);
    self.enLabel.frame = CGRectMake(_nameLabel.frameX, _nameLabel.frameY + _nameLabel.height + 5, _nameLabel.width, _nameLabel.height);
    
    if (![[self.actorInfo objectForKey:@"avatars"] isKindOfClass:[NSNull class]]) {
         [self.actorImageView setImageWithURLStr:[[self.actorInfo objectForKey:@"avatars"] objectForKey:@"large"]];
    }
   

    
    self.nameLabel.text = [self.actorInfo objectForKey:@"name"];
    self.enLabel.text = [self.actorInfo objectForKey:@"name_en"];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
