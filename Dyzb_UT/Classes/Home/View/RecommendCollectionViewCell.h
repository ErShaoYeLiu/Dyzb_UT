//
//  RecommendCollectionViewCell.h
//  Dyzb_UT
//
//  Created by liutao on 17/4/13.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "recommendModel.h"
@interface RecommendCollectionViewCell : UICollectionViewCell
+ (instancetype)collectionViewCellWithCollectionView:(UICollectionView *)collectionview index:(NSIndexPath *)index;

- (void)initDataWithModel:(recommendModel *)model ;
@end
