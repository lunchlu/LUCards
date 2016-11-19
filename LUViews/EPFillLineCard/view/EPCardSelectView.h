//
//  EPCardSelectView.h
//  view11-8
//
//  Created by luchanghao on 16/11/9.
//  Copyright © 2016年 macBook. All rights reserved.
//
#import "cong.h"

#import <UIKit/UIKit.h>

@class EPCardSelectView;
@protocol EPCardSelectViewDelegate <NSObject>
- (void)EPCardSelectView:(EPCardSelectView *)SelectView didSelectedWith:(NSString *)string;
- (CGSize)sizeForSelectView:(EPCardSelectView *)SelectView;
@end


@interface EPCardSelectView : UIView
@property (nonatomic, strong) NSMutableArray<NSString *> *dataArray;//传值
@property (nonatomic, weak) id<EPCardSelectViewDelegate> delegate;//必须是uiview
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *titleBackGroundColor;
- (id)initWithFrame:(CGRect)frame title:(NSString *)title titleSize:(CGFloat)titileSize;//初始化    titleSize:字体大小
@end
