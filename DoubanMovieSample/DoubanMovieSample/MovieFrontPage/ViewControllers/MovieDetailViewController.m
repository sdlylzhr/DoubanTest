//
//  MovieDetailViewController.m
//  DoubanMovieSample
//
//  Created by lzhr on 15/3/13.
//  Copyright (c) 2015年 lzhr. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "PhotosViewController.h"

#import "StarView.h"
#import "PhotoCountView.h"
#import "ActorCell.h"
#import "CommentsCell.h"

#import "DBCenter.h"
#import "Movie.h"

#define ACTOR_REUSEID @"MovieActorReuseIdentifier"
#define COMMENT_REUSEID @"MovieCommentsReuseIndentifier"

@interface MovieDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UIScrollView *backScrollView;
@property (nonatomic, retain) UIImageView *postImageView;
@property (nonatomic, retain) StarView *starView;
@property (nonatomic, retain) UILabel *collectLabel;// 评分人数

@property (nonatomic, retain) UILabel *detailLabel;

@property (nonatomic, retain) PhotoCountView *photesView;
@property (nonatomic, retain) UILabel *summaryLabel;
@property (nonatomic, retain) UITableView *casts_commentsListView;

@property (nonatomic, assign, getter=isLabelExtend) BOOL labelExtend;

@end

@implementation MovieDetailViewController

