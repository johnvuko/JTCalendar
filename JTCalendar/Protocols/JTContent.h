//
//  JTContent.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <Foundation/Foundation.h>

@class JTCalendarManager;

@protocol JTContent <NSObject>

- (void)setManager:(JTCalendarManager *)manager;

- (NSDate *)date;
- (void)setDate:(NSDate *)date;

- (NSDate *)visibleStartDate;
- (NSDate *)visibleEndDate;

- (void)loadPreviousPage;
- (void)loadNextPage;

- (void)loadPreviousPageWithAnimation;
- (void)loadNextPageWithAnimation;

@end
