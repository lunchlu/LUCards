//
//  EPProgressCardModel.h
//  view11-1
//
//  Created by luchanghao on 16/11/1.
//  Copyright © 2016年 macBook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPHorizonProgressCardModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *dateTitle;
@property (nonatomic, assign) float cellHeight;
@property (nonatomic, strong) NSMutableArray *drawPointsArray;

@property (nonatomic, strong) NSMutableArray *progressArray;
@property (nonatomic, assign) NSInteger nowProgress;
+ (instancetype)modelWithDic:(NSDictionary *)dic target:(id)target;
@end
