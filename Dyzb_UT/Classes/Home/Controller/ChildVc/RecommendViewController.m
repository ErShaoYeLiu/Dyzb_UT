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
@interface RecommendViewController ()<UITableViewDelegate,UITableViewDataSource,RecommendTableViewCellDelegate>
@property (nonatomic, strong) UITableView  *homeTableView;
@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initializeDataSource];
    [self initializeUserInterFace];
}

- (void) initializeDataSource{


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
        cell.BannerBlock = ^(NSInteger index){
        
            // 根据index去取数据
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
    
        RecommendTableViewCell *cell = [RecommendTableViewCell cellWithTableview:tableView];
        cell.delegate = self;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return kH(215.5);
    }else {
        return RECOMMEND_CELL_HEIGHT;
    
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
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
