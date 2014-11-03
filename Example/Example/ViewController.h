//
//  ViewController.h
//  Example
//
//  Created by Jonathan on 03/11/14.
//  Copyright (c) 2014 Jonathan Tribouharet. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JTCalendar.h"

@interface ViewController : UIViewController<JTCalendarDataSource>

@property (strong, nonatomic) JTCalendarMenuView *calendarMenuView;
@property (strong, nonatomic) JTCalendarContentView *calendarContentView;

@property (strong, nonatomic) JTCalendar *calendar;

@end
