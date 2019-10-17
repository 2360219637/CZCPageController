//
//  CZCSegmentBarCell.m
//  CZCPageController
//
//  Created by chenzhichao on 2018/12/29.
//  Copyright © 2018年 chenzhichao. All rights reserved.
//

#import "CZCSegmentBarCell.h"
#import "CZCSegmentBarTheme.h"
@implementation CZCSegmentBarCell
{
    UILabel *titleLabel;
    UIImageView *imageView;
}

- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    titleLabel.textColor = isSelected ? self.itemTheme.selectedColor : self.itemTheme.normalColor;
    titleLabel.font = isSelected ? self.itemTheme.selectedFont : self.itemTheme.normalFont;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = [title copy];
    titleLabel.text = title;
}

- (void)addAllViews{
    titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    titleLabel.frame = self.contentView.bounds;
}

@end
