//
//  JTCalendarMenuMonthView.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

#import "JTCalendar.h"

@interface JTCalendarMenuMonthView : UIView

@property (weak, nonatomic) JTCalendar *calendarManager;

- (void)setMonthIndex:(NSInteger)monthIndex;
- (void)setCurrentDate:(NSDate *)currentDate;

- (void)reloadAppearance;

@end
