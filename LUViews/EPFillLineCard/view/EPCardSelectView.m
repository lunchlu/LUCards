//
//  EPCardSelectView.m
//  view11-8
//
//  Created by luchanghao on 16/11/9.
//  Copyright © 2016年 macBook. All rights reserved.
//
#import "cong.h"

#import "EPCardSelectView.h"
#import "UIView+Frame.h"



@interface EPCardSelectView ()
//UI
@property (nonatomic, weak)   UIWindow *win;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *img;

@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIScrollView *selectView;
@property (nonatomic, strong) UIScrollView *detailContainView;
@property (nonatomic, assign) CGSize detailSize;

//数据
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSMutableArray *frameArray;
@end

@implementation EPCardSelectView

-(void)dealloc{
    _coverView.hidden = YES;
    _coverView.frame = CGRectZero;
    _coverView = nil;
    
//    _selectView.hidden = YES;
//    _selectView.frame = CGRectZero;
//    _selectView = nil;
}

- (id)initWithFrame:(CGRect)frame title:(NSString *)title titleSize:(CGFloat)titileSize
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupSelf];
        self.titleLabel.font = [UIFont systemFontOfSize:titileSize];
        self.title = title;
        
        ////////////////////
        self.detailSize = CGSizeMake(60, 30);
        
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self tapOnSelf];
}

- (void)setupSelf{
    
    self.frameArray= [NSMutableArray new];
    
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = COLOR_RGB(165, 166, 186).CGColor;//设置列表边框
    self.layer.cornerRadius = self.frame.size.height * 0.5;
    self.clipsToBounds = YES;
    
    self.titleLabel = [[UILabel alloc] init];
    [self addSubview:self.titleLabel];
    
    self.img = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, 12, 12))];
    self.img.image = [UIImage imageNamed:@"pull.png"];
    [self addSubview:self.img];
    
    self.coverView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT))];
    _coverView.hidden = YES;
    _coverView.backgroundColor = [UIColor clearColor];
    self.win = [UIApplication sharedApplication].windows.lastObject;
    [_win addSubview:_coverView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnCover)];
    [_coverView addGestureRecognizer:tap];
    
    self.selectView = [[UIScrollView alloc] init];
    [_coverView addSubview:_selectView];
//    _selectView.backgroundColor = COLOR_Random;
    
    self.detailContainView = [[UIScrollView alloc] init];
    [self.selectView addSubview:_detailContainView];
    
}

- (void)tapOnSelf{
    CGSize size;
    if (_delegate
        &&[_delegate respondsToSelector:@selector(sizeForSelectView:)]) {
        size = [_delegate sizeForSelectView:self];
    }
    else{
        size = self.superview.size;
    }
    
    CGRect frame =  [self setFrameForSelectView:size];
    _selectView.frame = frame;
    
    [self setDetailLayout];
    
    self.coverView.hidden = NO;
    [_win bringSubviewToFront:_coverView];
    
    [self animationForArrow];
}

- (void)tapOnCover{
    _coverView.hidden = YES;
    [self animationForArrow];
}

- (void)setDetailLayout{
    CGFloat startX;
    if (_delegate) {
        CGPoint pointIndelegate = [self.superview convertPoint:self.frame.origin toView:(UIView *)_delegate];
        startX = pointIndelegate.x;

    }
    else{
        startX = self.left;
    }

    
    int allW = (int)(startX  / (_detailSize.width +5))  +  (int)((_coverView.width-startX -10)/(_detailSize.width +5));//以当前位置开始，最多的w个数
    
    //最多的h个数
    int HCount = _selectView.height / (_detailSize.height+5);
    //start开始的最大w个数
    int WCount = (_selectView.width - startX) / (_detailSize.width +5);
    
    if (HCount * WCount >= _dataArray.count) {
        [self start:startX HCount:HCount];
    }
    else if(HCount * allW >= _dataArray.count){
        int moveCount = (int)(_dataArray.count - HCount * WCount) / HCount
        ;
        startX = startX-moveCount*_detailSize.width -5;
        WCount += moveCount;
        [self start:startX HCount:HCount];
    }
    else{
        allW = _selectView.width / (_detailSize.width +5);
        HCount = (int)_dataArray.count /allW + 1 ;
        WCount = allW;
        startX = (SCREEN_WIDTH - (_detailSize.width+5)*WCount)*0.5 -2.5;

        [self start:startX HCount:HCount];
    }
    
    CGFloat maxBottom = 0;
    for (NSValue *value in _frameArray) {
        CGRect rect = [value CGRectValue];
        if ((rect.origin.y + rect.size.width) > maxBottom) {
            maxBottom = (rect.origin.y + rect.size.width);
        }
    }
    

    _detailContainView.frame = CGRectMake(startX, 0, (_dataArray.count/HCount +(_dataArray.count%HCount ==0 ? 0: 1) ) * (_detailSize.width+5), _selectView.height);
    _detailContainView.backgroundColor = COLOR_RGB(235, 235, 235);
    _detailContainView.layer.cornerRadius = 10;
    
    _detailContainView.contentSize = CGSizeMake(_detailContainView.width, maxBottom - 20);
    
    
//    _selectView.left +=_detailContainView.left;
//    _selectView.width-= _detailContainView.width;
//    _detailContainView.layer.cornerRadius = 10;
    
}

