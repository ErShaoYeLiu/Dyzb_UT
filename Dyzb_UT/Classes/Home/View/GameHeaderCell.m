//
//  GameHeaderCell.m
//  Dyzb_UT
//
//  Created by liutao on 17/4/13.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "GameHeaderCell.h"

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

    

}
@end
