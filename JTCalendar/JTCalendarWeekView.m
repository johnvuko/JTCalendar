//
//  JTCalendarWeekView.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTCalendarWeekView.h"

#import "JTCalendarDayView.h"

@interface JTCalendarWeekView (){
    NSArray *daysViews;
};

@end

@implementation JTCalendarWeekView

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
    
    for(int i = 0; i < 7; ++i){
        UIView *view = [JTCalendarDayView new];
        
        [views addObject:view];
        [self addSubview:view];
    }
    
    daysViews = views;
    
    [self configureConstraintsForSubviews];
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

- (void)setBeginningOfWeek:(NSDate *)date
{
    NSDate *currentDate = date;
    
    NSCalendar *calendar = self.calendarManager.calendarAppearance.calendar;
    
    for(JTCalendarDayView *view in daysViews){
        if(!self.calendarManager.calendarAppearance.isWeekMode){
            NSDateComponents *comps = [calendar components:NSCalendarUnitMonth fromDate:currentDate];
            NSInteger monthIndex = comps.month;
                        
            [view setIsOtherMonth:monthIndex != self.currentMonthIndex];
        }
        else{
            [view setIsOtherMonth:NO];
        }
        
        [view setDate:currentDate];
        
        NSDateComponents *dayComponent = [NSDateComponents new];
        dayComponent.day = 1;
        
        currentDate = [calendar dateByAddingComponents:dayComponent toDate:currentDate options:0];
    }
}

#pragma mark - JTCalendarManager

- (void)setCalendarManager:(JTCalendar *)calendarManager
{
    self->_calendarManager = calendarManager;
    for(JTCalendarDayView *view in daysViews){
        [view setCalendarManager:calendarManager];
    }
}

- (void)reloadData
{
    for(JTCalendarDayView *view in daysViews){
        [view reloadData];
    }
}

- (void)reloadAppearance
{
    for(JTCalendarDayView *view in daysViews){
        [view reloadAppearance];
    }
}

@end
