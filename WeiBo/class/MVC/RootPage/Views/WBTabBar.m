//
//  WBTabBar.m
//  WeiBo
//
//  Created by 千锋 on 15/12/29.
//  Copyright (c) 2015年 LEE. All rights reserved.
//

#import "WBTabBar.h"
#import "WBTabBarButton.h"

@interface WBTabBar ()

@property (nonatomic,strong) NSMutableArray *buttonArray;  //按钮数组
@property (nonatomic, strong) WBTabBarButton *selectedBtn; //当前选中按钮
@property (nonatomic, strong) UIButton *plusButton;  //加号按钮
@end

@implementation WBTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //创建一个按钮 设置一次性的属性
        UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:plusBtn];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        self.plusButton = plusBtn;
    }
    return self;
}

-(NSMutableArray*)buttonArray  //懒加载
{
    if (!_buttonArray) {
        _buttonArray = @[].mutableCopy;
    }
    return _buttonArray;
}

-(void)setTabBarItem:(UITabBarItem *)tabBarItem
{
    //每进来一次，调用方法后 获取到了title image
    
    //创建button
    WBTabBarButton *button = [WBTabBarButton buttonWithType:UIButtonTypeCustom];
    button.tabBarItem = tabBarItem;
    
    //把下面的代码封装到了WBTabBarButton.h里的set方法中了
//    [button setTitle:tabBarItem.title forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
//    
//    [button setImage:tabBarItem.image forState:UIControlStateNormal];
//    [button setImage:tabBarItem.selectedImage forState:UIControlStateSelected];
    [self addSubview:button];
    [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchDown];
    
    [self.buttonArray addObject:button]; //存在全局的按钮数组里面
    
    //第一次调用此方法，就让首页按钮处于选中状态
    if (self.buttonArray.count == 1)
    {
        [self buttonPress:button];
    }
    
    //方法1.调整button的位置
    //button.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 20, 10);
    //button.titleEdgeInsets = UIEdgeInsetsMake(-24, 3, 12, 20);
}

#pragma mark 按钮点击
-(void)buttonPress:(WBTabBarButton*)btn
{
    //方法1 一个有颜色剩下无颜色
//    for (WBTabBarButton *button in self.buttonArray) {
//        button.selected = NO;
//    }
//    btn.selected = YES;
    
    //2 用记录的方式
    _selectedBtn.selected = NO;
    btn.selected = YES;
    _selectedBtn = btn;
    
//    NSInteger index = [self.buttonArray indexOfObject:btn];
//    //响应代理的方法
//    if ([_delegate respondsToSelector:@selector(passIndex:)]) {
//        [_delegate passIndex:index];
//    }
    
    NSInteger index = [self.buttonArray indexOfObject:btn];
    //block传值
    if (_passIndex)
    {
        self.passIndex(index);
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //布局子视图  加上CGFloat让结果变小数，更精准
    CGFloat btnW = CGRectGetWidth(self.frame)/((CGFloat)self.buttonArray.count+1);
    
    CGFloat plusW = self.plusButton.currentBackgroundImage.size.width;
    CGFloat plusH = self.plusButton.currentBackgroundImage.size.height;
    self.plusButton.frame = CGRectMake(0, 0, plusW, plusH);
    self.plusButton.center = CGPointMake(CGRectGetWidth(self.frame)*0.5, CGRectGetHeight(self.frame)*0.5);
    
    for (int i = 0; i<self.buttonArray.count; i++)
    {
        WBTabBarButton *btn = self.buttonArray[i];
        CGFloat bX = btnW*i;
        if (i > 1) {
            bX += btnW;
        }
        CGFloat bY = 0;
        CGFloat bW = btnW;
        CGFloat bH = CGRectGetHeight(self.frame);
        btn.frame =CGRectMake(bX, bY, bW, bH);
    }
}

@end
