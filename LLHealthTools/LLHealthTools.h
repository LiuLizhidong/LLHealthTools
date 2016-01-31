//
//  LLHealthTools.h
//  LLHealthDemo
//
//  Created by 刘李治东 on 16/1/31.
//  Copyright © 2016年 刘李治东. All rights reserved.
//
typedef enum {
    footType = 0, // 步行
    walkType,     // 跑步
}LLHealthType;

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>

@interface LLHealthTools : NSObject

+ (instancetype)sharedTools;
- (double)getTodayStepsCountWithType:(LLHealthType)healthType;

@end
