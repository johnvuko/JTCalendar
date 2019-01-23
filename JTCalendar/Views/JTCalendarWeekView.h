//
//  JTCalendarWeekView.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

#import "JTCalendarWeek.h"

NS_ASSUME_NONNULL_BEGIN
@interface JTCalendarWeekView : UIView<JTCalendarWeek>

@property (nonatomic, weak, nullable) JTCalendarManager *manager;

@property (nonatomic, readonly) NSDate *startDate;

/*!
 * Must be call if override the class
 */
- (void)commonInit;

@end
NS_ASSUME_NONNULL_END