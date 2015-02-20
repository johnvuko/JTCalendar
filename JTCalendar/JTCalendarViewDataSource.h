//
//  JTCalendarDataSource.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <Foundation/Foundation.h>

@class JTCalendar;

@protocol JTCalendarDataSource <NSObject>

/**
 * Called to determine whether to show the 'day dot' for a particular date.
 * Note: This method is deprecated. Use `calendarNumberOfEvents` instead.
 */
- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date __deprecated;

/**
 * Called to determine whether the show the 'day dot' for a particular date.
 * Anything about 0 will show the day dot.
 */
- (NSUInteger)calendarNumberOfEvents:(JTCalendar *)calendar date:(NSDate *)date;

/**
 * Callback when a particular date is selected
 */
- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date;

@optional
- (void)calendarDidLoadPreviousPage;
- (void)calendarDidLoadNextPage;

@end
