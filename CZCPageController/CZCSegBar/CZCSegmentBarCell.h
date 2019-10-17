//
//  CZCSegmentBarCell.h
//  CZCPageController
//
//  Created by chenzhichao on 2018/12/29.
//  Copyright © 2018年 chenzhichao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CZCSegmentBarItemTheme;
@interface CZCSegmentBarCell : UICollectionViewCell
//文字
@property (nonatomic, copy) NSString *title;
//选中
@property (nonatomic, assign) BOOL isSelected;
//主体
@property (nonatomic, strong) CZCSegmentBarItemTheme *itemTheme;
@end

