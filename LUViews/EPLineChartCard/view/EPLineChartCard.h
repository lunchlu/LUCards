//
//  EPLineChartCard.h
//  view11-11
//
//  Created by luchanghao on 16/11/11.
//  Copyright © 2016年 luchanghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPLineChartCardModel.h"

@interface EPLineChartCard : UIView
@property (nonatomic, strong)EPLineChartCardModel *model;

@property (nonatomic, strong) NSMutableArray *pointArray;
@property (nonatomic, strong) NSMutableArray *YHeight;
@property (nonatomic, strong) NSMutableArray *Yvalue;//15%
@property (nonatomic, strong) NSMutableArray *Xwidth;
@property (nonatomic, strong) NSArray *Xvalue;

@end
