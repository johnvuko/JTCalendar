//
//  JTCalendar.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

#import "JTCalendarViewDataSource.h"
#import "JTCalendarAppearance.h"

#import "JTCalendarMenuView.h"
#import "JTCalendarContentView.h"

#import "JTCalendarDataCache.h"

@interface JTCalendar : NSObject<UIScrollViewDelegate>

@property (weak, nonatomic) JTCalendarMenuView *menuMonthsView;
@property (weak, nonatomic) JTCalendarContentView *contentView;

@property (weak, nonatomic) id<JTCalendarDataSource> dataSource;
@property (weak, nonatomic) id<JTCalendarDateRangeDelegate> dateRangeDelegate;

@property (strong, nonatomic) NSDate *currentDate;
@property (strong, nonatomic) NSDate *currentDateSelected;

@property (strong, nonatomic) NSDate *startDateInRange;
@property (strong, nonatomic) NSDate *endDateInRange;

@property (strong, nonatomic, readonly) JTCalendarDataCache *dataCache;
@property (strong, nonatomic, readonly) JTCalendarAppearance *calendarAppearance;

- (void)reloadData;
- (void)reloadAppearance;

- (void)loadPreviousMonth DEPRECATED_MSG_ATTRIBUTE("Use loadPreviousPage instead");
- (void)loadNextMonth DEPRECATED_MSG_ATTRIBUTE("Use loadNextPage instead");

- (void)loadPreviousPage;
- (void)loadNextPage;

- (void)repositionViews;

- (JTCalendarDateRange)dateBelongsToSelectedRange:(NSDate *)date;
- (BOOL)calendarIsUsingRangeOfDates;
@end
