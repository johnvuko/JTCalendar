//
//  JTCalendarDayView.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

#import "JTCalendar.h"

@interface JTCalendarDayView : UIView

@property (weak, nonatomic) JTCalendar *calendarManager;

@property (strong, nonatomic) NSDate *date;
@property (assign, nonatomic) BOOL isOtherMonth;

- (void)reloadData;
- (void)reloadAppearance;

@end
