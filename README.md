# JTCalendar

[![CI Status](http://img.shields.io/travis/jonathantribouharet/JTCalendar.svg)](https://travis-ci.org/jonathantribouharet/JTCalendar)
![Version](https://img.shields.io/cocoapods/v/JTCalendar.svg)
![License](https://img.shields.io/cocoapods/l/JTCalendar.svg)
![Platform](https://img.shields.io/cocoapods/p/JTCalendar.svg)

JTCalendar is an easily customizable calendar control for iOS.

## Installation

With [CocoaPods](http://cocoapods.org), add this line to your Podfile.

    pod 'JTCalendar', '~> 1.1'

## Screenshots

![Example](./Screens/example.gif "Example View")
![Example](./Screens/example.png "Example View")

### Warning
The part below the calendar in the 2nd screenshot is not provided.

## Usage

### Basic usage

You have to create two views in your `UIViewController`:

- The first view is `JTCalendarMenuView` and it represents the month names.
- The second view is `JTCalendarContentView` and it represents the calendar itself.

Your `UIViewController` must implement `JTCalendarDataSource`

```objective-c
#import <UIKit/UIKit.h>

#import <JTCalendar.h>

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
    
    [self.calendar reloadData];
}

- (void)viewDidLayoutSubviews
{
    [self.calendar repositionViews];
}

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    return NO;
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    NSLog(@"%@", date);
}

@end

```

For more information about organizing the events by date, see the Example project.

### Switch to week view

If you want see just one week at a time, you have to set the `isWeekMode` to `YES` and reload the calendar.

```objective-c
self.calendar.calendarAppearance.isWeekMode = YES;
[self.calendar reloadAppearance];
```

#### WARNING

When you change the mode, it doesn't change the height of `calendarContentView`, you have to do it yourself.
See the Example project for more details.

### Customize the design

You have a lot of options available to customize the design.
Check the `JTCalendarAppearance.h` file to see all the options.

```objective-c
self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Monday
self.calendar.calendarAppearance.ratioContentMenu = 1.;
self.calendar.calendarAppearance.menuMonthTextColor = [UIColor whiteColor];
self.calendar.calendarAppearance.dayCircleColorSelected = [UIColor blueColor];
self.calendar.calendarAppearance.dayTextColorSelected = [UIColor whiteColor];
[self.calendar reloadAppearance];
```

#### Recommendation

The call to `reloadAppearance` is expensive. It is called by `setMenuMonthsView` and `setContentView`.

For a better performance, define the appearance just after the `JTCalendar` initialization.

**Bad** example:
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

**Good** example:
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

You may also want to open your calendar on a specific date. By default, it is `[NSDate date]`.
```objective-c
[self.calendar setCurrentDate:myDate];
```

### WARNING

The `currentDate` is used for indicate the month and the week visible. When you change the `currentDate`, the calendar moves to the correct week and month.

The `currentDateSelected` is the last date touched by an user. Currently, the only way (hack) to set the `currentDateSelected` is by calling
```objective-c
// Update views
[NSNotificationCenter defaultCenter] postNotificationName:@"kJTCalendarDaySelected" object:date];

// Store currentDateSelected
[self.calendar setCurrentDateSelected:date];
```

### Data cache

By default, a cache is activated, so you don't have to call `calendarHaveEvent` intensively. To clean the cache, you just have to call `reloadData`.

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
