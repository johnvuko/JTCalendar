//
//  JTCalendarSettings.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JTCalendarWeekDayFormat) {
    JTCalendarWeekDayFormatSingle,
    JTCalendarWeekDayFormatShort,
    JTCalendarWeekDayFormatFull
};

NS_ASSUME_NONNULL_BEGIN
@interface JTCalendarSettings : NSObject


// Content view

@property (nonatomic) BOOL pageViewHideWhenPossible;
@property (nonatomic) BOOL weekModeEnabled;


// Page view

// Must be less or equalt to 6, 0 for automatic
@property (nonatomic) NSUInteger pageViewNumberOfWeeks;
@property (nonatomic) BOOL pageViewHaveWeekDaysView;
@property (nonatomic) NSUInteger pageViewWeekModeNumberOfWeeks;

// WeekDay view

@property (nonatomic) JTCalendarWeekDayFormat weekDayFormat;


// Use for override
- (void)commonInit;

@end
NS_ASSUME_NONNULL_END