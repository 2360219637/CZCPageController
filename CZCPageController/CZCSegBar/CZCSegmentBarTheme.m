//
//  CZCSegmentBarItemTheme.m
//  CZCPageController
//
//  Created by chenzhichao on 2018/12/29.
//  Copyright © 2018年 chenzhichao. All rights reserved.
//
#import "CZCSegmentBarTheme.h"

@implementation CZCSegmentBarItemTheme

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.normalFont = [UIFont systemFontOfSize:17];
        self.selectedFont = [UIFont systemFontOfSize:17];
        self.normalColor = [UIColor blackColor];
        self.selectedColor = [UIColor redColor];
    }
    return self;
}

@end


@implementation CZCSegmentBarBottomLineTheme

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.height = 2;
        self.cornerRadius = 2;
    }
    return self;
}
@end
