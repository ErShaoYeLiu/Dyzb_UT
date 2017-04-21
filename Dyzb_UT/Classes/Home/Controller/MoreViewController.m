//
//  MoreViewController.m
//  Dyzb_UT
//
//  Created by liutao on 17/4/21.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreCollectionFlowLayout.h"
#import "RecommendCollectionViewCell.h"
#import "AnchorGroupModel.h"
#define URL @"http://www.douyutv.com/api/v1/live/"
#define URL2 @"?aid=ios&auth=9e3802f36db0fd94e29839ee3a92834a&client_sys=ios&limit=20&offset=0&time="
#define URL3 @"?aid=ios&auth=9e3802f36db0fd94e29839ee3a92834a&client_sys=ios&limit=20&offset="
#define URL4 @"&time="
#define URL_a @"0"
@interface MoreViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView  *collectionview;
@property (nonatomic, strong) recommendModel  *moreModel;
@property (nonatomic, strong) NSMutableArray  *dataArray;
@property (nonatomic, assign) NSInteger roomCount;
@end
@implementation MoreViewController

- (void) initializeDataSource{
    
    // 下拉刷新
    self.collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.collectionview.mj_header beginRefreshing];
    
    // 上拉刷新
    self.collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    _dataArray = [NSMutableArray array];
    
}

- (void)loadNewData {

    NSString *timeStr = [NSString stringWithFormat:@"%f", (double)[[NSDate date] timeIntervalSince1970]];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@%@",URL,self.cateid,URL2,timeStr];
    
    [DyHttpTool get:urlStr params:nil success:^(id responseObj) {
        NSLog(@"responds%@",responseObj);
        NSArray *dataArray = responseObj[@"data"];
        if (dataArray.count > 0) {
            for (int i = 0 ; i < dataArray.count;  i ++) {
                recommendModel *model = [[recommendModel alloc] initWithDic:dataArray[i]];
                [_dataArray addObject:model];
                [self.collectionview reloadData];
                 [self.collectionview.mj_header endRefreshing];
            }
        }
    } failure:^(NSError *error) {
        
    }];


}
- (void)loadMoreData {
    self.roomCount = self.roomCount +1;
    NSString *timeStr = [NSString stringWithFormat:@"%f", (double)[[NSDate date] timeIntervalSince1970]];
    NSString *roomCount = [NSString stringWithFormat:@"%ld", self.roomCount];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@%@%@%@",URL,self.cateid,URL3,roomCount,URL4,timeStr];
    [DyHttpTool get:urlStr params:nil success:^(id responseObj) {
        NSLog(@"responds%@",responseObj);
        NSArray *dataArray = responseObj[@"data"];
        NSMutableArray *array = [NSMutableArray array];
        if (dataArray.count > 0) {
            for (int i = 0 ; i < dataArray.count;  i ++) {
                recommendModel *model = [[recommendModel alloc] initWithDic:dataArray[i]];
//                [array addObject:model];
                [self.dataArray addObject:model];
                [self.collectionview reloadData];
                [self.collectionview.mj_footer endRefreshing];
            }
        }
    } failure:^(NSError *error) {
        
    }];


}
- (void) initializeUserInterFace{

    [self.view addSubview:self.collectionview];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Lazy load
- (UICollectionView *)collectionview {


    if (!_collectionview) {
        MoreCollectionFlowLayout *layout = [[MoreCollectionFlowLayout alloc] init];
        _collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 113) collectionViewLayout:layout];
        [_collectionview registerClass:[RecommendCollectionViewCell class] forCellWithReuseIdentifier:@"collectioncell"];
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
        _collectionview.backgroundColor = [UIColor whiteColor];
    }
    return _collectionview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initializeDataSource];
    [self initializeUserInterFace];

}
#pragma mark - collectionView delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    RecommendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectioncell" forIndexPath:indexPath];
    cell.recommedModel = self.dataArray[indexPath.item];
    return cell;

}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {


}

@end
