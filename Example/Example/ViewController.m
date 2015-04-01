//
//  ViewController.m
//  Example
//
//  Created by Jonathan Tribouharet.
//

#import "ViewController.h"

@interface ViewController (){
    NSMutableDictionary *eventsByDate;
    __weak IBOutlet UIButton *rangeStartDate;
    __weak IBOutlet UIButton *rangeEndDate;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.calendar = [JTCalendar new];
    
    // All modifications on calendarAppearance have to be done before setMenuMonthsView and setContentView
    // Or you will have to call reloadAppearance
    {
        self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
        self.calendar.calendarAppearance.dayCircleRatio = 9. / 10.;
        self.calendar.calendarAppearance.ratioContentMenu = 2.;
        self.calendar.calendarAppearance.focusSelectedDayChangeMode = YES;
        // Customize the text for each month
        self.calendar.calendarAppearance.monthBlock = ^NSString *(NSDate *date, JTCalendar *jt_calendar){
            NSCalendar *calendar = jt_calendar.calendarAppearance.calendar;
            NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:date];
            NSInteger currentMonthIndex = comps.month;
            
            static NSDateFormatter *dateFormatter;
            if(!dateFormatter){
                dateFormatter = [NSDateFormatter new];
                dateFormatter.timeZone = jt_calendar.calendarAppearance.calendar.timeZone;
            }
            
            while(currentMonthIndex <= 0){
                currentMonthIndex += 12;
            }
            
            NSString *monthText = [[dateFormatter standaloneMonthSymbols][currentMonthIndex - 1] capitalizedString];
            
            return [NSString stringWithFormat:@"%ld\n%@", comps.year, monthText];
        };
    }
    
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
    [self.calendar setDateRangeDelegate:self];
    
    [self createRandomEvents];
    
    [self.calendar reloadData];
}

- (void)viewDidLayoutSubviews
{
    [self.calendar repositionViews];
}

#pragma mark - Buttons callback

- (IBAction)didGoTodayTouch
{
    [self.calendar setCurrentDate:[NSDate date]];
}

- (IBAction)didChangeModeTouch
{
    self.calendar.calendarAppearance.isWeekMode = !self.calendar.calendarAppearance.isWeekMode;
    
    [self transitionExample];
}

- (IBAction)pickRangeStartDate:(id)sender {
    [rangeStartDate setSelected:!rangeStartDate.selected];
    [rangeEndDate setSelected:NO];
    [self resetRangeIfNeeded];
}

- (IBAction)pickRangeEndDate:(id)sender {
    [rangeEndDate setSelected:!rangeEndDate.selected];
    [rangeStartDate setSelected:NO];
    [self resetRangeIfNeeded];
}

- (void)resetRangeIfNeeded {
    if (!rangeStartDate.selected && !rangeEndDate.selected) {
        [self.calendar setStartDateInRange:nil];
        [self.calendar setEndDateInRange:nil];
    }
}
#pragma mark - JTCalendarDataSource

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    if(eventsByDate[key] && [eventsByDate[key] count] > 0){
        return YES;
    }
    
    return NO;
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    NSArray *events = eventsByDate[key];
    
    NSLog(@"Date: %@ - %ld events", date, [events count]);
    
    if (rangeStartDate.selected) {
        [self.calendar setStartDateInRange:date];
    } else if (rangeEndDate.selected) {
        [self.calendar setEndDateInRange:date];
    }
}

- (void)calendarDidLoadPreviousPage
{
    NSLog(@"Previous page loaded");
}

- (void)calendarDidLoadNextPage
{
    NSLog(@"Next page loaded");
}

#pragma mark - JTCalendarDateRangeDelegate
- (void)styleDayBackgroundView:(UIView *)backgroundView forDate:(NSDate *)date inRange:(JTCalendarDateRange)dateRange {
    [backgroundView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [backgroundView.layer setBorderWidth:0.5f];
    UIColor *colorForDatesInRange = [UIColor colorWithRed:251.f/255.f green:77.f/255.f blue:0.f/255.f alpha:0.3f];
    switch (dateRange) {
        case JTCalendarDateRangeBeginDate:
            [backgroundView setBackgroundColor:colorForDatesInRange];
            break;
        case JTCalendarDateRangeMiddleDate:
            [backgroundView setBackgroundColor:colorForDatesInRange];
            break;
        case JTCalendarDateRangeEndDate:
            [backgroundView setBackgroundColor:colorForDatesInRange];
            break;
        case JTCalendarDateAfterRange:
            [backgroundView setBackgroundColor:[UIColor clearColor]];
            break;
        case JTCalendarDateBeforeRange:
            [backgroundView setBackgroundColor:[UIColor lightGrayColor]];
            break;
        case JTCalendarDateNoRangeSelected:
            [backgroundView setBackgroundColor:[UIColor clearColor]];
            break;
        default:
            break;
    }
}

#pragma mark - Transition examples

- (void)transitionExample
{
    CGFloat newHeight = 300;
    if(self.calendar.calendarAppearance.isWeekMode){
        newHeight = 75.;
    }
    
    [UIView animateWithDuration:.5
                     animations:^{
                         self.calendarContentViewHeight.constant = newHeight;
                         [self.view layoutIfNeeded];
                     }];
    
    [UIView animateWithDuration:.25
                     animations:^{
                         self.calendarContentView.layer.opacity = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.calendar reloadAppearance];
                         
                         [UIView animateWithDuration:.25
                                          animations:^{
                                              self.calendarContentView.layer.opacity = 1;
                                          }];
                     }];
}

#pragma mark - Fake data

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    
    return dateFormatter;
}

- (void)createRandomEvents
{
    eventsByDate = [NSMutableDictionary new];
    
    for(int i = 0; i < 30; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
        
        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
        
        if(!eventsByDate[key]){
            eventsByDate[key] = [NSMutableArray new];
        }
             
        [eventsByDate[key] addObject:randomDate];
    }
}

@end
