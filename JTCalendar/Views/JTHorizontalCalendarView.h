//
//  JTHorizontalCalendar.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

#import "JTContent.h"

@interface JTHorizontalCalendarView : UIScrollView<JTContent>

@property (nonatomic, weak) JTCalendarManager *manager;

@property (nonatomic) NSDate *date;

@property (nonatomic, assign, readonly) BOOL scrolling;

/*!
 * Must be call if override the class
 */
- (void)commonInit;

@end
