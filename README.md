# iOS支持头部的多控制器切换组件
###### 效果图：
![效果图](https://upload-images.jianshu.io/upload_images/1964261-d85e3c4622e06ba6.gif?imageMogr2/auto-orient/strip)
###### 效果图中页面结构：
![](https://upload-images.jianshu.io/upload_images/1964261-0dd8c26dd552755e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

>功能支持：
>
>1、多种类型cell共存（如上，支持多种类型cell的布局,更灵活）
>
>2、支持MJRefresh的整体下拉刷新
>
>3、接入更简单

#### 使用：
##### 1、通过pods导入
```
pod  `CZCPageController`
pod install
```
##### 2、新建控制器UIViewController，继承CZCPageController
在新建的控制器中实现CZCPageControllerDelegate中的方法
```
//CZCPageControllerDelegate
/*
 * 返回要设置的子控制器数组
 */
- (NSArray<UIViewController<CZCScrollControllerDelegate> *> *)pageControllerWithSubControllers;

/*
 * segmentBar所在的区 从0开始
 */
- (NSUInteger)pageControllerWithSegmentBarFloatSection;

/*
 * segmentBar高度
 */
- (CGFloat)pageControllerWithSegmentBarHeight;

/*
 * segmentBar样式设置，(字体、颜色等)
 */
- (void)pageControllerWithConfigSegmenrBarAppearance;
```

##### 3、步骤2中的代理返回的子控制器遵循CZCScrollControllerDelegate
遵循代理
如：
```
//返回子控制器滑动距离
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.contentOffsetY) {
        self.contentOffsetY(scrollView.contentOffset.y);
    }
}
//子控制器的容器
#pragma mark CZCScrollControllerDelegate
- (UIScrollView *)controllerMainScrollView{
    return self.collectionView;
}
```
>注意：
>子控制器的CollectionView或tableView的`bounces`需要设置为`NO`

##### 4、最后
>注意：
>
>1、考虑到segmentBar中title、子控制器数量等数据有服务端返回才能确定，因此，服务端返回数据之后，需要执行`[self updateData]（父类方法）`
>
>2、结构图中的UITableViewCell或者UICollectionViewCell又要嵌套UICollectionView、UIScrollView的话，要使用这两种类型：`CZCCustomCollectionView、CZCCuscomScrollView`， （如demo中的GGJShopCouponCell）
