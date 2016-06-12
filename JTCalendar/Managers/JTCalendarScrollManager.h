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
NS_ASSUME_NONNULL_BEGIN
@interface JTCalendarScrollManager : NSObject

@property (nonatomic, weak, nullable) JTCalendarManager *manager;

@property (nonatomic, weak, nullable) UIView<JTMenu> *menuView;
@property (nonatomic, weak, nullable) UIScrollView<JTContent> *horizontalContentView;

- (void)setMenuPreviousDate:(NSDate *)previousDate
                currentDate:(NSDate *)currentDate
                   nextDate:(NSDate *)nextDate;

- (void)updateMenuContentOffset:(CGFloat)percentage pageMode:(NSUInteger)pageMode;
- (void)updateHorizontalContentOffset:(CGFloat)percentage;

@end
NS_ASSUME_NONNULL_END