- (void)start:(CGFloat)start HCount:(NSInteger)h{
    for (UIView *view in _detailContainView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    
    
    for (int i = 0; i<_dataArray.count; i++) {
        CGRect frame = CGRectMake( 5*(i/h) + i/h * _detailSize.width  , 5 +((i)%h *5) + i%h *_detailSize.height, _detailSize.width, _detailSize.height);
        
        [self.frameArray addObject:[NSValue valueWithCGRect:frame]];
        
        UIButton *lab = [[UIButton alloc] initWithFrame:frame];
        lab.titleLabel.font = _titleLabel.font;
        [lab setTitle:_dataArray[i] forState:(UIControlStateNormal)];
        lab.titleLabel.textAlignment = NSTextAlignmentLeft;
        [lab setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_detailContainView addSubview:lab];
        lab.tag = 1000+ i;
        [lab addTarget:self action:@selector(labClick:) forControlEvents:(UIControlEventTouchUpInside)];
        
        UIView *line = [[UIView alloc] initWithFrame:(CGRectMake(5, 0, lab.width-10, 0.5))];
        line.bottom = lab.height;
        line.backgroundColor = COLOR_RGB(215, 215, 215);
        [lab addSubview:line];
        
    }
}

-(void)labClick:(UIButton *)btn{
    if (_delegate
        &&[_delegate respondsToSelector:@selector(EPCardSelectView:didSelectedWith:)]) {
        [_delegate EPCardSelectView:self didSelectedWith:_dataArray[btn.tag-1000]];
    }
    self.title = _dataArray[btn.tag-1000];
    
    [self tapOnCover];
}

-(CGRect)setFrameForSelectView:(CGSize)delegateSize{
    
    CGPoint pointIndelegate = [self.superview convertPoint:self.frame.origin toView:(UIView *)_delegate];
    
    CGPoint pointInwin = [self.superview convertPoint:self.frame.origin toView:_win];
    
    
    return CGRectMake(0, pointInwin.y + self.height+5, SCREEN_WIDTH, delegateSize.height-pointIndelegate.y -_detailSize.height- 30);
}

-(void)animationForArrow{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.img.layer.transform = CATransform3DMakeRotation(!_coverView.hidden* M_PI, 0, 0, 1);
    } completion:NULL];
}

#pragma - mark get/set
-(void)setTitle:(NSString *)title{
    _title = title;
    
    _titleLabel.frame = CGRectMake(0, 0, 10, self.height);
    _titleLabel.text = title;
    [_titleLabel sizeToFit];
    _titleLabel.height = self.height;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    CGFloat allWidth = _titleLabel.width + _img.width;
    CGFloat x = (self.width - allWidth) * 0.5;
    _titleLabel.left = x;
    
    _img.left = _titleLabel.right;
    _img.centerY = _titleLabel.centerY;
}

-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    _titleLabel.textColor = titleColor;
}

-(void)setTitleBackGroundColor:(UIColor *)titleBackGroundColor{
    _titleBackGroundColor = titleBackGroundColor;
    self.backgroundColor = titleBackGroundColor;
}

@end






















