//
//  JTCalendarDay.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <Foundation/Foundation.h>

@class JTCalendarManager;

NS_ASSUME_NONNULL_BEGIN
@protocol JTCalendarDay <NSObject>

- (void)setManager:(JTCalendarManager *)manager;

- (NSDate *)date;
- (void)setDate:(NSDate *)date;

- (BOOL)isFromAnotherMonth;
- (void)setIsFromAnotherMonth:(BOOL)isFromAnotherMonth;

@end
NS_ASSUME_NONNULL_END