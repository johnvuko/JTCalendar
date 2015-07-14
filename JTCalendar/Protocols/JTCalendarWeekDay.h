//
//  JTCalendarWeekDay.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <Foundation/Foundation.h>

@class JTCalendarManager;

@protocol JTCalendarWeekDay <NSObject>

- (void)setManager:(JTCalendarManager *)manager;

- (void)reload;

@end
