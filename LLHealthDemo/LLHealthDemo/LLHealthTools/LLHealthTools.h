//
//  LLHealthTools.h
//  LLHealthDemo
//
//  Created by 刘李治东 on 16/1/31.
//  Copyright © 2016年 刘李治东. All rights reserved.
//

typedef enum {
    footType,     // 步行
    walkType,     // 跑步
    cyclingType,  // 骑行
    basalEnergyType,   // 静息能量
    activeEnergyType,  // 活动能量
} LLHealthType;

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>
#import "DateTool.h"

@interface LLHealthTools : NSObject

+ (instancetype)sharedTools;
- (double)getTodayHealthDataWithType:(LLHealthType)healthType;

@end
