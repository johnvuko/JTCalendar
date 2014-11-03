//
//  ViewController.m
//  Example
//
//  Created by Jonathan on 03/11/14.
//  Copyright (c) 2014 Jonathan Tribouharet. All rights reserved.
//

#import "ViewController.h"

#import <Masonry.h> // Useful for create constraints in code

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.calendarMenuView = [JTCalendarMenuView new];
    
    {
        [self.view addSubview:self.calendarMenuView];
        
        // You can use Interface Builder instead
        [self.calendarMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.top.equalTo(self.view.mas_top).with.offset(22); // 22 for the status bar
            make.height.equalTo(@50);
        }];
        
        // Add a bottom border to calendarMenuView
        {
            UIView *border = [UIView new];
            border.backgroundColor = [UIColor grayColor];
            
            [self.view addSubview:border];
            
            [border mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.calendarMenuView.mas_left);
                make.right.equalTo(self.calendarMenuView.mas_right);
                make.top.equalTo(self.calendarMenuView.mas_bottom);
                make.height.equalTo(@.5);
            }];
        }
    }
    
    self.calendarContentView = [JTCalendarContentView new];
    
    {
        [self.view addSubview:self.calendarContentView];
        
        [self.calendarContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.top.equalTo(self.calendarMenuView.mas_bottom);
            make.height.equalTo(@300);
        }];
    }
    
    {
        UIButton *button = [UIButton new];
        [self.view addSubview:button];
        
        [button setTitle:@"Today" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(didGoTodayTouch) forControlEvents:UIControlEventTouchUpInside];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.calendarContentView.mas_bottom).with.offset(30);
            make.height.equalTo(@50);
            make.centerX.equalTo(self.view.mas_centerX);
        }];
    }
    
    {
        UIButton *button = [UIButton new];
        [self.view addSubview:button];
        
        [button setTitle:@"Change Mode" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(didChangeModeTouch) forControlEvents:UIControlEventTouchUpInside];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.calendarContentView.mas_bottom).with.offset(100);
            make.height.equalTo(@50);
            make.centerX.equalTo(self.view.mas_centerX);
        }];
    }
    
    
    self.calendar = [JTCalendar new];
    
    // All modifications on calendarAppearance have to be done before setMenuMonthsView and setContentView
    // Or you will have to call reloadAppearance
    
    self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
    
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.calendar reloadData]; // Must be call in viewDidAppear
}

- (void)didGoTodayTouch
{
    [self.calendar setCurrentDate:[NSDate date]];
}

- (void)didChangeModeTouch
{
    self.calendar.calendarAppearance.isWeekMode = !self.calendar.calendarAppearance.isWeekMode;
    
    CGFloat newHeight = 300;
    if(self.calendar.calendarAppearance.isWeekMode){
        newHeight = 85.;
    }
    
    [UIView animateWithDuration:.5 animations:^{
        self.calendarContentView.layer.opacity = 0.;
        
        [self.calendarContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo([NSNumber numberWithFloat:newHeight / 2.]);
        }];
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        [self.calendar reloadAppearance];
        
        [UIView animateWithDuration:.5 animations:^{
            self.calendarContentView.layer.opacity = 1;
            
            [self.calendarContentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo([NSNumber numberWithFloat:newHeight]);
            }];
            [self.view layoutIfNeeded];
        }];
    }];
}

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    return (rand() % 10) == 1;
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    NSLog(@"Event touch: %@", date);
}

@end
