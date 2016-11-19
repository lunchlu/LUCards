//
//  ViewController.m
//  LUViews
//
//  Created by lu_ios on 16/11/18.
//  Copyright © 2016年 luchanghao. All rights reserved.
//

#import "ViewController.h"
#import "ShowVC.h"



#define COLOR_RGBA(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define COLOR_Random \
[UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSArray *titleArray = @[@"EPHorizonProgressCard",
                            @"EPLineChartCard",
                            @"EPFillLineCard",
                            @"EPBarChartCard",
                            @"EPPieChartCard",
                            @"EPLinePieChartCard"];
    
    for (int i = 0; i<titleArray.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:(CGRectMake(20, 50 +i*50, 300, 40))];
        btn.layer.cornerRadius = 8;
        [btn setTitle:titleArray[i] forState:(UIControlStateNormal)];
        [btn setTitleColor:COLOR_Random forState:(UIControlStateNormal)];
        btn.backgroundColor = COLOR_Random;
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(pushVC:) forControlEvents:(UIControlEventTouchUpInside)];
    }

    
}

-(void)pushVC:(UIButton *)btn{
    NSString *str = btn.titleLabel.text;
    ShowVC *vc = [[ShowVC alloc] init];
    vc.showType = str;
    [self presentViewController:vc animated:YES completion:nil];
    
}

@end

















