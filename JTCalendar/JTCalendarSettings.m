//
//  JTCalendarSettings.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTCalendarSettings.h"

@implementation JTCalendarSettings

- (instancetype)init
{
    self = [super init];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (void)commonInit
{
    _pageViewHideWhenPossible = NO;
    _pageViewNumberOfWeeks = 6;
    _pageViewHaveWeekDaysView = YES;
    _pageViewWeekDaysViewAutomaticHeight = NO;
    _weekDayFormat = JTCalendarWeekDayFormatShort;
    _zeroPaddedDayFormat = YES;
    _weekModeEnabled = NO;
    _pageViewWeekModeNumberOfWeeks = 1;
}

@end
