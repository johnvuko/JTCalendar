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

NS_ASSUME_NONNULL_BEGIN
@interface JTCalendarManager : NSObject

@property (nonatomic, weak, nullable) id<JTCalendarDelegate> delegate;

@property (nonatomic, weak, nullable) UIView<JTMenu> *menuView;
@property (nonatomic, weak, nullable) UIScrollView<JTContent> *contentView;

@property (nonatomic, readonly) JTDateHelper *dateHelper;
@property (nonatomic, readonly) JTCalendarSettings *settings;

// Intern methods

@property (nonatomic, readonly) JTCalendarDelegateManager *delegateManager;
@property (nonatomic, readonly) JTCalendarScrollManager *scrollManager;

- (instancetype)initWithLocale:(NSLocale *)locale andTimeZone:(NSTimeZone *)timeZone;

- (NSDate *)date;
- (void)setDate:(NSDate *)date;
- (void)reload;


@end
NS_ASSUME_NONNULL_END