- (void)dealloc
{
    [_backScrollView release];
    [_postImageView release];
    [_starView release];
    [_collectLabel release];
    [_detailLabel release];
    [_photesView release];
    [_summaryLabel release];
    [_casts_commentsListView release];
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.labelExtend = NO;
    
    [self handleNetData];
    [self setupViews];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


// 设置视图
- (void)setupViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [UILabel labelWithFrame:CGRectMake(0, 0, 100, 40) color:[UIColor clearColor] alignment:NSTextAlignmentCenter];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textColor = [UIColor whiteColor];
    label.text = self.movie.title;
    self.navigationItem.titleView = label;
    
    
    // 背景scrollView
    self.backScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    [self.backScrollView changeHeight:VIEW_HEIGHT - 64];
    [self.view addSubview:self.backScrollView];
    [_backScrollView release];
    
    // 海报
    self.postImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, VIEW_WIDTH / 3, VIEW_WIDTH / 3 * 1.5)];
    self.postImageView.layer.cornerRadius = 5;
    self.postImageView.clipsToBounds = YES;
    [self.backScrollView addSubview:self.postImageView];
    [_postImageView release];

    // 星星评分
    self.starView = [[StarView alloc] initWithFrame:CGRectMake(_postImageView.width + _postImageView.frameX + 5, _postImageView.frameY, VIEW_WIDTH / 3 - 30, 40)];
    
    [self.backScrollView addSubview:self.starView];
    [_starView release];
    
    // 多少人点评
    self.collectLabel = [UILabel labelWithFrame:CGRectMake(_starView.frameX + _starView.width + 5, _starView.frameY, VIEW_WIDTH / 3, 40) color:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
    _collectLabel.font = [UIFont systemFontOfSize:14];
    [self.backScrollView addSubview:_collectLabel];
    
    // 电影信息
    self.detailLabel = [UILabel labelWithFrame:CGRectMake(_postImageView.frameX + _postImageView.width + 5, _starView.frameY + _starView.height + 5, VIEW_WIDTH - _postImageView.width - 30, 90) color:[UIColor whiteColor] alignment:NSTextAlignmentLeft];
    self.detailLabel.numberOfLines = 3;
    [self.backScrollView addSubview:_detailLabel];
//    [_detailLabel release];
    
    
    // 购买
    UIButton *buyBtn = [UIButton buttonWithTitle:@"购票" frame:CGRectMake(_postImageView.frameX + _postImageView.width + 5, _detailLabel.frameY + _detailLabel.height + 10, _detailLabel.width - 50, _postImageView.height - _detailLabel.frameY - _detailLabel.height - 3) target:nil action:nil];
    buyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn setBackgroundImage:[[UIImage imageNamed:@"ticket_pay_button@2x.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 5, 10, 5) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
    [self.backScrollView addSubview:buyBtn];
    
    
    
    UIImage *btnImage = [[UIImage imageNamed:@"ticket_cancel_button@2x.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 2, 5, 2) resizingMode:UIImageResizingModeStretch];
    
    UIButton *wantBtn = [UIButton buttonWithTitle:@"我想看" frame:CGRectMake(10, _postImageView.frameY + _postImageView.height + 10, (VIEW_WIDTH - 30) / 2, 40) target:nil action:nil];
    [wantBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [wantBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
    [self.backScrollView addSubview:wantBtn];
    
    UIButton *seenBtn = [UIButton buttonWithTitle:@"看过了" frame:CGRectMake(10 + wantBtn.width + 10, wantBtn.frameY, wantBtn.width, wantBtn.height) target:nil action:nil];
    [seenBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [seenBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
    [self.backScrollView addSubview:seenBtn];
    
    
    self.photesView = [[PhotoCountView alloc] initWithFrame:CGRectMake(5, _postImageView.frameY + _postImageView.height + 5 + 50, VIEW_WIDTH - 10, 80)];
    [self.photesView addTarget:self action:@selector(photosViewAction:)];
    self.photesView.backgroundColor = [UIColor whiteColor];
    [self.backScrollView addSubview:_photesView];
    [_photesView release];
    
    self.summaryLabel = [UILabel labelWithFrame:CGRectMake(10, _photesView.frameY + _photesView.height + 5, VIEW_WIDTH - 20, _photesView.height) color:[UIColor whiteColor] alignment:NSTextAlignmentLeft];
    _summaryLabel.userInteractionEnabled = YES;
    _summaryLabel.numberOfLines = 0;
    _summaryLabel.font = [UIFont systemFontOfSize:14];
    [self.backScrollView addSubview:_summaryLabel];
//    [_summaryLabel release];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_summaryLabel addGestureRecognizer:tap];
    [tap release];
    
    self.casts_commentsListView = [[UITableView alloc] initWithFrame:CGRectMake(5, _summaryLabel.frameY + _summaryLabel.height + 5, VIEW_WIDTH - 10, 0) style:UITableViewStylePlain];
    
    self.casts_commentsListView.dataSource = self;
    self.casts_commentsListView.delegate = self;
    _casts_commentsListView.scrollEnabled = NO;
    [self.backScrollView addSubview:_casts_commentsListView];
    [_casts_commentsListView release];
    [_casts_commentsListView registerClass:[ActorCell class] forCellReuseIdentifier:ACTOR_REUSEID];
    [_casts_commentsListView registerClass:[CommentsCell class] forCellReuseIdentifier:COMMENT_REUSEID];
    
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(saveMovie)] autorelease];
    
}

- (void)saveMovie
{
    [[DBCenter shareInstance] insertMovie:self.movie];
}

// 点击推出剧照页面
- (void)photosViewAction:(PhotoCountView *)photosView
{
    PhotosViewController *pVC = [[PhotosViewController alloc] init];
    pVC.movie = self.movie;
    
    [self.navigationController pushViewController:pVC animated:YES];
    [pVC release];
}

// 点击伸缩电影简介的label
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    if (self.isLabelExtend) {
        [self.summaryLabel changeHeight:80];
    } else {
        CGRect rect = [self.movie.summary boundingRectWithSize:CGSizeMake(VIEW_WIDTH - 20, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        [self.summaryLabel changeHeight:rect.size.height];
    }
    self.labelExtend = !self.isLabelExtend;
    [self resetAllFrame];
}

// 设置所有视图的值.
- (void)setupViewValues
{
    [self.postImageView setImageWithURLStr:self.movie.imagesLarge];
    self.starView.starNumber = self.movie.stars;
    self.starView.rating = self.movie.rating;
    self.collectLabel.text = [NSString stringWithFormat:@"%ld人评分", self.movie.collect_count];
    self.detailLabel.text = [NSString stringWithFormat:@"%@\n%@\n%@\n", self.movie.pub_Durations, self.movie.countries, self.movie.genres];
    self.summaryLabel.text = self.movie.summary;
    
    self.photesView.photosArr = self.movie.photos;
    self.photesView.photosCount = self.movie.photos_count;
    
    
    NSLog(@"%@", self.movie.genres);
}

// 重置所有视图的frame
- (void)resetAllFrame
{
    [self.casts_commentsListView changeHeight:self.casts_commentsListView.contentSize.height];
    [self.casts_commentsListView changeFrameY:_summaryLabel.frameY + _summaryLabel.height + 5];
    self.backScrollView.contentSize = CGSizeMake(0, _casts_commentsListView.frameY + _casts_commentsListView.height);
}

#pragma mark - tableView的协议方法们

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 两个分区, 分别是演员和评论
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.movie.director_casts.count;
    }
    return self.movie.popular_comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // DETAILCELLREUSEID
    if (indexPath.section == 0) {
        
        // 演员cell
        ActorCell *cell = [tableView dequeueReusableCellWithIdentifier:ACTOR_REUSEID];
        
        cell.actorInfo = [self.movie.director_casts objectAtIndex:indexPath.row];
        
        return cell;
    }
    
    // 评论cell
    CommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:COMMENT_REUSEID];
    
    cell.commentInfo = [self.movie.popular_comments objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        NSDictionary *dic = [self.movie.popular_comments objectAtIndex:indexPath.row];
        
        NSString *str = [dic objectForKey:@"content"];
        
        CGRect rect = [str boundingRectWithSize:CGSizeMake(VIEW_WIDTH - 20 , 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil];
        NSLog(@"%f", rect.size.height);
        return rect.size.height + 40 + 5 + 5 + 5;
        
    } else  {
        
        return 100;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// 读取网络数据
- (void)handleNetData
{
    NSString *movieDetailURLStr = [NSString stringWithFormat:@"http://api.douban.com/v2/movie/subject/%@?alt=json&apikey=0df993c66c0c636e29ecbb5344252a4a&app_name=doubanmovie&city=大连&client=e:iPhone6,2|y:iPhone OS_8.2|s:mobile|f:doubanmovie_2|v:3.6.3|m:豆瓣电影|udid:bc9212587dcf81d5cfb16d596310d74a6538f699&udid=bc9212587dcf81d5cfb16d596310d74a6538f699&version=2", self.movie.movieId];
    NSLog(@"%@", movieDetailURLStr);
    [NetHandler getDataWithUrl:movieDetailURLStr completion:^(NSData *data) {
        NSDictionary *movieDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        [self.movie setValuesForKeysWithDictionary:movieDic];
        [self setupViewValues];
        [self.casts_commentsListView reloadData];
        [self resetAllFrame];
        NSLog(@"%@", self.movie.director_casts);
    }];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
