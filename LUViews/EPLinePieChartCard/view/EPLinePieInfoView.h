//
//  EPLinePieInfoView.h
//  view11-4
//
//  Created by luchanghao on 16/11/4.
//  Copyright © 2016年 macBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPLinePieChart.h"

//typedef NS_ENUM(NSInteger, EPpieDrawLineType) {
//    EPpieDrawLineType_up_left,//默认从0开始
//    EPpieDrawLineType_up_right,
//    EPpieDrawLineType_down_left,
//    EPpieDrawLineType_down_right,
//};

@interface EPLinePieInfoView : UIView

@property (nonatomic, strong)UILabel *upLabel;
@property (nonatomic, strong)UILabel *downLabel;
@property (nonatomic, strong)UILabel *upDetailLab;


@property (nonatomic, strong)NSString *upTitle;
@property (nonatomic, strong)NSString *downTitle;
@property (nonatomic, strong)UIColor *lineColor;
@property (nonatomic, assign)EPpieDrawLineType LineType;

@property (nonatomic, assign) CGPoint leftPoint;
@property (nonatomic, assign) CGPoint rightPoint;
- (CGPoint)leftPointInView:(UIView *)view;
- (CGPoint)rightPointInView:(UIView *)view;


@end
