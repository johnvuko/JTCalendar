# JTCalendar

[![CI Status](http://img.shields.io/travis/jonathantribouharet/JTCalendar.svg)](https://travis-ci.org/jonathantribouharet/JTCalendar)
![Version](https://img.shields.io/cocoapods/v/JTCalendar.svg)
![License](https://img.shields.io/cocoapods/l/JTCalendar.svg)
![Platform](https://img.shields.io/cocoapods/p/JTCalendar.svg)

JTCalendar is a calendar control for iOS easily customizable.

## Installation

With [CocoaPods](http://cocoapods.org/), add this line to your Podfile.

    pod 'JTCalendar', '~> 1.1'

## Screenshots

![Example](./Screens/example.gif "Example View")
![Example](./Screens/example.png "Example View")

## Usage

### Basic usage

You have to create two views in your UIViewController.

The first view is `JTCalendarMenuView`, it represents the months.

The second view is `JTCalendarContentView`, the calendar itself.

Your UIViewController must implement `JTCalendarDataSource`

```objective-c
#import <UIKit/UIKit.h>

#import "JTCalendar.h"

@interface ViewController : UIViewController<JTCalendarDataSource>

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTCalendarContentView *calendarContentView;

@property (strong, nonatomic) JTCalendar *calendar;

@end
```

`JTCalendar` is used to coordinate `calendarMenuView` and `calendarContentView`.

```objective-c
@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    self.calendar = [JTCalendar new];
    
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.calendar reloadData]; // Must be call in viewDidAppear
}

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    return NO;
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    NSLog(@"%@", date);
}

// Manage rotation
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.calendar repositionViews];
}

@end

```

For more informations about how organize events by date see the Example project.

### Switch to week view

If you want see just one week at time you can switch when you want between the weekMode.

```objective-c
self.calendar.calendarAppearance.isWeekMode = YES;
[self.calendar reloadAppearance];
```

#### WARNING

When you change the mode, it doesn't change the height of `calendarContentView`, you have to do it yourself.
See the project in example for more details.

### Customize the design

You have a lot of options available for personnalize the design.
Check the `JTCalendarAppearance.h` file for see all options.

```objective-c
self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Monday
self.calendar.calendarAppearance.ratioContentMenu = 1.;
self.calendar.calendarAppearance.menuMonthTextColor = [UIColor whiteColor];
self.calendar.calendarAppearance.dayCircleColorSelected = [UIColor blueColor];
self.calendar.calendarAppearance.dayTextColorSelected = [UIColor whiteColor];
[self.calendar reloadAppearance];
```

#### Recommendation

The call to `reloadAppearance` is expensive, `reloadAppearance` is call by `setMenuMonthsView` and `setContentView`.

For better performance define the appearance just after instanciate `JTCalendar`.

BAD example:
```objective-c
self.calendar = [JTCalendar new];
    
[self.calendar setMenuMonthsView:self.calendarMenuView];
[self.calendar setContentView:self.calendarContentView];
[self.calendar setDataSource:self];

self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Monday
self.calendar.calendarAppearance.ratioContentMenu = 1.;
self.calendar.calendarAppearance.menuMonthTextColor = [UIColor whiteColor];
self.calendar.calendarAppearance.dayCircleColorSelected = [UIColor blueColor];
self.calendar.calendarAppearance.dayTextColorSelected = [UIColor whiteColor];

[self.calendar reloadAppearance]; // You have to call reloadAppearance
```

GOOD example:
```objective-c
self.calendar = [JTCalendar new];

self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Monday
self.calendar.calendarAppearance.ratioContentMenu = 1.;
self.calendar.calendarAppearance.menuMonthTextColor = [UIColor whiteColor];
self.calendar.calendarAppearance.dayCircleColorSelected = [UIColor blueColor];
self.calendar.calendarAppearance.dayTextColorSelected = [UIColor whiteColor];

[self.calendar setMenuMonthsView:self.calendarMenuView];
[self.calendar setContentView:self.calendarContentView];
[self.calendar setDataSource:self];

// You don't have to call reloadAppearance
```

You may also want to open your calendar on a specific date, by defaut it's `[NSDate date].`
```objective-c
[self.calendar setCurrentDate:myDate];
```

### WARNING

The `currentDate` is used for indicate the month and the week visible. When you change the `currentDate` the calendar move to the correct week and month.

The `currentDateSelected` is the last date touched by an user. Currently the only way to set the `currentDateSelected` is by calling
```objective-c
[NSNotificationCenter defaultCenter] postNotificationName:@"kJTCalendarDaySelected" object:date];
```

### Data cache

By default a cache is activated for don't have to call `calendarHaveEvent` intensively. For clean the cache you just have to call `reloadData`.

If you don't want to use this cache you can disable it with:
```objective-c
self.calendar.calendarAppearance.useCacheSystem = NO;
```

## Requirements

- iOS 7 or higher
- Automatic Reference Counting (ARC)

## Author

- [Jonathan Tribouharet](https://github.com/jonathantribouharet) ([@johntribouharet](https://twitter.com/johntribouharet))

## License

JTCalendar is released under the MIT license. See the LICENSE file for more info.
