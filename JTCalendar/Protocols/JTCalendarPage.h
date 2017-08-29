//
//  JTCalendarPage.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <Foundation/Foundation.h>

@class JTCalendarManager;

@protocol JTCalendarPage <NSObject>

- (void)setManager:(JTCalendarManager *)manager;

- (NSDate *)date;
- (void)setDate:(NSDate *)date;

- (NSDate *)startDate;
- (NSDate *)endDate;

- (void)reload;

@end
