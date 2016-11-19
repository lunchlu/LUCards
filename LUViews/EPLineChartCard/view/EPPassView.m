//
//  EPPassView.m
//  view11-11
//
//  Created by luchanghao on 16/11/11.
//  Copyright © 2016年 luchanghao. All rights reserved.
//

#import "EPPassView.h"
#import "UIView+Frame.h"
#import "cong.h"

@interface EPPassView ()
{
    
    UIView *_outView;
    UIView *_inView;
    
    UILabel *_detailLab;
    UILabel *_passLab;
    UIImageView *_passImg;
}

@end

@implementation EPPassView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, 76, 76);
        [self setup];
    }
    return self;
}

-(void)setup{
    _outView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:_outView];
    _outView.layer.cornerRadius = _outView.width*0.5;
    _outView.backgroundColor = COLOR_Random;
    
    CGFloat linewidth = 4;
    _inView = [[UIView alloc] initWithFrame:(CGRectMake(linewidth, linewidth, self.width - linewidth*2, self.height - linewidth*2))];
    [self addSubview:_inView];
    _inView.layer.cornerRadius = _inView.width*0.5;
    _inView.backgroundColor = COLOR_Random;
    
    _passLab = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, self.width -8, 18))];
    _passLab.center = CGPointMake(self.width*0.5, self.height*0.5);
    _passLab.textColor = [UIColor whiteColor];
    [self addSubview:_passLab];
    _passLab.textAlignment = NSTextAlignmentCenter;
    _passLab.font = [UIFont systemFontOfSize:16];
    _passLab.text = @"不通过";
    
    
    _detailLab = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, self.width -16, 9))];
    _detailLab.center = _passLab.center;
    _detailLab.top -= ((_passLab.height + _detailLab.height)*0.5);
    [self addSubview:_detailLab];
    _detailLab.textAlignment = NSTextAlignmentCenter;
    _detailLab.font = [UIFont systemFontOfSize:9];
    _detailLab.text = @"压力测试";
    
    _passImg = [[UIImageView alloc] initWithFrame:_passLab.frame];
    _passImg.width = _passImg.height;
    _passImg.center = _passLab.center;
    _passImg.centerY += (_passLab.height +2);
    _passImg.image = [UIImage imageNamed:@"eppassNotPass@3"];
    [self addSubview:_passImg];
    
}

-(void)setPassStr:(NSString *)passStr{
    _passStr = passStr;
    _passLab.text = passStr;
}

-(void)setDetailStr:(NSString *)detailStr{
    _detailStr = detailStr;
    _detailLab.text = detailStr;
}

-(void)setIsPass:(BOOL)isPass{
    _isPass = isPass;
    if (isPass) {
        _outView.backgroundColor = COLOR_RGBA(63, 222, 195, 1);
        _inView.backgroundColor = COLOR_RGBA(44, 160, 141, 0.8);
        _detailLab.textColor = COLOR_RGBA(230, 230, 230, 0.7);

        _passImg.image = [UIImage imageNamed:@"eppassPass"];
    }
    else{
        _outView.backgroundColor = COLOR_RGBA(255, 142, 142, 1);
        _inView.backgroundColor = COLOR_RGBA(209, 75, 75, 1);
        _detailLab.textColor = COLOR_RGBA(230, 230, 230, 0.7);

        _passImg.image = [UIImage imageNamed:@"eppassNotPass"];

    }
}
@end

























