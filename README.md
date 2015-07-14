# JTCalendar

[![CI Status](http://img.shields.io/travis/jonathantribouharet/JTCalendar.svg)](https://travis-ci.org/jonathantribouharet/JTCalendar)
![Version](https://img.shields.io/cocoapods/v/JTCalendar.svg)
![License](https://img.shields.io/cocoapods/l/JTCalendar.svg)
![Platform](https://img.shields.io/cocoapods/p/JTCalendar.svg)

JTCalendar is an easily customizable calendar control for iOS.

## Installation

With [CocoaPods](http://cocoapods.org), add this line to your Podfile.

    pod 'JTCalendar', '~> 2.0'

## Screenshots

![Example](./Screens/example.gif "Example View")
![Example](./Screens/example.png "Example View")

### Warning
The part below the calendar in the 2nd screenshot is not provided.

## Features

- horizontal and verical calendar
- highly customizable either by subclassing default class provided or by creating your own class implementing a protocol
- support Internationalization
- week view mode
- limited range, you can define a start and an end to you calendar

## Usage

### Basic usage

You have to create two views in your `UIViewController`:

- The first view is `JTCalendarMenuView` and it represents the part with the months names. This view is optional.
- The second view is `JTHorizontalCalendarView` or `JTVerticalCalendarView`, it represents the calendar itself.

Your `UIViewController` have to implement `JTCalendarDelegate`, all methods are optional.

```objective-c
#import <UIKit/UIKit.h>

#import <JTCalendar/JTCalendar.h>

@interface ViewController : UIViewController<JTCalendarDelegate>

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@end
```

`JTCalendarManager` is used to coordinate `calendarMenuView` and `calendarContentView` and provide a default behavior.

```objective-c
@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    
    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:[NSDate date]];
}

@end

```

The Example project contains some use cases you may check before asking questions.

### Advanced usage

Even if all methods of `JTCalendarManager` are optional you won't get far without implementing at least the two next methods:
- `calendar:prepareDayView:` this method is used to customize the design of the day view for a specific date.

```objective-c
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    dayView.hidden = NO;
    
    // Other month
    if([dayView isFromAnotherMonth]){
        dayView.hidden = YES;
    }
    // Today
    else if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor blueColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected date
    else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor redColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
    if([self haveEventForDay:dayView.date]){
        dayView.dotView.hidden = NO;
    }
    else{
        dayView.dotView.hidden = YES;
    }
}
```

- `calendar:didTouchDayView:` this method is used to respond to a touch on a dayView. For exemple you can indicate to display another month if dayView is from another month.

```objective-c
- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    _dateSelected = dayView.date;
    
    // Load the previous or next page if touch a day from another month
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
}
```

### Switch to week view

If you want see just one week at a time, you have to set the `isWeekMode` to `YES` and reload the calendar.

```objective-c
_calendarManager.settings.weekModeEnalbed = = YES;
[_calendarManager reload];
```

#### WARNING

When you change the mode, it doesn't change the height of `calendarContentView`, you have to do it yourself.
See the Example project for more details.

### Customize the design

For customize the design you have to implement some methods depending of what parts you want to custom. Check the [JTCalendarDelegate](JTCalendar/JTCalendarDelegate.h) file and the Example project.

For example:

```objective-c
- (UIView<JTCalendarDay> *)calendarBuildDayView:(JTCalendarManager *)calendar
{
    JTCalendarDayView *view = [JTCalendarDayView new];
    view.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:13];
    view.textLabel.textColor = [UIColor blackColor];
    
    return view;
}
```

### Vertical calendar

If you use `JTVerticalCalendarView` for having a vertical calendar, you have some settings you have to set.

```objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    
    _calendarManager.settings.pageViewHaveWeekDaysView = NO; // You don't want WeekDaysView in the contentView
    _calendarManager.settings.pageViewNumberOfWeeks = 0; // Automatic number of weeks
    
    _weekDayView.manager = _calendarManager; // You set the manager for WeekDaysView
    [_weekDayView reload]; // You load WeekDaysView

    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:[NSDate date]];
    
    _calendarMenuView.scrollView.scrollEnabled = NO; // The scroll is not supported with JTVerticalCalendarView
}
```

## Requirements

- iOS 7 or higher
- Automatic Reference Counting (ARC)

## Author

- [Jonathan Tribouharet](https://github.com/jonathantribouharet) ([@johntribouharet](https://twitter.com/johntribouharet))

## License

JTCalendar is released under the MIT license. See the LICENSE file for more info.
