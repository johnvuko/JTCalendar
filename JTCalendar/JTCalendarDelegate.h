//
//  JTCalendarDelegate.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

#import "JTCalendarPage.h"
#import "JTCalendarWeek.h"
#import "JTCalendarWeekDay.h"
#import "JTCalendarDay.h"

@class JTCalendarManager;

@protocol JTCalendarDelegate <NSObject>

@optional


// Menu view


/*!
 * Provide a UIView, used as page for the menuView.
 * Return an instance of `UILabel` by default.
 */
- (UIView *)calendarBuildMenuItemView:(JTCalendarManager *)calendar;

/*!
 * Used to customize the menuItemView.
 * Set text attribute to the name of the month by default.
 */
- (void)calendar:(JTCalendarManager *)calendar prepareMenuItemView:(UIView *)menuItemView date:(NSDate *)date;


// Content view


/*!
 * Indicate if the calendar can go to this date.
 * Return `YES` by default.
 */
- (BOOL)calendar:(JTCalendarManager *)calendar canDisplayPageWithDate:(NSDate *)date;

/*!
 * Provide the date for the previous page.
 * Return 1 month before the current date by default.
 */
- (NSDate *)calendar:(JTCalendarManager *)calendar dateForPreviousPageWithCurrentDate:(NSDate *)currentDate;

/*!
 * Provide the date for the next page.
 * Return 1 month after the current date by default.
 */
- (NSDate *)calendar:(JTCalendarManager *)calendar dateForNextPageWithCurrentDate:(NSDate *)currentDate;

/*!
 * Indicate the previous page became the current page.
 */
- (void)calendarDidLoadPreviousPage:(JTCalendarManager *)calendar;

/*!
 * Indicate the next page became the current page.
 */
- (void)calendarDidLoadNextPage:(JTCalendarManager *)calendar;

/*!
 * Provide a view conforming to `JTCalendarPage` protocol, used as page for the contentView.
 * Return an instance of `JTCalendarPageView` by default.
 */
- (UIView<JTCalendarPage> *)calendarBuildPageView:(JTCalendarManager *)calendar;


// Page view


/*!
 * Provide a view conforming to `JTCalendarWeekDay` protocol.
 * Return an instance of `JTCalendarWeekDayView` by default.
 */
- (UIView<JTCalendarWeekDay> *)calendarBuildWeekDayView:(JTCalendarManager *)calendar;

/*!
 * Provide a view conforming to `JTCalendarWeek` protocol.
 * Return an instance of `JTCalendarWeekView` by default.
 */
- (UIView<JTCalendarWeek> *)calendarBuildWeekView:(JTCalendarManager *)calendar;


// Week view


/*!
 * Provide a view conforming to `JTCalendarDay` protocol.
 * Return an instance of `JTCalendarDayView` by default.
 */
- (UIView<JTCalendarDay> *)calendarBuildDayView:(JTCalendarManager *)calendar;


// Day view


/*!
 * Used to customize the dayView.
 */
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(UIView<JTCalendarDay> *)dayView;

/*!
 * Indicate the dayView just get touched.
 */
- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(UIView<JTCalendarDay> *)dayView;

@end
