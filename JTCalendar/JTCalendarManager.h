//
//  JTCalendarManager.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

#import "JTCalendarDelegate.h"

#import "JTContent.h"
#import "JTMenu.h"

#import "JTDateHelper.h"
#import "JTCalendarSettings.h"

#import "JTCalendarDelegateManager.h"
#import "JTCalendarScrollManager.h"

@interface JTCalendarManager : NSObject

@property (nonatomic, weak) id<JTCalendarDelegate> delegate;

@property (nonatomic, weak) UIView<JTMenu> *menuView;
@property (nonatomic, weak) UIScrollView<JTContent> *contentView;

@property (nonatomic, readonly) JTDateHelper *dateHelper;
@property (nonatomic, readonly) JTCalendarSettings *settings;

// Intern methods

@property (nonatomic, readonly) JTCalendarDelegateManager *delegateManager;
@property (nonatomic, readonly) JTCalendarScrollManager *scrollManager;

// Use for override
- (void)commonInit;

- (NSDate *)date;
- (void)setDate:(NSDate *)date;
- (void)reload;


@end
