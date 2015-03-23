//
//  JTCalendarAppearance.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

@class JTCalendar;

@interface JTCalendarAppearance : NSObject

typedef NS_ENUM(NSInteger, JTCalendarWeekDayFormat) {
    JTCalendarWeekDayFormatSingle,
    JTCalendarWeekDayFormatShort,
    JTCalendarWeekDayFormatFull
};

typedef NSString *(^JTCalendarMonthBlock)(NSDate *date, JTCalendar *jt_calendar);

@property (assign, nonatomic) BOOL isWeekMode;
@property (assign, nonatomic) BOOL useCacheSystem;
@property (assign, nonatomic) BOOL focusSelectedDayChangeMode;
@property (assign, nonatomic) BOOL readFromRightToLeft; // For language read from right to left

// Month
@property (nonatomic) UIColor *menuMonthTextColor;
@property (nonatomic) UIFont *menuMonthTextFont;

@property (assign, nonatomic) CGFloat ratioContentMenu;
@property (assign, nonatomic) BOOL autoChangeMonth;
@property (copy, nonatomic) JTCalendarMonthBlock monthBlock;

// Weekday
@property (assign, nonatomic) JTCalendarWeekDayFormat weekDayFormat;
@property (nonatomic) UIColor *weekDayTextColor;
@property (nonatomic) UIFont *weekDayTextFont;

// Day
@property (nonatomic) UIColor *dayCircleColorSelected;
@property (nonatomic) UIColor *dayCircleColorSelectedOtherMonth;
@property (nonatomic) UIColor *dayCircleColorToday;
@property (nonatomic) UIColor *dayCircleColorTodayOtherMonth;

@property (nonatomic) UIColor *dayDotColor;
@property (nonatomic) UIColor *dayDotColorSelected;
@property (nonatomic) UIColor *dayDotColorOtherMonth;
@property (nonatomic) UIColor *dayDotColorSelectedOtherMonth;
@property (nonatomic) UIColor *dayDotColorToday;
@property (nonatomic) UIColor *dayDotColorTodayOtherMonth;

@property (nonatomic) UIColor *dayTextColor;
@property (nonatomic) UIColor *dayTextColorSelected;
@property (nonatomic) UIColor *dayTextColorOtherMonth;
@property (nonatomic) UIColor *dayTextColorSelectedOtherMonth;
@property (nonatomic) UIColor *dayTextColorToday;
@property (nonatomic) UIColor *dayTextColorTodayOtherMonth;

@property (nonatomic) UIFont *dayTextFont;

@property (nonatomic) NSString *dayFormat;

// Day Background and Border
@property (nonatomic) UIColor *dayBackgroundColor;
@property (assign, nonatomic) CGFloat dayBorderWidth;
@property (nonatomic) UIColor *dayBorderColor;

@property (assign, nonatomic) CGFloat dayCircleRatio;
@property (assign, nonatomic) CGFloat dayDotRatio;

- (NSCalendar *)calendar;

- (void)setDayDotColorForAll:(UIColor *)dotColor;
- (void)setDayTextColorForAll:(UIColor *)textColor;

@end
