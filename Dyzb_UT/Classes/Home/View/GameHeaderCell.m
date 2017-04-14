//
//  GameHeaderCell.m
//  Dyzb_UT
//
//  Created by liutao on 17/4/13.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "GameHeaderCell.h"
#import "gameCollectionViewCell.h"
#import "gamePageCollectionViewFlowLayout.h"
@interface GameHeaderCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView  *gameCollectionView;
@end
@implementation GameHeaderCell

+(instancetype)cellWithTableview:(UITableView *)tableview {

    GameHeaderCell *cell = [tableview dequeueReusableCellWithIdentifier:@"gameHeaderCell"];
    if (!cell) {
        cell = [[GameHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"gameHeaderCell"];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {

    [self setupCollectionView];

}
- (void)setupCollectionView {

    gamePageCollectionViewFlowLayout *flowLayout = [[gamePageCollectionViewFlowLayout alloc] initWithRowCount:2 itemCountPerRow:4];
    [flowLayout setColumnSpacing:10 rowSpacing:15 edgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kH(200))collectionViewLayout:flowLayout];
    self.gameCollectionView = collectionView;
    [self.contentView addSubview:collectionView];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.bounces = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.pagingEnabled = YES;
    [self.contentView addSubview:collectionView];
    [collectionView registerClass:[gameCollectionViewCell class] forCellWithReuseIdentifier:@"gameCollectioncell"];

}

#pragma mark - collectionView delegate / datasource 
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 13;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    gameCollectionViewCell *cell = [gameCollectionViewCell collectionViewCellWithCollectionView:collectionView index:indexPath];
  
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (_delegate && [_delegate respondsToSelector:@selector(gameHeaderCell:didSelectItemAtIndexPath:)]) {
        [_delegate gameHeaderCell:self didSelectItemAtIndexPath:indexPath];
    }

}
@end
