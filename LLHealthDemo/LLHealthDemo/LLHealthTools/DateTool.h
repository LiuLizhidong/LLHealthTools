//
//  DateTool.h
//  LLHealthDemo
//
//  Created by 刘李治东 on 16/3/15.
//  Copyright © 2016年 刘李治东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateTool : NSObject

+ (instancetype)sharedTools;
- (NSDate *)locationTime:(NSDate *)today;
- (NSDate *)zeroToday:(NSDate *)today;

@end
