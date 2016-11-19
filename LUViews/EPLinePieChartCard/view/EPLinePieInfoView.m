//
//  EPLinePieInfoView.m
//  view11-4
//
//  Created by luchanghao on 16/11/4.
//  Copyright © 2016年 macBook. All rights reserved.
//

#import "EPLinePieInfoView.h"
#import "UIView+Frame.h"

@interface EPLinePieInfoView()

@end

@implementation EPLinePieInfoView


-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.leftPoint = CGPointMake(0, self.height*0.6);
        self.rightPoint = CGPointMake(self.width, self.height*0.6);
    }
    return  self;
}

-(void)setLineType:(EPpieDrawLineType)LineType{
    _LineType = LineType;
    [self setNeedsDisplay];
}

-(void)setUpTitle:(NSString *)upTitle{
    _upTitle = upTitle;
    self.upLabel.text = upTitle;
    self.upDetailLab.text = @"条";
    self.downLabel.text = @"";
    CGRect uplabelSiza = [_upLabel.text boundingRectWithSize:(CGSizeMake(MAXFLOAT, _upLabel.height)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: _upLabel.font} context:nil];
    _upLabel.width = uplabelSiza.size.width;
    
    CGRect upDetailSiza = [_upDetailLab.text boundingRectWithSize:(CGSizeMake(MAXFLOAT, _upDetailLab.height)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: _upDetailLab.font} context:nil];
    _upDetailLab.width = upDetailSiza.size.width;
    
    
    if (self.LineType  == EPpieDrawLineType_up_right
        || self.LineType == EPpieDrawLineType_down_right
        )
    {
        _downLabel.textAlignment = NSTextAlignmentRight;
        _upDetailLab.right = self.width;
        _upDetailLab.textAlignment = NSTextAlignmentJustified;
        _upLabel.right = _upDetailLab.left;
        
    }
    else{
        _downLabel.textAlignment = NSTextAlignmentLeft;
        _upDetailLab.textAlignment = NSTextAlignmentJustified;

        _upDetailLab.left = _upLabel.right;
    }
    
}

-(void)setDownTitle:(NSString *)downTitle{
    _downTitle = downTitle;
    self.downLabel.text = downTitle;
}


-(UILabel *)downLabel{
    if (!_downLabel) {
        _downLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, self.width , self.height*0.4))];
        _downLabel.bottom = self.height;
        _downLabel.font = [UIFont systemFontOfSize:10];
        _downLabel.textColor = [UIColor grayColor];
        [self addSubview:_downLabel];
    }
    return _downLabel;
}

-(UILabel *)upLabel{
    if (!_upLabel) {
        _upLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, 5, self.width, self.height*0.45))];
        _upLabel.textColor = [UIColor colorWithRed:81/255.0 green:89/255.0 blue:115/255.0 alpha:1];
        _upLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_upLabel];
    }
    return  _upLabel;
}

-(UILabel *)upDetailLab{
    if (!_upDetailLab) {
        _upDetailLab = [[UILabel alloc] initWithFrame:(CGRectMake(0, 5, self.width, 20))];
        _upDetailLab.textColor = [UIColor colorWithRed:81/255.0 green:89/255.0 blue:115/255.0 alpha:1];
        _upDetailLab.font = [UIFont systemFontOfSize:10];
        [self addSubview:_upDetailLab];
    }
    return _upDetailLab;
}

-(void)drawRect:(CGRect)rect{
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    
        UIBezierPath *bezier = [UIBezierPath bezierPath];
        [bezier moveToPoint:(CGPointMake(0, self.height*0.6))];
        bezier.lineWidth = 1;
        [bezier addLineToPoint:(CGPointMake(self.width, self.height*0.6))];
        [_lineColor setStroke];
        [bezier stroke];
    
    CGContextStrokePath(context);
    CGContextClosePath(context);
}

-(CGPoint)leftPointInView:(UIView *)view{
    return [self convertPoint:_leftPoint toView:view];
}

-(CGPoint)rightPointInView:(UIView *)view{
    return [self convertPoint:_rightPoint toView:view];
}


@end
