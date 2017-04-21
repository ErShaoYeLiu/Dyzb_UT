//
//  MoreCollectionFlowLayout.m
//  Dyzb_UT
//
//  Created by liutao on 17/4/21.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MoreCollectionFlowLayout.h"

@implementation MoreCollectionFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return self;
}
@end
