//
//  FinddYnamicCell.m
//  Dyzb_UT
//
//  Created by 孙好运 on 2017/4/13.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "FinddYnamicCell.h"

#import "Masonry.h"

@implementation FinddYnamicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//     18049655208
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    //头像
    _headImageView = [UIImageView new];
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = 20;
    
    [self.contentView addSubview:_headImageView];
    
    //昵称
    _nameLabel = [UILabel new];
    
    [self.contentView addSubview:_nameLabel];
    
    //性别图标
    _sexImageView = [UIImageView new];
    _sexImageView.hidden = YES;
    [self.contentView addSubview:_sexImageView];
    
    //时间和阅读量
    _timeAndReadingLabel = [UILabel new];
    
    [self.contentView addSubview:_timeAndReadingLabel];
    
    //发表的状态
    _stateLabel = [UILabel new];
    _stateLabel.numberOfLines = 0;
    
    [self.contentView addSubview:_stateLabel];

    //图片
    _collectionView = [UICollectionView new];
    
    [self.contentView addSubview:_collectionView];
    
    //名字 点击
    _liveNameLabel = [UILabel new];
    
    [self.contentView addSubview:_liveNameLabel];
    
    //关注
    _focusButton = [UIButton new];
    
    [self.contentView addSubview:_focusButton];
    
    //分享
    _shareButton = [UIButton new];
    
    [self.contentView addSubview:_shareButton];
    
    //评论
    _commentsButton = [UIButton new];
    
    [self.contentView addSubview:_commentsButton];
    
    //点赞
    _praiseButton = [UIButton new];
    
    [self.contentView addSubview:_praiseButton];
    
    [self initalConstrolsConstraints];
}

- (void)initalConstrolsConstraints{
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(10);
        make.height.width.mas_equalTo(40);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headImageView.mas_right).offset(5);
        make.top.mas_equalTo(10);
        
    }];
    
    [_sexImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel.mas_right).offset(3);
        make.top.mas_equalTo(_nameLabel);
        
    }];
    
    [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headImageView);
        make.top.mas_equalTo(_headImageView.mas_bottom).offset(5);
        
    }];
}

@end
