//
//  EPProgressCardModel.m
//  view11-1
//
//  Created by macBook on 16/11/1.
//  Copyright © 2016年 macBook. All rights reserved.
//

#import "EPHorizonProgressCardModel.h"
#import <UIKit/UIKit.h>

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation EPHorizonProgressCardModel
+ (instancetype)modelWithDic:(NSDictionary *)dic target:(id)target
{
    return [[self alloc]initWithDic:dic target:target];
}
- (instancetype)initWithDic:(NSDictionary *)dic target:(id)target
{
    self = [super init];
    if (self
        && dic
        && [dic isKindOfClass:[NSDictionary class]])
    {
        self.progressArray = [NSMutableArray arrayWithArray:@[
               @"已审核", @"已监控", @"已验收", @"待验收审核", @"待付款", @"带评价"
                                                              ]];
        self.title = @"进度";
        self.dateTitle = @"2016/10/20";
        self.cellHeight = 180;
        self.nowProgress = 3;
    }
    
    [self makePoints];
    
    return self;
}

-(void)makePoints{
    double count = _progressArray.count;
    self.drawPointsArray = [NSMutableArray new];
    CGFloat x = 0.0;
    for (int i = 0; i<count; i++) {
        
        if (i == 0) {
            x =  15 + 15 +7.5;
        }
        else if (i == count-1){
            x = SCREEN_WIDTH - 37.5 ;
        }
        else{
            x +=( (SCREEN_WIDTH - 75) / (count - 1) );
        }
        [_drawPointsArray addObject:@(x)];

    }
}

@end





















