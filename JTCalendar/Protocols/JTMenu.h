//
//  JTMenu.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <Foundation/Foundation.h>

@class JTCalendarManager;

NS_ASSUME_NONNULL_BEGIN
@protocol JTMenu <NSObject>

- (void)setManager:(JTCalendarManager *)manager;

- (void)setPreviousDate:(NSDate *)previousDate
            currentDate:(NSDate *)currentDate
               nextDate:(NSDate *)nextDate;

- (void)updatePageMode:(NSUInteger)pageMode;

- (UIScrollView *)scrollView;

@end
NS_ASSUME_NONNULL_END
