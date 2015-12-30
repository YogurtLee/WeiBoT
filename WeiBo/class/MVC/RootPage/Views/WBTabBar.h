//
//  WBTabBar.h
//  WeiBo
//
//  Created by 千锋 on 15/12/29.
//  Copyright (c) 2015年 LEE. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol WBTabBarDelegate <NSObject>   代理方法传值
//
//-(void)passIndex:(NSInteger)index;
//
//@end

typedef void(^PassIndex)(NSInteger index); //block反向传值
@interface WBTabBar : UIView
//正向传值(传系统自带的tabbat vc
@property (nonatomic,strong) UITabBarItem *tabBarItem; //用来传递title，image等信息

//@property (nonatomic,weak) id<WBTabBarDelegate>delegate;

@property (nonatomic,copy) PassIndex passIndex;
@end
