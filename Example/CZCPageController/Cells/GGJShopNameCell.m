//
//  GGJShopNameCell.m
//  CZCPageController
//
//  Created by chenzhichao on 2019/9/26.
//  Copyright © 2019 xiaojian. All rights reserved.
//

#import "GGJShopNameCell.h"

@implementation GGJShopNameCell
{
    UILabel *shopNameLabel;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        shopNameLabel = [[UILabel alloc] init];
        shopNameLabel.textAlignment = NSTextAlignmentCenter;
        shopNameLabel.text = @"斑马家装旗舰店";
        shopNameLabel.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:shopNameLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    shopNameLabel.frame = self.contentView.bounds;
}

@end
