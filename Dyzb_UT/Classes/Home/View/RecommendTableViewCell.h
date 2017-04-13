//
//  RecommendTableViewCell.h
//  Dyzb_UT
//
//  Created by liutao on 17/4/13.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "BaseTableViewCell.h"
@class RecommendTableViewCell;

@protocol RecommendTableViewCellDelegate <NSObject>

@optional
- (void)recommendTableViewCell:(RecommendTableViewCell *)cell didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end
@interface RecommendTableViewCell : BaseTableViewCell
@property (nonatomic, weak) id<RecommendTableViewCellDelegate> delegate;
+ (instancetype)cellWithTableview:(UITableView *)tableview;

@end
