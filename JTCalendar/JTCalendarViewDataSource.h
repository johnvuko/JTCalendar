//
//  JTCalendarDataSource.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <Foundation/Foundation.h>

@class JTCalendar;

@protocol JTCalendarDataSource <NSObject>

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date;
- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date;

@optional
- (UIColor *)colorForDot:(JTCalendar *)calendar date:(NSDate *)date defaultDotColor:(UIColor *)defaultColor;
- (void)calendarDidLoadPreviousPage;
- (void)calendarDidLoadNextPage;

@end
