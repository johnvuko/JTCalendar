//
//  JTDateHelper.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface JTDateHelper : NSObject

- (NSCalendar *)calendar;
- (NSDateFormatter *)createDateFormatter;

- (NSDate *)addToDate:(NSDate *)date months:(NSInteger)months;
- (NSDate *)addToDate:(NSDate *)date weeks:(NSInteger)weeks;
- (NSDate *)addToDate:(NSDate *)date days:(NSInteger)days;

// Must be less or equal to 6
- (NSUInteger)numberOfWeeks:(NSDate *)date;

- (NSDate *)firstDayOfMonth:(NSDate *)date;
- (NSDate *)firstWeekDayOfMonth:(NSDate *)date;
- (NSDate *)firstWeekDayOfWeek:(NSDate *)date;

- (BOOL)date:(NSDate *)dateA isTheSameMonthThan:(NSDate *)dateB;
- (BOOL)date:(NSDate *)dateA isTheSameWeekThan:(NSDate *)dateB;
- (BOOL)date:(NSDate *)dateA isTheSameDayThan:(NSDate *)dateB;

- (BOOL)date:(NSDate *)dateA isEqualOrBefore:(NSDate *)dateB;
- (BOOL)date:(NSDate *)dateA isEqualOrAfter:(NSDate *)dateB;
- (BOOL)date:(NSDate *)date isEqualOrAfter:(NSDate *)startDate andEqualOrBefore:(NSDate *)endDate;

@end
NS_ASSUME_NONNULL_END