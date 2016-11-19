//
//  EPPieChartModel.h
//  pie
//
//  Created by luchanghao on 16/10/27.
//  Copyright © 2016年 HC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface EPPieChartCardModel : NSObject

@property (nonatomic, strong) UIColor *BgColor;
@property (nonatomic, strong) UIColor *headBG;
@property (nonatomic, strong) NSMutableArray *valueArray;
@property (nonatomic, strong) NSMutableArray *colorArray;
@property (nonatomic, strong) NSMutableArray *detailArray;
@property (nonatomic, strong) NSString *centerTitle;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat lineWidth;


@property (nonatomic, assign) CGFloat totalValue;
@property (nonatomic, strong) NSMutableArray *angleArray;
@property (nonatomic, strong) NSMutableArray *startAngleArray;
@property (nonatomic, strong) NSMutableArray *infoViewFrame;
@property (nonatomic, strong) NSMutableArray *startPointArray;

@property (nonatomic, assign) CGFloat cardHeight;
+ (instancetype)modelWithDic:(NSDictionary *)dic target:(id)target;
@end
