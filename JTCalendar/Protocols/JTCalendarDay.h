//
//  JTCalendarDay.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <Foundation/Foundation.h>

@class JTCalendarManager;

@protocol JTCalendarDay <NSObject>

- (void)setManager:(JTCalendarManager *)manager;

- (NSDate *)date;
- (void)setDate:(NSDate *)date;

- (BOOL)isFromAnotherMonth;
- (void)setIsFromAnotherMonth:(BOOL)isFromAnotherMonth;

@end
