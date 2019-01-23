//
//  JTCalendarMenuView.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

#import "JTMenu.h"

NS_ASSUME_NONNULL_BEGIN
@interface JTCalendarMenuView : UIView<JTMenu, UIScrollViewDelegate>

@property (nonatomic, weak, nullable) JTCalendarManager *manager;

@property (nonatomic) CGFloat contentRatio;

@property (nonatomic, readonly) UIScrollView *scrollView;

/*!
 * Must be call if override the class
 */
- (void)commonInit;

@end
NS_ASSUME_NONNULL_END