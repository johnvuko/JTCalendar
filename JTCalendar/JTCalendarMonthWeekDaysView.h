//
//  JTCalendarMonthWeekDaysView.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

#import "JTCalendar.h"

@interface JTCalendarMonthWeekDaysView : UIView

@property (weak, nonatomic) JTCalendar *calendarManager;

+ (void)beforeReloadAppearance;
- (void)reloadAppearance;

@end
