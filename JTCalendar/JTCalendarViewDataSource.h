//
//  JTCalendarDataSource.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <Foundation/Foundation.h>

@class JTCalendar;

@protocol JTCalendarDataSource <NSObject>

/** This method is used to check if the calendar should show a dot on the selected day for an event */
- (BOOL)calendar:(JTCalendar *)calendar hasEventForDate:(NSDate *)date;

/** This method is used to notify the data source when a date was selected */
- (void)calendar:(JTCalendar *)calendar dateSelected:(NSDate *)date;

@optional
- (void)calendarDidLoadPreviousPage;
- (void)calendarDidLoadNextPage;

/** This method offers the opportunity to prevent a date from being selected if you would
 like to exclude it from being selectable */
- (BOOL)calendar:(JTCalendar *)calendar dateCanBeSelected:(NSDate *)date;

/** This method is used to check if the calendar should show a dot on the selected day for an event
 @deprecated This method was deprecated in favor of `calendar:hasEventForDate:` */
- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date __deprecated_msg("Use -calendar:hasEventForDate: instead");

/** This method is used to notify the data source when a date was selected
 @deprecated This method was deprecated in favor of `calendar:calendar:dateSelected:` */
- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date __deprecated_msg("Use -calendar:dateSelected: instead");

@end

