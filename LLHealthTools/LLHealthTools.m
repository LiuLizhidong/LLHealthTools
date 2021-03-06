//
//  LLHealthTools.m
//  LLHealthDemo
//
//  Created by 刘李治东 on 16/1/31.
//  Copyright © 2016年 刘李治东. All rights reserved.
//

#import "LLHealthTools.h"

@interface LLHealthTools()
@property (nonatomic, strong) HKHealthStore *healthStore;
@end

@implementation LLHealthTools

+ (instancetype)sharedTools {
    static id instance;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        if (!instance) {
            instance = [[self alloc] init];
        }
    });
    return instance;
}

/**
 *  获取今日健康数据
 *
 *  @param healthType 需要获取的数据类型
 *
 *  @return 今日健康数据
 */
- (double)getTodayHealthDataWithType:(LLHealthType)healthType {
    
    __block double healthData;
    
    __block HKQuantityType *type;
    
    switch (healthType) {
        case 0:
            type = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
            break;
        case 1:
            type = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
            break;
        case 2:
            type = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceCycling];
            break;
        case 3:
            type = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalEnergyBurned];
            break;
        case 4:
            type = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
            break;
        default:
            break;
    }
    NSSet *readTypes = [NSSet setWithObject:type];
    
    _healthStore = [[HKHealthStore alloc] init];
    [_healthStore requestAuthorizationToShareTypes:nil readTypes:readTypes completion:^(BOOL success, NSError * _Nullable error) {
        if (!success) {
            NSLog(@"没有获取授权!!!");
        } else {
            NSDate *beginDate = [DateTool zeroToday:[NSDate date]];
            NSDate *endDate = [DateTool locationTime:[NSDate date]];
            
            NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:beginDate endDate:endDate options:HKQueryOptionNone];
            
             HKStatisticsQuery * query = [[HKStatisticsQuery alloc] initWithQuantityType:type
                                                                 quantitySamplePredicate:predicate
                                                                                 options:HKStatisticsOptionCumulativeSum
                                                                       completionHandler:^(HKStatisticsQuery * _Nonnull query,
                                                                                           HKStatistics * _Nullable result,
                                                                                           NSError * _Nullable error) {
                if (result) {

                    // 单位转换
                    HKUnit *unit = [HKUnit new];
                    if (healthType == footType) {
                        unit = [HKUnit countUnit];  // 步数
                    } else if (healthType == cyclingType || healthType == walkType) {
                        unit = [HKUnit meterUnit];  // 米
                    } else {
                        unit = [HKUnit jouleUnit];  // 焦耳
                    }

                    // 行走的步数
                    healthData = [result.sumQuantity doubleValueForUnit:unit];  // 步数
                }
            }];
            [_healthStore executeQuery:query];
        }
    }];
    
    return healthData;
}

@end
