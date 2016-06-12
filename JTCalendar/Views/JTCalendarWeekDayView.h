//
//  JTCalendarWeekDayView.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

#import "JTCalendarWeekDay.h"

NS_ASSUME_NONNULL_BEGIN
@interface JTCalendarWeekDayView : UIView<JTCalendarWeekDay>

@property (nonatomic, weak, nullable) JTCalendarManager *manager;

@property (nonatomic, readonly) NSArray<UILabel *> *dayViews;

/*!
 * Must be call if override the class
 */
- (void)commonInit;

/*!
 * Rebuild the view, must be call if you change `weekDayFormat` or `firstWeekday`
 */
- (void)reload;

@end
NS_ASSUME_NONNULL_END
