//
//  EPPie.h
//  pie
//
//  Created by luchanghao on 16/10/19.
//  Copyright © 2016年 HC. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "EPPie.h"


@interface EPLinePie : CAShapeLayer
@property (nonatomic,assign)BOOL isShadow;

+ (instancetype)pieWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle color:(UIColor *)color duration:(CFTimeInterval)duration piePatternType:(kPiePatternType)piePatternType isAnimated:(BOOL)isAnimated;

@end
