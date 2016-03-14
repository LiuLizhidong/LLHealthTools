//
//  DateTool.m
//  LLHealthDemo
//
//  Created by 刘李治东 on 16/3/15.
//  Copyright © 2016年 刘李治东. All rights reserved.
//

#import "DateTool.h"

@implementation DateTool

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
    [newComponents setDay:dateComponents.day];
    [newComponents setHour:0];
    [newComponents setMinute:0];
    [newComponents setSecond:0];
    
    NSDate *date = [calendar dateFromComponents:newComponents];
    NSDate *newDate = [self locationTime:date];
    
    return newDate;
}

@end
