//
//  CZCCommonCollectionView.m
//  CZCPageController
//
//  Created by chenzhichao on 2019/8/2.
//  Copyright © 2019 xiaojian. All rights reserved.
//

#import "CZCCommonCollectionView.h"

@implementation CZCCollectionView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    if ([otherGestureRecognizer.view isKindOfClass:[CZCCustomCollectionView class]] ||
        [otherGestureRecognizer.view isKindOfClass:[CZCCuscomScrollView class]] ) {
        return NO;
    }
    return YES;
}
@end


@implementation CZCCustomCollectionView
@end


@implementation CZCCuscomScrollView
@end
