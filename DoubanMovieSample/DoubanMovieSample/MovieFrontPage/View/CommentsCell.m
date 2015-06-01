//
//  CommentsCell.m
//  DoubanMovieSample
//
//  Created by lzhr on 15/3/14.
//  Copyright (c) 2015年 lzhr. All rights reserved.
//

#import "CommentsCell.h"
#import "StarView.h"

@interface CommentsCell ()

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UIImageView *avatarView;
@property (nonatomic, retain) UILabel *contentLabel;
@property (nonatomic, retain) StarView *starView;

@end

@implementation CommentsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel release];
        
        self.avatarView = [[UIImageView alloc] init];
        _avatarView.layer.cornerRadius = 20;
        _avatarView.clipsToBounds = YES;
        [self.contentView addSubview:_avatarView];
        [_avatarView release];
        
        self.contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_contentLabel];
        
        self.starView = [[StarView alloc] init];
        [self.contentView addSubview:_starView];
        [_starView release];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.contentView.width;
    CGFloat height = 40;
    
    self.nameLabel.text = [[self.commentInfo objectForKey:@"author"] objectForKey:@"name"];
    self.nameLabel.frame = CGRectMake(5, 5, width, height);
    [self.nameLabel sizeToFit];
    [self.nameLabel changeHeight:height];
    
    
    
    self.starView.frame = CGRectMake(_nameLabel.frameX + _nameLabel.width + 5, 15, width / 4, height / 2);
    self.starView.rating = [[[self.commentInfo objectForKey:@"rating"] objectForKey:@"value"] floatValue];
    self.starView.starNumber = [[[self.commentInfo objectForKey:@"rating"] objectForKey:@"value"] integerValue] * 10;

    
    [self.avatarView setImageWithURLStr:[[self.commentInfo objectForKey:@"author"] objectForKey:@"avatar"]];
    self.avatarView.frame = CGRectMake(width - height - 5, 5, height, height);
    
    
    self.contentLabel.text = [self.commentInfo objectForKey:@"content"];
    self.contentLabel.frame = CGRectMake(5, 5 + 40 + 5, width - 10 , self.contentView.height - 40 - 5 - 5 + 1);
    [self.contentLabel sizeToFit];
    
}

- (void)dealloc
{
    [_contentLabel release];
    [_avatarView release];
    [_starView release];
    [_nameLabel release];
    [_commentInfo release];
    [super dealloc];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
