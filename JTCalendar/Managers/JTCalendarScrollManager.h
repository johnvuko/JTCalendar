//
//  JTCalendarScrollManager.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <Foundation/Foundation.h>

#import "JTCalendarDelegate.h"

#import "JTMenu.h"
#import "JTContent.h"

// Synchronize JTHorizontalCalendarView and JTCalendarMenuView

@interface JTCalendarScrollManager : NSObject

@property (nonatomic, weak) JTCalendarManager *manager;

@property (nonatomic, weak) UIView<JTMenu> *menuView;
@property (nonatomic, weak) UIScrollView<JTContent> *horizontalContentView;

- (void)setMenuPreviousDate:(NSDate *)previousDate
                currentDate:(NSDate *)currentDate
                   nextDate:(NSDate *)nextDate;

- (void)updateMenuContentOffset:(CGFloat)percentage pageMode:(NSUInteger)pageMode;
- (void)updateHorizontalContentOffset:(CGFloat)percentage;

@end
