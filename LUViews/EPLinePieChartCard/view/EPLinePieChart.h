//
//  EPPieChart.h
//  pie
//
//  Created by luchanghao on 16/10/19.
//  Copyright © 2016年 HC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPLinePie.h"
#import "EPLinePieChartModel.h"

@interface EPLinePieChart : UIView
@property (nonatomic, strong) EPLinePieChartModel *model;
@property (nonatomic, assign) kPiePatternType piePatternType;
@end



typedef NS_ENUM(NSInteger, EPpieDrawLineType) {
    EPpieDrawLineType_up_left,
    EPpieDrawLineType_up_right,
    EPpieDrawLineType_down_left,
    EPpieDrawLineType_down_right,
};













