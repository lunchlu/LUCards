//
//  EPLineChartDrawView.m
//  view11-11
//
//  Created by luchanghao on 16/11/11.
//  Copyright © 2016年 luchanghao. All rights reserved.
//

#import "EPBarChartDrawView.h"
#import "UIView+Frame.h"

@interface EPBarChartDrawView()
@end


@implementation EPBarChartDrawView


-(void)setPointHeightForM:(NSMutableArray *)pointHeightForM{
    _pointHeightForM = pointHeightForM;
    [self setNeedsDisplay];
}

-(void)setPointHeightForT:(NSMutableArray *)pointHeightForT{
    _pointHeightForT = pointHeightForT;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    UIBezierPath *path2 = [UIBezierPath bezierPath];

    //获得处理的上下文
    CGContextRef context =UIGraphicsGetCurrentContext();
    //开始一个起始路径
    CGContextBeginPath(context);
    
    [self draw_T_WithPath:path1];
    [self draw_M_WithPath:path2];
    
    CGContextStrokePath(context);
    CGContextClosePath(context);
}

-(void)draw_T_WithPath:(UIBezierPath *)path{
    for (int i =0; i<_pointHeightForT.count; i++) {
        CGRect frame = [self frameWithHeight:[_pointHeightForT[i] floatValue] X:(30 + i*35)-35/2 +35/4];
        UIBezierPath *newPath = [UIBezierPath bezierPathWithRect:frame];
        [path appendPath:newPath];
    }
    [_colorArray[0]  setFill];
    [path fill];
    [path closePath];
}

-(void)draw_M_WithPath:(UIBezierPath *)path{
    for (int i =0; i<_pointHeightForM.count; i++) {
        CGRect frame = [self frameWithHeight:[_pointHeightForM[i] floatValue] X:(30 + i*35)];
        
        UIBezierPath *newPath = [UIBezierPath bezierPathWithRect:frame];
        [path appendPath:newPath];
    }
    [_colorArray[1]  setFill];
    [path fill];
}

-(CGRect)frameWithHeight:(CGFloat)height X:(CGFloat)X{
    return CGRectMake(X, 130+height, 35/4, -height);
}

@end













