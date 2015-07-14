//
//  JTCalendarWeekDayView.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

#import "JTCalendarWeekDay.h"

@interface JTCalendarWeekDayView : UIView<JTCalendarWeekDay>

@property (nonatomic, weak) JTCalendarManager *manager;

@property (nonatomic, readonly) NSArray *dayViews;

/*!
 * Must be call if override the class
 */
- (void)commonInit;

/*!
 * Rebuild the view, must be call if you change `weekDayFormat` or `firstWeekday`
 */
- (void)reload;

@end
