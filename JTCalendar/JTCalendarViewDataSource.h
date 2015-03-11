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
- (void)calendarDidLoadPreviousPage;
- (void)calendarDidLoadNextPage;

@end

//Range of dates
typedef enum : NSUInteger {
    JTCalendarDateNoRangeSelected, //the type used when there isn't a date range specified at all
    JTCalendarDateBeforeRange,
    JTCalendarDateAfterRange,
    JTCalendarDateRangeBeginDate,
    JTCalendarDateRangeEndDate,
    JTCalendarDateRangeMiddleDate
} JTCalendarDateRange;

@protocol JTCalendarDateRangeDelegate <NSObject>
@required
- (void)styleDayBackgroundView:(UIView *)backgroundView forDateInRange:(JTCalendarDateRange)dateRange;
@end