//
//  JTCalendarWeekDayView.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTCalendarWeekDayView.h"

#import "JTCalendarManager.h"

#define NUMBER_OF_DAY_BY_WEEK 7.

@implementation JTCalendarWeekDayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (void)commonInit
{
    NSMutableArray *dayViews = [NSMutableArray new];
    
    for(int i = 0; i < NUMBER_OF_DAY_BY_WEEK; ++i){
        UILabel *label = [UILabel new];
        [self addSubview:label];
        [dayViews addObject:label];
        
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithRed:152./256. green:147./256. blue:157./256. alpha:1.];
        label.font = [UIFont systemFontOfSize:11];
    }
    
    _dayViews = dayViews;
}

- (void)reload
{
    NSAssert(_manager != nil, @"manager cannot be nil");
    
    NSDateFormatter *dateFormatter = [_manager.dateHelper createDateFormatter];
    NSMutableArray *days = nil;
    
    dateFormatter.timeZone = _manager.dateHelper.calendar.timeZone;
    dateFormatter.locale = _manager.dateHelper.calendar.locale;
    
    switch(_manager.settings.weekDayFormat) {
        case JTCalendarWeekDayFormatSingle:
            days = [[dateFormatter veryShortStandaloneWeekdaySymbols] mutableCopy];
            break;
        case JTCalendarWeekDayFormatShort:
            days = [[dateFormatter shortStandaloneWeekdaySymbols] mutableCopy];
            break;
        case JTCalendarWeekDayFormatFull:
            days = [[dateFormatter standaloneWeekdaySymbols] mutableCopy];
            break;
    }
    
    for(NSInteger i = 0; i < days.count; ++i){
        NSString *day = days[i];
        [days replaceObjectAtIndex:i withObject:[day uppercaseString]];
    }
    
    // Redorder days for be conform to calendar
    {
        NSCalendar *calendar = [_manager.dateHelper calendar];
        NSUInteger firstWeekday = (calendar.firstWeekday + 6) % 7; // Sunday == 1, Saturday == 7
        
        for(int i = 0; i < firstWeekday; ++i){
            id day = [days firstObject];
            [days removeObjectAtIndex:0];
            [days addObject:day];
        }
    }
    
    for(int i = 0; i < NUMBER_OF_DAY_BY_WEEK; ++i){
        UILabel *label =  _dayViews[i];
        label.text = days[i];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if(!_dayViews){
        return;
    }
    
    CGFloat x = 0;
    CGFloat dayWidth = self.frame.size.width / NUMBER_OF_DAY_BY_WEEK;
    CGFloat dayHeight = self.frame.size.height;
    
    for(UIView *dayView in _dayViews){
        dayView.frame = CGRectMake(x, 0, dayWidth, dayHeight);
        x += dayWidth;
    }
}

@end
