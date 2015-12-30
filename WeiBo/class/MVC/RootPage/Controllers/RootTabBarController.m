//
//  RootTabBarController.m
//  WeiBo
//
//  Created by 千锋 on 15/12/29.
//  Copyright (c) 2015年 LEE. All rights reserved.
//

#import "RootTabBarController.h"
#import "HomeTableViewController.h"
#import "MessageTableViewController.h"
#import "DiscoveryTableViewController.h"
#import "PersonalTableViewController.h"

#import "WBTabBar.h"

@interface RootTabBarController ()//<WBTabBarDelegate>

@property (nonatomic,strong) WBTabBar *wbTabBar; //自定义tabBat

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];

    [self addCustomTabBar]; //添加自定义tabbar
    
    //添加VC
    [self addViewVontrollers];
    
}

-(void)addCustomTabBar
{       //隐藏系统自带tabbar
    self.tabBar.hidden = YES;
    self.wbTabBar = [[WBTabBar alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49)];
    
    //self.wbTabBar.delegate = self;
    __weak typeof(self) weakSelf = self;
    self.wbTabBar.passIndex = ^(NSInteger index)
    {
        weakSelf.selectedIndex = index;
    };
    
    [self.view addSubview:self.wbTabBar];
    //self.wbTabBar.backgroundColor = [UIColor whiteColor];
    self.wbTabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
    
}

-(void)addViewVontrollers
{
    NSArray *vcNameArray = @[@"HomeTableViewController",@"MessageTableViewController",@"DiscoveryTableViewController",@"PersonalTableViewController"];
    
    NSArray *vcTitleArray = @[@"首页",@"消息",@"发现",@"我"];
    
    NSArray *norImageArray = @[@"tabbar_home",@"tabbar_message_center",@"tabbar_discover",@"tabbar_profile"];
    NSArray *hlImageArray = @[@"tabbar_home_highlighted",@"tabbar_message_center_highlighted",@"tabbar_discover_highlighted",@"tabbar_profile_highlighted"];
    NSArray *selImageArray = @[@"tabbar_home_selected",@"tabbar_message_center_selected",@"tabbar_discover_selected",@"tabbar_profile_selected"];
    
    for (NSString *vcName in vcNameArray) {
        Class vcClass = NSClassFromString(vcName);
        NSInteger index = [vcNameArray indexOfObject:vcName];
        UITableViewController *vc = [[vcClass alloc]init];
        vc.title = vcTitleArray[index];
        
        [vc.tabBarItem setImage:[[UIImage imageNamed:norImageArray[index]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [vc.tabBarItem setSelectedImage:[[UIImage imageNamed:selImageArray[index]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        //修改文字颜色
        NSDictionary *norAttribute = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor lightGrayColor]};
        NSDictionary *selAttribute = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor orangeColor]};
        [vc.tabBarItem setTitleTextAttributes:norAttribute forState:UIControlStateNormal];
        [vc.tabBarItem setTitleTextAttributes:selAttribute forState:UIControlStateSelected];
        
        UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:vc];
        [self addChildViewController:navc];
        
        self.wbTabBar.tabBarItem = vc.tabBarItem;  //正向传值开始
    }
}

#pragma mark WBTB代理
//-(void)passIndex:(NSInteger)index
//{
//    self.selectedIndex = index;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
