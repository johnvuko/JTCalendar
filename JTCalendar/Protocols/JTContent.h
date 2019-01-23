//
//  JTContent.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <Foundation/Foundation.h>

@class JTCalendarManager;

NS_ASSUME_NONNULL_BEGIN
@protocol JTContent <NSObject>

- (void)setManager:(JTCalendarManager *)manager;

- (NSDate *)date;
- (void)setDate:(NSDate *)date;

- (void)loadPreviousPage;
- (void)loadNextPage;

- (void)loadPreviousPageWithAnimation;
- (void)loadNextPageWithAnimation;

@end
NS_ASSUME_NONNULL_END