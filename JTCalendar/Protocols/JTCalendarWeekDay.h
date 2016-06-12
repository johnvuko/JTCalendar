//
//  JTCalendarWeekDay.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <Foundation/Foundation.h>

@class JTCalendarManager;

NS_ASSUME_NONNULL_BEGIN
@protocol JTCalendarWeekDay <NSObject>

- (void)setManager:(JTCalendarManager *)manager;

- (void)reload;

@end
NS_ASSUME_NONNULL_END