//
//  ViewController.h
//  Example
//
//  Created by Jonathan Tribouharet.
//

#import <UIKit/UIKit.h>

#import "JTCalendar.h"

@interface ViewController : UIViewController<JTCalendarDataSource>

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTCalendarContentView *calendarContentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarContentViewHeight;

@property (strong, nonatomic) JTCalendar *calendar;

@end
