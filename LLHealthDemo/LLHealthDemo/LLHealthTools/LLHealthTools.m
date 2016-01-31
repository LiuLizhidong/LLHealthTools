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
- (double)getTodayStepsCountWithType:(LLHealthType)healthType {
    
    __block double todayStepsCount;
    
    HKQuantityType *type;
    switch (healthType) {
        case 0:
            type = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
            break;
        case 1:
            type = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
        default:
            break;
    }
    NSSet *readTypes = [NSSet setWithObject:type];
    
    _healthStore = [[HKHealthStore alloc] init];
    [_healthStore requestAuthorizationToShareTypes:nil readTypes:readTypes completion:^(BOOL success, NSError * _Nullable error) {
        if (!success) {
            NSLog(@"没有获取授权!!!");
        } else {
            NSDate *beginDate = [self zeroToday:[self locationTime:[NSDate date]]];
            NSDate *endDate = [self locationTime:[NSDate date]];
            
            NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:beginDate endDate:endDate options:HKQueryOptionNone];
            
            HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:footType quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery * _Nonnull query, HKStatistics * _Nullable result, NSError * _Nullable error) {
                if (result) {
                    // 行走的步数
                    todayStepsCount = [result.sumQuantity doubleValueForUnit:[HKUnit countUnit]];  // 步数
                }
            }];
            [_healthStore executeQuery:query];
        }
    }];
    
    return todayStepsCount;
}

#pragma mark- 时间转换
/**
 *  转换本地时间
 *
 *  @param today 格林威治时间
 *
 *  @return 当前系统时区时间
 */
- (NSDate *)locationTime:(NSDate *)today {
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:today];
    NSDate *locationTime = [today dateByAddingTimeInterval:interval];
    return locationTime;
}

/**
 *  转换零点时间
 *
 *  @param today 格林威治时间
 *
 *  @return 当前日期零点时间
 */
- (NSDate *)zeroToday:(NSDate *)today {
    NSDate *now = [self locationTime:today];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekday|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:now];
    
    NSDateComponents *newComponents = [[NSDateComponents alloc] init];
    [newComponents setYear:dateComponents.year];
    [newComponents setMonth:dateComponents.month];
    [newComponents setWeekday:dateComponents.weekday];
    [newComponents setDay:dateComponents.day-1];
    [newComponents setHour:0];
    [newComponents setMinute:0];
    [newComponents setSecond:0];

    NSDate *date = [calendar dateFromComponents:newComponents];
    NSDate *newDate = [self locationTime:date];
    
    return newDate;
}

@end
