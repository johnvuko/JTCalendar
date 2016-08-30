//
//  CustomViewController.h
//  Example
//
//  Created by Jonathan Tribouharet.
//

#import <UIKit/UIKit.h>

#import <JTCalendar/JTCalendarMenuView.h>
#import <JTCalendar/JTCalendarDelegate.h>
#import <JTCalendar/JTHorizontalCalendarView.h>

@interface CustomViewController : UIViewController<JTCalendarDelegate>

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@end
