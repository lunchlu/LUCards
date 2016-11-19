//
//  EPPieChartCard.h
//  view11-10
//
//  Created by luchanghao on 16/11/10.
//  Copyright © 2016年 luchanghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPPieChartCardModel.h"

@interface EPPieChartCard : UIView
@property (nonatomic, strong) EPPieChartCardModel *model;
@end


@interface EPPieChartDetailView : UIView
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) UIColor *color;
@end
