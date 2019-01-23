//
//  JTCalendarWeek.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <Foundation/Foundation.h>

@class JTCalendarManager;

NS_ASSUME_NONNULL_BEGIN
@protocol JTCalendarWeek <NSObject>

- (void)setManager:(JTCalendarManager *)manager;

- (NSDate *)startDate;
- (void)setStartDate:(NSDate *)startDate updateAnotherMonth:(BOOL)enable monthDate:(NSDate *)monthDate;

@end
NS_ASSUME_NONNULL_END
