//
//  RecommendViewController.m
//  Dyzb_UT
//
//  Created by liutao on 17/4/12.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "RecommendViewController.h"
#import "RecommendHeaderCell.h"
#import "RecommendTableViewCell.h"
#import "SectionHeaderView.h"
#import "recommendModel.h"
#import "recommenBannerModel.h"
@interface RecommendViewController ()<UITableViewDelegate,UITableViewDataSource,RecommendTableViewCellDelegate>
@property (nonatomic, strong) UITableView  *homeTableView;
@property (nonatomic, strong) recommendModel  *recommentHotModel;
@property (nonatomic, strong) NSArray  *dataArray;
@property (nonatomic, strong) NSMutableArray  *listArray;
@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [NSArray array];
    _listArray = [NSMutableArray array];
    [self initializeDataSource];
    [self initializeUserInterFace];
    
}

- (void) initializeDataSource{

    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //请求轮播
    
    dispatch_group_enter(group);
    NSDictionary *parameters = @{@"version":@"2.480"};
    [DyHttpTool get:URL_Home_Banner params:parameters success:^(id responseObj) {
        
        NSLog(@"Banner%@",[self dictionaryToJson:responseObj]);
        self.dataArray = [recommenBannerModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
        NSLog(@"Model:****%@",self.dataArray);
        
        for (recommenBannerModel *model in self.dataArray) {
            [self.listArray addObject:model.pic_url];
        }
        dispatch_group_leave(group);
        
    } failure:^(NSError *error) {
        
        dispatch_group_leave(group);
    }];

    dispatch_group_enter(group);
    NSString *timeStr = [NSString stringWithFormat:@"%f", (double)[[NSDate date] timeIntervalSince1970]];
    NSDictionary *parame = @{@"time":timeStr};
    [DyHttpTool get:URL_Home_Hot params:parame success:^(id responseObj) {
       
        NSLog(@"******%@******",responseObj);
       dispatch_group_leave(group);
    } failure:^(NSError *error) {
        dispatch_group_leave(group);
    }];
    
    
    dispatch_group_notify(group, queue, ^{
       
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.homeTableView reloadData];
        });
    });
}
- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
- (void) initializeUserInterFace{

    [self.view addSubview:self.homeTableView];

}
- (UITableView *)homeTableView {
    
    if (!_homeTableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.tabBarController.tabBar.frame.size.height-108) style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor whiteColor];
        _homeTableView = tableView;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _homeTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 15;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        RecommendHeaderCell *cell = [RecommendHeaderCell cellWithTableview:tableView];
        [cell loadDataWithImageUrlstring:self.listArray];
        cell.BannerBlock = ^(NSInteger index){
        
            // 根据index去取数据
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
    
        RecommendTableViewCell *cell = [RecommendTableViewCell cellWithTableview:tableView];
        if (indexPath.section == 1) {
            cell.setionType = SectionHeaderStyleHot;
        }else {
            cell.setionType = SectionHeaderStyleOther;
        }
        cell.delegate = self;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return kH(215.5);
    }else if(indexPath.section == 1){
        return RECOMMEND_CELL_HEIGHT * 2 + kH(10) ;
    
    } else {
        return RECOMMEND_CELL_HEIGHT;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }else {
    return kH(44);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }else {
        SectionHeaderView *header = [[SectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kH(44))];
        // 添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderViewTapped:)];
        header.tag = section - 1;
        [header addGestureRecognizer:tap];
        return header;
    }
}
#pragma mark - 手势点击处理

- (void)sectionHeaderViewTapped:(UIGestureRecognizer *)tap
{
    NSLog(@"%s %ld", __FUNCTION__, tap.view.tag);
    NSLog(@"点击到更多页面%ld",tap.view.tag);
}
#pragma mark - recommendcell /delegate
- (void)recommendTableViewCell:(RecommendTableViewCell *)cell didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//处理cell的点击事件

}
@end
