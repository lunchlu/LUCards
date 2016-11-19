//
//  EPLineChartCard.h
//  view11-11
//
//  Created by luchanghao on 16/11/11.
//  Copyright © 2016年 luchanghao. All rights reserved.
//
#import "cong.h"

#import <UIKit/UIKit.h>
#import "EPBarChartCardModel.h"

@interface EPBarChartCard : UIView
@property (nonatomic, strong) EPBarChartCardModel *model;

@property (nonatomic, strong) NSMutableArray *pointHeightForT;
@property (nonatomic, strong) NSMutableArray *pointHeightForM;
@property (nonatomic, strong) NSMutableArray *YHeight;
@property (nonatomic, strong) NSMutableArray *YvalueForT;
@property (nonatomic, strong) NSMutableArray *YvalueForM;

@property (nonatomic, strong) NSArray *XtitleArray;
@property (nonatomic, strong) NSArray *titleArray;
@end
