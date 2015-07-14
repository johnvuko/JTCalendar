//
//  JTCalendarDelegateManager.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <Foundation/Foundation.h>

#import "JTCalendarDelegate.h"

// Provide a default behavior when no delegate are provided

@interface JTCalendarDelegateManager : NSObject

@property (nonatomic, weak) JTCalendarManager *manager;

// Menu view

- (UIView *)buildMenuItemView;
- (void)prepareMenuItemView:(UIView *)menuItemView date:(NSDate *)date;

// Content view

- (UIView<JTCalendarPage> *)buildPageView;

- (BOOL)canDisplayPageWithDate:(NSDate *)currentDate;

- (NSDate *)dateForPreviousPageWithCurrentDate:(NSDate *)currentDate;
- (NSDate *)dateForNextPageWithCurrentDate:(NSDate *)currentDate;

// Page view

- (UIView<JTCalendarWeekDay> *)buildWeekDayView;
- (UIView<JTCalendarWeek> *)buildWeekView;


// Week view

- (UIView<JTCalendarDay> *)buildDayView;


// Day view

- (void)prepareDayView:(UIView<JTCalendarDay> *)dayView;
- (void)didTouchDayView:(UIView<JTCalendarDay> *)dayView;

@end
