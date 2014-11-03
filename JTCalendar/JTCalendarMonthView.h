//
//  JTCalendarMonthView.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

#import "JTCalendar.h"

@interface JTCalendarMonthView : UIView

@property (weak, nonatomic) JTCalendar *calendarManager;

- (void)setBeginningOfMonth:(NSDate *)date;
- (void)reloadData;
- (void)reloadAppearance;

@end
