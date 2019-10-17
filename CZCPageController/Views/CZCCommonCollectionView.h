//
//  CZCCommonCollectionView.h
//  CZCPageController
//
//  Created by chenzhichao on 2019/8/2.
//  Copyright © 2019 xiaojian. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *底层使用的，用户不必用
 */
@interface CZCCollectionView : UICollectionView
@end

/**
 *用户定义的cell中包含UICollectioView 则要使用下面这个类型， 否则会手势冲突
 */
@interface CZCCustomCollectionView : UICollectionView
@end

/**
 *用户定义的cell中包含UIScrollView 则要使用下面这个类型， 否则会手势冲突
 */
@interface CZCCuscomScrollView : UIScrollView
@end
