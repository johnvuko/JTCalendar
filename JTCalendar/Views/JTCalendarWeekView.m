//
//  JTCalendarWeekView.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTCalendarWeekView.h"

#import "JTCalendarManager.h"

#define NUMBER_OF_DAY_BY_WEEK 7.

@interface JTCalendarWeekView (){
    NSMutableArray *_daysViews;
}

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
    // Maybe used in future
}

- (void)setStartDate:(NSDate *)startDate updateAnotherMonth:(BOOL)enable monthDate:(NSDate *)monthDate
{
    NSAssert(startDate != nil, @"startDate cannot be nil");
    NSAssert(_manager != nil, @"manager cannot be nil");
    if(enable){
        NSAssert(monthDate != nil, @"monthDate cannot be nil");
    }
    
    self->_startDate = startDate;
    
    [self createDayViews];
    [self reloadAndUpdateAnotherMonth:enable monthDate:monthDate];
}

- (void)reloadAndUpdateAnotherMonth:(BOOL)enable monthDate:(NSDate *)monthDate
{
    NSDate *dayDate = _startDate;
    
    for(UIView<JTCalendarDay> *dayView in _daysViews){
        // Must done before setDate to dayView for `prepareDayView` method
        if(!enable){
            [dayView setIsFromAnotherMonth:NO];
        }
        else{
            if([_manager.dateHelper date:dayDate isTheSameMonthThan:monthDate]){
                [dayView setIsFromAnotherMonth:NO];
            }
            else{
                [dayView setIsFromAnotherMonth:YES];
            }
        }
        
        dayView.date = dayDate;
        dayDate = [_manager.dateHelper addToDate:dayDate days:1];
    }
}

- (void)createDayViews
{
    if(!_daysViews){
        _daysViews = [NSMutableArray new];
        
        for(int i = 0; i < NUMBER_OF_DAY_BY_WEEK; ++i){
            UIView<JTCalendarDay> *dayView = [_manager.delegateManager buildDayView];
            [_daysViews addObject:dayView];
            [self addSubview:dayView];
            
            dayView.manager = _manager;
        }
    }
}

- (void)layoutSubviews
{
    if(!_daysViews){
        return;
    }
    
    CGFloat x = 0;
    CGFloat dayWidth = self.frame.size.width / NUMBER_OF_DAY_BY_WEEK;
    CGFloat dayHeight = self.frame.size.height;
    
    for(UIView *dayView in _daysViews){
        dayView.frame = CGRectMake(x, 0, dayWidth, dayHeight);
        x += dayWidth;
    }
}

@end
