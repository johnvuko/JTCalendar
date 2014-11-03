//
//  JTCalendarMonthView.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTCalendarMonthView.h"

#import "JTCalendarMonthWeekDaysView.h"
#import "JTCalendarWeekView.h"

@interface JTCalendarMonthView (){
    JTCalendarMonthWeekDaysView *weekdaysView;
    NSArray *weeksViews;
    
    NSUInteger currentMonthIndex;
    BOOL cacheLastWeekMode; // Avoid some operations
};

@end

@implementation JTCalendarMonthView

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
    NSMutableArray *views = [NSMutableArray new];
    
    {
        weekdaysView = [JTCalendarMonthWeekDaysView new];
        [self addSubview:weekdaysView];
    }
    
    for(int i = 0; i < 6; ++i){ // 6 weeks to display
        UIView *view = [JTCalendarWeekView new];
        
        [views addObject:view];
        [self addSubview:view];
    }
    
    weeksViews = views;
    
    cacheLastWeekMode = self.calendarManager.calendarAppearance.isWeekMode;
}

- (void)layoutSubviews
{
    [self configureConstraintsForSubviews];
    
    [super layoutSubviews];
}

- (void)configureConstraintsForSubviews
{
    for(UIView *view in self.subviews){
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
        }];
    }

    {
        UIView *view = self.subviews.firstObject;
        
        [view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
        }];
    }

    {
        UIView *view = self.subviews.lastObject;
        
        [view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom);
        }];
    }

    for(int i = 0; i < self.subviews.count - 1; ++i){
        UIView *view = self.subviews[i];
        UIView *viewNext = self.subviews[i + 1];
        
        if(cacheLastWeekMode){ // Avoid some visual bug with animations
            if(i == 0){
                [viewNext mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(view.mas_bottom);
                    make.height.equalTo(view.mas_height);
                }];
            }
            else{
                [viewNext mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(view.mas_bottom);
                    make.height.equalTo(@0);
                }];
            }
        }
        else{
            [viewNext mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(view.mas_bottom);
                make.height.equalTo(view.mas_height);
            }];
        }
    }
}

- (void)setBeginningOfMonth:(NSDate *)date
{
    NSDate *currentDate = date;
    
    NSCalendar *calendar = self.calendarManager.calendarAppearance.calendar;
    
    {
        NSDateComponents *comps = [calendar components:NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
                
        currentMonthIndex = comps.month;
        
        // Hack
        if(comps.day > 7){
            currentMonthIndex = (currentMonthIndex % 12) + 1;
        }
    }
        
    for(JTCalendarWeekView *view in weeksViews){
        view.currentMonthIndex = currentMonthIndex;
        [view setBeginningOfWeek:currentDate];
                
        NSDateComponents *dayComponent = [NSDateComponents new];
        dayComponent.day = 7;
        
        currentDate = [calendar dateByAddingComponents:dayComponent toDate:currentDate options:0];
        
        // Doesn't need to do other weeks
        if(self.calendarManager.calendarAppearance.isWeekMode){
            break;
        }
    }
}

#pragma mark - JTCalendarManager

- (void)setCalendarManager:(JTCalendar *)calendarManager
{
    self->_calendarManager = calendarManager;
    
    [weekdaysView setCalendarManager:calendarManager];
    for(JTCalendarWeekView *view in weeksViews){
        [view setCalendarManager:calendarManager];
    }
}

- (void)reloadData
{
    for(JTCalendarWeekView *view in weeksViews){
        [view reloadData];
        
        // Doesn't need to do other weeks
        if(self.calendarManager.calendarAppearance.isWeekMode){
            break;
        }
    }
}

- (void)reloadAppearance
{
    if(cacheLastWeekMode != self.calendarManager.calendarAppearance.isWeekMode){
        cacheLastWeekMode = self.calendarManager.calendarAppearance.isWeekMode;
        [self configureConstraintsForSubviews];
    }
    
    [JTCalendarMonthWeekDaysView beforeReloadAppearance];
    [weekdaysView reloadAppearance];
    
    for(JTCalendarWeekView *view in weeksViews){
        [view reloadAppearance];
    }
}

@end
