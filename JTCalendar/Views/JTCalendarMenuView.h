//
//  JTCalendarMenuView.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

#import "JTMenu.h"

@interface JTCalendarMenuView : UIView<JTMenu, UIScrollViewDelegate>

@property (nonatomic, weak) JTCalendarManager *manager;

@property (nonatomic) CGFloat contentRatio;

@property (nonatomic, readonly) UIScrollView *scrollView;

/*!
 * Must be call if override the class
 */
- (void)commonInit;

@end
