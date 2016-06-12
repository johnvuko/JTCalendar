//
//  JTHorizontalCalendar.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

#import "JTContent.h"

NS_ASSUME_NONNULL_BEGIN
@interface JTHorizontalCalendarView : UIScrollView<JTContent>

@property (nonatomic, weak, nullable) JTCalendarManager *manager;

@property (nonatomic) NSDate *date;

/*!
 * Must be call if override the class
 */
- (void)commonInit;

@end
NS_ASSUME_NONNULL_END
