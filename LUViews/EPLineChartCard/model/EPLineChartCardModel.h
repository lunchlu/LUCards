//
//  EPLineChartCardModel.h
//  view11-11
//
//  Created by luchanghao on 16/11/11.
//  Copyright © 2016年 luchanghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EPLineChartCardModel : NSObject

@property (nonatomic, strong) NSString *degressStr;//百分号
@property (nonatomic, strong) NSArray  *titleArray;//01:11

@property (nonatomic, assign) CGFloat cardHeight;
@property (nonatomic, assign) CGFloat drawHeight;

@property (nonatomic, strong) NSMutableArray *pointArray;
@property (nonatomic, strong) NSMutableArray *YHeight;
@property (nonatomic, strong) NSMutableArray *Yvalue;
@property (nonatomic, strong) NSMutableArray *Xwidth;


//通过，不通过
@property (nonatomic, assign)BOOL isShowPass;
@property (nonatomic, assign)BOOL isPass;
@property (nonatomic, strong)NSString *passStr;//不通过
@property (nonatomic, strong)NSString *detailStr;//压力测试


+ (instancetype)modelWithDic:(NSDictionary *)dic target:(id)target;

@end
