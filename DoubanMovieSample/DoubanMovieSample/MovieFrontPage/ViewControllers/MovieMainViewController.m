//
//  MovieMainViewController.m
//  DoubanMovieSample
//
//  Created by lzhr on 15/3/13.
//  Copyright (c) 2015年 lzhr. All rights reserved.
//

#import "MovieMainViewController.h"
#import "MovieDetailViewController.h"

#import "MovieCvCell.h"
#import "HeaderCView.h"

#import "Movie.h"

#define REUSEID @"movieFrontPageReuseIdentifier"
#define HEADER_REUSEID @"movieFrontPageCollectionViewHeaderReuseIdentifier"

@interface MovieMainViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *sourceArr;

@end

@implementation MovieMainViewController

- (void)dealloc
{
    [_collectionView release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self handleData];
//    Kryptonite
    // kryptonite kryptonite
    
//    self.navigationController.navigationBar.translucent = NO;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat sizeW = (VIEW_WIDTH - 7 - 7) / 3;
    flowLayout.itemSize = CGSizeMake(sizeW, sizeW / 2 * 4);
    flowLayout.headerReferenceSize = CGSizeMake(VIEW_WIDTH, 80);
    
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 7, 0, 7);
    flowLayout.minimumLineSpacing = 20;
    flowLayout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    [_collectionView release];
    
    [_collectionView registerClass:[MovieCvCell class] forCellWithReuseIdentifier:REUSEID];
    [_collectionView registerClass:[HeaderCView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADER_REUSEID];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.sourceArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieCvCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:REUSEID forIndexPath:indexPath];
    [cell setMovie:[self.sourceArr objectAtIndex:indexPath.item]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    HeaderCView *headV = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HEADER_REUSEID forIndexPath:indexPath];    
    return headV;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Movie *movie = [self.sourceArr objectAtIndex:indexPath.item];
    
    MovieDetailViewController *movieDetailVC = [[MovieDetailViewController alloc] init];
    movieDetailVC.movie = movie;
    [self.navigationController pushViewController:movieDetailVC animated:YES];
    [movieDetailVC release];
}

- (void)handleData
{
    [NetHandler getDataWithUrl:@"http://api.douban.com/v2/movie/nowplaying?app_name=doubanmovie&client=e:iPhone4,1|y:iPhoneOS_6.1|s:mobile|f:doubanmovie_2|v:3.3.1|m:PP_market|udid:aa1b815b8a4d1e961347304e74b9f9593d95e1c5&alt=json&version=2&start=0&city=北京&apikey=0df993c66c0c636e29ecbb5344252a4a" completion:^(NSData *data) {
       
        NSError *error = nil;
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        NSMutableArray *entries = [result objectForKey:@"entries"];
        
        self.sourceArr = [Movie modelArrWithDics:entries];
        
        [self.collectionView reloadData];
        
    }];
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
