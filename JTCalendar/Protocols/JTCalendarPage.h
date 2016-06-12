//
//  JTCalendarPage.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <Foundation/Foundation.h>

@class JTCalendarManager;

NS_ASSUME_NONNULL_BEGIN
@protocol JTCalendarPage <NSObject>

- (void)setManager:(JTCalendarManager *)manager;

- (NSDate *)date;
- (void)setDate:(NSDate *)date;

- (void)reload;

@end
NS_ASSUME_NONNULL_END