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

// Month
@property (strong, nonatomic) UIColor *menuMonthTextColor;
@property (strong, nonatomic) UIFont *menuMonthTextFont;

@property (assign, nonatomic) CGFloat ratioContentMenu;
@property (assign, nonatomic) BOOL autoChangeMonth;
@property (nonatomic, copy) JTCalendarMonthBlock monthBlock;

// Weekday
@property (assign, nonatomic) JTCalendarWeekDayFormat weekDayFormat;
@property (strong, nonatomic) UIColor *weekDayTextColor;
@property (strong, nonatomic) UIFont *weekDayTextFont;

// Day
@property (strong, nonatomic) UIColor *dayCircleColorSelected;
@property (strong, nonatomic) UIColor *dayCircleColorSelectedOtherMonth;
@property (strong, nonatomic) UIColor *dayCircleColorToday;
@property (strong, nonatomic) UIColor *dayCircleColorTodayOtherMonth;

@property (strong, nonatomic) UIColor *dayDotColor;
@property (strong, nonatomic) UIColor *dayDotColorSelected;
@property (strong, nonatomic) UIColor *dayDotColorOtherMonth;
@property (strong, nonatomic) UIColor *dayDotColorSelectedOtherMonth;
@property (strong, nonatomic) UIColor *dayDotColorToday;
@property (strong, nonatomic) UIColor *dayDotColorTodayOtherMonth;

@property (strong, nonatomic) UIColor *dayTextColor;
@property (strong, nonatomic) UIColor *dayTextColorSelected;
@property (strong, nonatomic) UIColor *dayTextColorOtherMonth;
@property (strong, nonatomic) UIColor *dayTextColorSelectedOtherMonth;
@property (strong, nonatomic) UIColor *dayTextColorToday;
@property (strong, nonatomic) UIColor *dayTextColorTodayOtherMonth;

@property (strong, nonatomic) UIFont *dayTextFont;

@property (strong, nonatomic) NSString *dayFormat;

// Day Background and Border
@property (strong, nonatomic) UIColor *dayBackgroundColor;
@property (assign, nonatomic) CGFloat dayBorderWidth;
@property (assign, nonatomic) UIColor *dayBorderColor;

@property (assign, nonatomic) CGFloat dayCircleRatio;
@property (assign, nonatomic) CGFloat dayDotRatio;

- (NSCalendar *)calendar;

- (void)setDayDotColorForAll:(UIColor *)dotColor;
- (void)setDayTextColorForAll:(UIColor *)textColor;

@end
