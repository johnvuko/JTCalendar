//
//  JTVerticalCalendarView.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

#import "JTContent.h"

@interface JTVerticalCalendarView : UIScrollView<JTContent>

@property (nonatomic, weak) JTCalendarManager *manager;

@property (nonatomic) NSDate *date;
@property (nonatomic, readonly) NSDate *visibleStartDate;
@property (nonatomic, readonly) NSDate *visibleEndDate;

/*!
 * Must be call if override the class
 */
- (void)commonInit;

@end
