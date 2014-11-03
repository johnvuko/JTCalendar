//
//  JTCalendarMonthWeekDaysView.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTCalendarMonthWeekDaysView.h"

@implementation JTCalendarMonthWeekDaysView

static NSArray *cacheDaysOfWeeks;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
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
    for(NSString *day in [self daysOfWeek]){
        UILabel *view = [UILabel new];
        
        view.font = self.calendarManager.calendarAppearance.weekDayTextFont;
        view.textColor = self.calendarManager.calendarAppearance.weekDayTextColor;
        
        view.textAlignment = NSTextAlignmentCenter;
        view.text = day;
        
        [self addSubview:view];
    }
    
    [self configureConstraintsForSubviews];
}

- (NSArray *)daysOfWeek
{
    if(cacheDaysOfWeeks){
        return cacheDaysOfWeeks;
    }
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    NSMutableArray *days = [[dateFormatter standaloneWeekdaySymbols] mutableCopy];
        
    // Redorder days for be conform to calendar
    {
        NSCalendar *calendar = self.calendarManager.calendarAppearance.calendar;
        NSUInteger firstWeekday = (calendar.firstWeekday + 6) % 7; // Sunday == 1, Saturday == 7
                
        for(int i = 0; i < firstWeekday; ++i){
            id day = [days firstObject];
            [days removeObjectAtIndex:0];
            [days addObject:day];
        }
    }
    
    switch(self.calendarManager.calendarAppearance.weekDayFormat){
        case JTCalendarWeekDayFormatSingle:
            for(NSInteger i = 0; i < days.count; ++i){
                NSString *day = days[i];
                [days replaceObjectAtIndex:i withObject:[[day uppercaseString] substringToIndex:1]];
            }
            break;
        case JTCalendarWeekDayFormatShort:
            for(NSInteger i = 0; i < days.count; ++i){
                NSString *day = days[i];
                [days replaceObjectAtIndex:i withObject:[[day uppercaseString] substringToIndex:3]];
            }
            break;
        case JTCalendarWeekDayFormatFull:
            for(NSInteger i = 0; i < days.count; ++i){
                NSString *day = days[i];
                [days replaceObjectAtIndex:i withObject:[day uppercaseString]];
            }
            break;
    }
    
    cacheDaysOfWeeks = days;
    return cacheDaysOfWeeks;
}

- (void)configureConstraintsForSubviews
{
    for(UIView *view in self.subviews){
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
        }];
    }
    
    {
        UIView *view = self.subviews.firstObject;
        
        [view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
        }];
    }
    
    {
        UIView *view = self.subviews.lastObject;
        
        [view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right);
        }];
    }
    
    for(int i = 0; i < self.subviews.count - 1; ++i){
        UIView *view = self.subviews[i];
        UIView *viewNext = self.subviews[i + 1];
        
        [viewNext mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_right);
            make.width.equalTo(view.mas_width);
        }];
    }
}

+ (void)beforeReloadAppearance
{
    cacheDaysOfWeeks = nil;
}

- (void)reloadAppearance
{
    for(int i = 0; i < self.subviews.count; ++i){
        UILabel *view = [self.subviews objectAtIndex:i];
        
        view.font = self.calendarManager.calendarAppearance.weekDayTextFont;
        view.textColor = self.calendarManager.calendarAppearance.weekDayTextColor;
        
        view.text = [[self daysOfWeek] objectAtIndex:i];
    }
}

@end
