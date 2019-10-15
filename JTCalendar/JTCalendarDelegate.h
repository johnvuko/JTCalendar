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
- (UIView *_Nullable)calendarBuildMenuItemView:(JTCalendarManager *_Nullable)calendar;

/*!
 * Used to customize the menuItemView.
 * Set text attribute to the name of the month by default.
 */
- (void)calendar:(JTCalendarManager *_Nullable)calendar prepareMenuItemView:(UIView *_Nullable)menuItemView date:(NSDate *_Nullable)date;


// Content view


/*!
 * Indicate if the calendar can go to this date.
 * Return `YES` by default.
 */
- (BOOL)calendar:(JTCalendarManager *_Nullable)calendar canDisplayPageWithDate:(NSDate *_Nullable)date;

/*!
 * Provide the date for the previous page.
 * Return 1 month before the current date by default.
 */
- (NSDate *_Nullable)calendar:(JTCalendarManager *_Nullable)calendar dateForPreviousPageWithCurrentDate:(NSDate *_Nullable)currentDate;

/*!
 * Provide the date for the next page.
 * Return 1 month after the current date by default.
 */
- (NSDate *_Nullable)calendar:(JTCalendarManager *_Nullable)calendar dateForNextPageWithCurrentDate:(NSDate *_Nullable)currentDate;

/*!
 * Indicate the previous page became the current page.
 */
- (void)calendarDidLoadPreviousPage:(JTCalendarManager *_Nullable)calendar;

/*!
 * Indicate the next page became the current page.
 */
- (void)calendarDidLoadNextPage:(JTCalendarManager *_Nullable)calendar;

/*!
 * Provide a view conforming to `JTCalendarPage` protocol, used as page for the contentView.
 * Return an instance of `JTCalendarPageView` by default.
 */
- (UIView<JTCalendarPage> *_Nullable)calendarBuildPageView:(JTCalendarManager *_Nullable)calendar;


// Page view


/*!
 * Provide a view conforming to `JTCalendarWeekDay` protocol.
 * Return an instance of `JTCalendarWeekDayView` by default.
 */
- (UIView<JTCalendarWeekDay> *_Nullable)calendarBuildWeekDayView:(JTCalendarManager *_Nullable)calendar;

/*!
 * Provide a view conforming to `JTCalendarWeek` protocol.
 * Return an instance of `JTCalendarWeekView` by default.
 */
- (UIView<JTCalendarWeek> *_Nullable)calendarBuildWeekView:(JTCalendarManager *_Nullable)calendar;


// Week view


/*!
 * Provide a view conforming to `JTCalendarDay` protocol.
 * Return an instance of `JTCalendarDayView` by default.
 */
- (UIView<JTCalendarDay> *_Nullable)calendarBuildDayView:(JTCalendarManager *_Nullable)calendar;


// Day view


/*!
 * Used to customize the dayView.
 */
- (void)calendar:(JTCalendarManager *_Nullable)calendar prepareDayView:(UIView<JTCalendarDay> *_Nullable)dayView;

/*!
 * Indicate the dayView just get touched.
 */
- (void)calendar:(JTCalendarManager *_Nullable)calendar didTouchDayView:(UIView<JTCalendarDay> *_Nullable)dayView;

@end
