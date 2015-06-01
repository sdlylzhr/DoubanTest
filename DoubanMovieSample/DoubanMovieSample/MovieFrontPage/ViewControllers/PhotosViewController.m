//
//  PhotosViewController.m
//  DoubanMovieSample
//
//  Created by lzhr on 15/3/14.
//  Copyright (c) 2015年 lzhr. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotoDetailViewController.h"

#import "Movie.h"
#import "Photo.h"

#import "PhotosCVCell.h"

#define PHOTOS_REUSEID @"PhotosCVReuse"

@interface PhotosViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *photosArr;

@end

@implementation PhotosViewController

- (void)dealloc
{
    [_collectionView release];
    [_photosArr release];
    [_movie release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self handleData];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.itemSize = CGSizeMake((self.view.width - 10 * 5) / 4 , 140);
    
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.view addSubview:self.collectionView];
    [_collectionView release];
    [flowLayout release];
    
    [_collectionView registerClass:[PhotosCVCell class] forCellWithReuseIdentifier:PHOTOS_REUSEID];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photosArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotosCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PHOTOS_REUSEID forIndexPath:indexPath];
    
    cell.photo = [self.photosArr objectAtIndex:indexPath.item];
    
    return cell;
}

- (void)handleData
{
    NSString *urlStr = [NSString stringWithFormat:@"http://api.douban.com/movie/subject/%@/photos?alt=json&apikey=0df993c66c0c636e29ecbb5344252a4a&app_name=doubanmovie&client=e:iPhone6,2|y:iPhone OS_8.2|s:mobile|f:doubanmovie_2|v:3.6.3|m:豆瓣电影|udid:d18a6cc8ac440a9d31f32fa5fe3ccfd675579c07&udid=d18a6cc8ac440a9d31f32fa5fe3ccfd675579c07&version=2", self.movie.movieId];
    
    
    
    NSLog(@"%@", urlStr);
    
    
    __block typeof(self) vc = self;
    
    [NetHandler getDataWithUrl:urlStr completion:^(NSData *data) {
       
        NSError *error = nil;
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        if (error) {
            NSLog(@"%@", error);
        }
        vc.photosArr = [Photo modelArrWithDics:[resultDic objectForKey:@"entry"]];
        
        [vc.collectionView reloadData];
        
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    PhotoDetailViewController *photoDetailVC = [[PhotoDetailViewController alloc] initWithCollectionViewLayout:flowLayout];
    
    photoDetailVC.photosArr = self.photosArr;
    photoDetailVC.number = indexPath.item;
    photoDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:photoDetailVC animated:YES];
    photoDetailVC.hidesBottomBarWhenPushed = NO;
    [photoDetailVC release];
    [flowLayout release];
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
