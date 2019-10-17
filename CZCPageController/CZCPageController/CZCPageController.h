//
//  CZCPageController.h
//  CZCPageController
//
//  Created by chenzhichao on 2019/8/1.
//  Copyright © 2019 xiaojian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZCProtocol.h"
#import "CZCSubControllerCell.h"
#import "CZCSegmentBar.h"

@interface CZCPageController : UIViewController
<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CZCSubControllerCellDelegate, CZCSegmentBarDelegate, CZCPageControllerDelegate>

/**
 *主列表
 */
@property (nonatomic, strong, readonly) UICollectionView *collectionView;

/**
 *主列表布局
 */
@property (nonatomic, strong, readonly) UICollectionViewFlowLayout *flowLayout;

/**
 *子控制器的容器
 */
@property (nonatomic, strong, readonly) CZCSubControllerCell *subControllerContainer;

/**
 *分段选择器
 */
@property (nonatomic, strong, readonly) CZCSegmentBar *segmentBar;

/*
 * 设置完delegate后，刷新数据
 */
- (void)updateData;

@end

