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

@interface JTCalendar : NSObject<UIScrollViewDelegate>

@property (weak, nonatomic) JTCalendarMenuView *menuMonthsView;
@property (weak, nonatomic) JTCalendarContentView *contentView;

@property (weak, nonatomic) id<JTCalendarDataSource> dataSource;

@property (strong, nonatomic) NSDate *currentDate;
@property (strong, nonatomic) NSDate *currentDateSelected;

- (JTCalendarAppearance *)calendarAppearance;

- (void)reloadData;
- (void)reloadAppearance;

- (void)loadPreviousMonth;
- (void)loadNextMonth;

@end
