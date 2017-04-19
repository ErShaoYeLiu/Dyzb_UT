//
//  FindListView.m
//  Dyzb_UT
//
//  Created by 孙好运 on 2017/4/18.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "FindListView.h"

#import "FindListCell.h"


@interface FindListView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) UIView *bottomView;

//最新btn
@property (nonatomic,strong) UIButton *latestButton;
//最热btn
@property (nonatomic,strong) UIButton *hottestButton;

@end

@implementation FindListView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
      //  [self initCollectionView];
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

-(void)initCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 10;
    
    layout.minimumInteritemSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //图片
    
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    [_collectionView registerClass:[FindListCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(self.frame.size.height - 30);
    }];
    
    _bottomView = [UIView new];
    _bottomView.backgroundColor = [UIColor grayColor];
    [self addSubview:_bottomView];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(_collectionView.mas_bottom);
        make.height.mas_equalTo(30);
    }];
    
    _latestButton = [UIButton new];
    [_latestButton setTitle:@"最新" forState:UIControlStateNormal];
    
    [self addSubview:_latestButton];
    
    _hottestButton = [UIButton new];
    [_hottestButton setTitle:@"最热" forState:UIControlStateNormal];
    [self addSubview:_hottestButton];
    
    [_latestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(_bottomView.mas_centerY);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(35);
    }];
    
    [_hottestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_latestButton.mas_right).offset(10);
        make.centerY.height.width.mas_equalTo(_latestButton);
    }];
    
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titleArr.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
        
    CGSize size = [self getSizeWithText:self.titleArr[indexPath.row]];
    
    return size;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FindListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

//    for (UIView *view in cell.contentView.subviews) {
//        if ([view isKindOfClass:[FindListCell class]]) {
//            [view removeFromSuperview];
//        }
//}
    cell.textLabel.text = self.titleArr[indexPath.item];
    
    if (indexPath.row == _currentPage) {
        cell.textLabel.textColor = [UIColor orangeColor];
    }
    else
    {
        cell.textLabel.textColor = [UIColor grayColor];
    }
    


    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FindListCell *cell = (FindListCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor orangeColor];
    cell.textLabel.layer.borderColor = [UIColor orangeColor].CGColor;
    _cancelBlock(indexPath.item);
}

- (void)setTitleArr:(NSArray *)titleArr{
    _titleArr = titleArr;
    [self initCollectionView];
    [self.collectionView reloadData];
    [self setNeedsDisplay];
    [self layoutIfNeeded];
    
}

/**
 *   获取字符宽度
 */
- (CGSize)getSizeWithText:(NSString*)text{
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize size = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 24) options: NSStringDrawingUsesLineFragmentOrigin   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f],NSParagraphStyleAttributeName:style} context:nil].size;
    return CGSizeMake(size.width, 24);
}

@end
