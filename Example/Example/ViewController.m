//
//  ViewController.m
//  Example
//
//  Created by Jonathan Tribouharet.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.calendar = [JTCalendar new];
    
    // All modifications on calendarAppearance have to be done before setMenuMonthsView and setContentView
    // Or you will have to call reloadAppearance
    {
        self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
        self.calendar.calendarAppearance.dayCircleRatio = 9. / 10.;
        self.calendar.calendarAppearance.ratioContentMenu = 1.;
    }
    
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.calendar reloadData]; // Must be call in viewDidAppear
}

#pragma mark - Buttons callback

- (IBAction)didGoTodayTouch
{
    [self.calendar setCurrentDate:[NSDate date]];
}

- (IBAction)didChangeModeTouch
{
    self.calendar.calendarAppearance.isWeekMode = !self.calendar.calendarAppearance.isWeekMode;
    
    [self transitionExample];
}

#pragma mark - JTCalendarDataSource

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    return (rand() % 10) == 1;
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    NSLog(@"Date: %@", date);
}

#pragma mark - Transition examples

- (void)transitionExample
{
    CGFloat newHeight = 300;
    if(self.calendar.calendarAppearance.isWeekMode){
        newHeight = 75.;
    }
    
    [UIView animateWithDuration:.5
                     animations:^{
                         self.calendarContentViewHeight.constant = newHeight;
                         [self.view layoutIfNeeded];
                     }];
    
    [UIView animateWithDuration:.25
                     animations:^{
                         self.calendarContentView.layer.opacity = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.calendar reloadAppearance];
                         
                         [UIView animateWithDuration:.25
                                          animations:^{
                                              self.calendarContentView.layer.opacity = 1;
                                          }];
                     }];
}

@end
