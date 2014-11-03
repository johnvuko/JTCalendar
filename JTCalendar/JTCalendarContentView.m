//
//  JTCalendarContentView.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTCalendarContentView.h"

#import "JTCalendar.h"

#import "JTCalendarMonthView.h"
#import "JTCalendarWeekView.h"

#define NUMBER_PAGES_LOADED 5 // Must be the same in JTCalendarView, JTCalendarMenuView, JTCalendarContentView

@interface JTCalendarContentView(){
    NSMutableArray *monthsViews;
}

@end

@implementation JTCalendarContentView

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
    monthsViews = [NSMutableArray new];
    
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.pagingEnabled = YES;
    
    for(int i = 0; i < NUMBER_PAGES_LOADED; ++i){
        JTCalendarMonthView *monthView = [JTCalendarMonthView new];
        [self addSubview:monthView];
        [monthsViews addObject:monthView];
    }
    
    [self configureConstraintsForSubviews];
}

- (void)configureConstraintsForSubviews
{
    for(UIView *view in self.subviews){
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.height.equalTo(self.mas_height);
            make.width.equalTo(self.mas_width);
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
        }];
    }
}

- (void)setCurrentDate:(NSDate *)currentDate
{
    self->_currentDate = currentDate;

    NSCalendar *calendar = self.calendarManager.calendarAppearance.calendar;
    
    for(int i = 0; i < NUMBER_PAGES_LOADED; ++i){
        JTCalendarMonthView *monthView = monthsViews[i];
        
        NSDateComponents *dayComponent = [NSDateComponents new];
        
        if(!self.calendarManager.calendarAppearance.isWeekMode){
            dayComponent.month = i - (NUMBER_PAGES_LOADED / 2);
         
            NSDate *monthDate = [calendar dateByAddingComponents:dayComponent toDate:self.currentDate options:0];
            monthDate = [self beginningOfMonth:monthDate];
            [monthView setBeginningOfMonth:monthDate];
        }
        else{
            dayComponent.day = 7 * (i - (NUMBER_PAGES_LOADED / 2));
            
            NSDate *monthDate = [calendar dateByAddingComponents:dayComponent toDate:self.currentDate options:0];
            monthDate = [self beginningOfWeek:monthDate];
            [monthView setBeginningOfMonth:monthDate];
        }
    }
}

- (NSDate *)beginningOfMonth:(NSDate *)date
{
    NSCalendar *calendar = self.calendarManager.calendarAppearance.calendar;
    NSDateComponents *componentsCurrentDate = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth fromDate:date];
    
    NSDateComponents *componentsNewDate = [NSDateComponents new];
    
    componentsNewDate.year = componentsCurrentDate.year;
    componentsNewDate.month = componentsCurrentDate.month;
    componentsNewDate.weekOfMonth = 1;
    componentsNewDate.weekday = calendar.firstWeekday;
    
    return [calendar dateFromComponents:componentsNewDate];
}

- (NSDate *)beginningOfWeek:(NSDate *)date
{
    NSCalendar *calendar = self.calendarManager.calendarAppearance.calendar;
    NSDateComponents *componentsCurrentDate = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth fromDate:date];
    
    NSDateComponents *componentsNewDate = [NSDateComponents new];
    
    componentsNewDate.year = componentsCurrentDate.year;
    componentsNewDate.month = componentsCurrentDate.month;
    componentsNewDate.weekOfMonth = componentsCurrentDate.weekOfMonth;
    componentsNewDate.weekday = calendar.firstWeekday;
    
    return [calendar dateFromComponents:componentsNewDate];
}

#pragma mark - Load Month

- (void)loadPreviousMonth
{
    JTCalendarMonthView *monthView = [monthsViews lastObject];
    
    [monthsViews removeLastObject];
    [monthsViews insertObject:monthView atIndex:0];
    
    NSCalendar *calendar = self.calendarManager.calendarAppearance.calendar;
    
    // Update currentDate
    {
        NSDateComponents *dayComponent = [NSDateComponents new];
        dayComponent.month = -1;
        self->_currentDate = [calendar dateByAddingComponents:dayComponent toDate:self.currentDate options:0];
    }
    
    // Update monthView
    {
        NSDateComponents *dayComponent = [NSDateComponents new];
        dayComponent.month = - (NUMBER_PAGES_LOADED / 2);
        
        NSDate *monthDate = [calendar dateByAddingComponents:dayComponent toDate:self.currentDate options:0];
        monthDate = [self beginningOfMonth:monthDate];
        
        [monthView setBeginningOfMonth:monthDate];
        [monthView reloadData];
    }
    
    [self configureConstraintsForSubviews];
}

- (void)loadNextMonth
{
    JTCalendarMonthView *monthView = [monthsViews firstObject];

    [monthsViews removeObjectAtIndex:0];
    [monthsViews addObject:monthView];
    
    NSCalendar *calendar = self.calendarManager.calendarAppearance.calendar;
    
    // Update currentDate
    {
        NSDateComponents *dayComponent = [NSDateComponents new];
        dayComponent.month = 1;
        self->_currentDate = [calendar dateByAddingComponents:dayComponent toDate:self.currentDate options:0];
    }
    
    // Update monthView
    {
        NSDateComponents *dayComponent = [NSDateComponents new];
        dayComponent.month = (NUMBER_PAGES_LOADED - 1) - (NUMBER_PAGES_LOADED / 2);
        
        NSDate *monthDate = [calendar dateByAddingComponents:dayComponent toDate:self.currentDate options:0];
        monthDate = [self beginningOfMonth:monthDate];
        
        [monthView setBeginningOfMonth:monthDate];
        [monthView reloadData];
    }
    
    [self configureConstraintsForSubviews];
}

#pragma mark - JTCalendarManager

- (void)setCalendarManager:(JTCalendar *)calendarManager
{
    self->_calendarManager = calendarManager;
    
    for(JTCalendarMonthView *view in monthsViews){
        [view setCalendarManager:calendarManager];
    }
    
    for(JTCalendarMonthView *view in monthsViews){
        [view setCalendarManager:calendarManager];
    }
}

- (void)reloadData
{
    for(JTCalendarMonthView *monthView in monthsViews){
        [monthView reloadData];
    }
}

- (void)reloadAppearance
{
    for(JTCalendarMonthView *monthView in monthsViews){
        [monthView reloadAppearance];
    }
}

@end
