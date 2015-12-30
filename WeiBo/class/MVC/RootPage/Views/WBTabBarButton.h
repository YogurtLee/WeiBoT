//
//  WBTabBarButton.h
//  WeiBo
//
//  Created by 千锋 on 15/12/29.
//  Copyright (c) 2015年 LEE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBTabBarButton : UIButton

@property (nonatomic,assign) CGFloat ratio;  //图片高度占整个按钮高度的比例 默认0.6

@property (nonatomic,strong) UITabBarItem *tabBarItem;  //

@end
