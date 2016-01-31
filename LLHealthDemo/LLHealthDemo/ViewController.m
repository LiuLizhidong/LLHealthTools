//
//  ViewController.m
//  LLHealthDemo
//
//  Created by 刘李治东 on 16/1/31.
//  Copyright © 2016年 刘李治东. All rights reserved.
//

#import "ViewController.h"
#import "LLHealthTools/LLHealthTools.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *todayStepsCount;
@property (weak, nonatomic) IBOutlet UILabel *todayStepsKilomiter;
@property (weak, nonatomic) IBOutlet UILabel *todayRunningCount;
@property (weak, nonatomic) IBOutlet UILabel *todayRunningKilomiter;
@property (weak, nonatomic) IBOutlet UILabel *todaySteps;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// 获取今日步数
- (IBAction)getTodayStepsCount:(id)sender {
    double todayStepsCount = [[LLHealthTools sharedTools] getTodayStepsCountWithType:footType];
    NSString *todayStepsCountStr = [NSString stringWithFormat:@"%f", todayStepsCount];
    _todayStepsCount.text = todayStepsCountStr;
}

// 获取今日步行公里数
- (IBAction)getTodayStepsKilomiter:(id)sender {
    double todayStepsKilomiter = [[LLHealthTools sharedTools] getTodayStepsCountWithType:walkType];
    NSString *todayStepsKilomiterStr = [NSString stringWithFormat:@"%f", todayStepsKilomiter];
    _todayStepsKilomiter.text = todayStepsKilomiterStr;
}

// 获取今日跑步数
- (IBAction)getTodayRunningCount:(id)sender {
    
}

// 获取今日跑步公里数
- (IBAction)getTodayRunningKilomiter:(id)sender {
}

// 获取今日总步数
- (IBAction)getTodaySteps:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
