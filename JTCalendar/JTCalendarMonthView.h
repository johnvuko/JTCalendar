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
@property (nonatomic) NSInteger weeksToDisplay;

- (BOOL)selectDate:(NSDate *)date;
- (void)setBeginningOfMonth:(NSDate *)date;
- (void)reloadData;
- (void)reloadAppearance;

@end
