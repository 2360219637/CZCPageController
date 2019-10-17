//
//  CZCSegmentBarTheme.h
//  CZCPageController
//
//  Created by chenzhichao on 2018/12/29.
//  Copyright © 2018年 chenzhichao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface CZCSegmentBarItemTheme : NSObject
/*
 *正常字体  默认17
 */
@property (nonatomic, strong) UIFont *normalFont;
/*
 *选中字体  默认17
 */
@property (nonatomic, strong) UIFont *selectedFont;
/*
 *正常颜色  默认redColor
 */
@property (nonatomic, strong) UIColor *normalColor;
/*
 *选中颜色  默认blackColor
 */
@property (nonatomic, strong) UIColor *selectedColor;
@end



@interface CZCSegmentBarBottomLineTheme : NSObject
/*
 *底部line的颜色
 */
@property (nonatomic, strong) UIColor *color;
/*
 *底部line是一张图片,如果不是图片请设置color
 */
@property (nonatomic, strong) UIImage *image;
/*
 *底部line的高度  默认2
 */
@property (nonatomic, assign) CGFloat height;
/*
 *底部line圆角大小  默认2
 */
@property (nonatomic, assign) CGFloat cornerRadius;
@end
