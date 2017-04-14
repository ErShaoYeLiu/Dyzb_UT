//
//  gameCollectionViewCell.m
//  Dyzb_UT
//
//  Created by liutao on 17/4/13.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "gameCollectionViewCell.h"

@interface gameCollectionViewCell ()
@property (nonatomic, strong) UIImageView  *projectImageView;
@property (nonatomic, strong) UILabel  *projectLable;
@end
@implementation gameCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
- (void)configUI {



}
+ (instancetype)collectionViewCellWithCollectionView:(UICollectionView *)collectionview index:(NSIndexPath *)index {
    
    gameCollectionViewCell *cell = [collectionview dequeueReusableCellWithReuseIdentifier:@"gameCollectionCell" forIndexPath:index];
    return cell;
}
@end
