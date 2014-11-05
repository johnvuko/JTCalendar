//
//  JTCalendarMenuView.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTCalendarMenuView.h"

#import "JTCalendar.h"
#import "JTCalendarMenuMonthView.h"

#define NUMBER_PAGES_LOADED 5 // Must be the same in JTCalendarView, JTCalendarMenuView, JTCalendarContentView

@interface JTCalendarMenuView(){
    NSMutableArray *monthsViews;
}

@end

@implementation JTCalendarMenuView

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
        JTCalendarMenuMonthView *monthView = [JTCalendarMenuMonthView new];
                
        [self addSubview:monthView];
        [monthsViews addObject:monthView];
    }
}

- (void)layoutSubviews
{
    [self configureConstraintsForSubviews];
        
    [super layoutSubviews];
}

- (void)configureConstraintsForSubviews
{
    self.contentOffset = CGPointMake(self.contentOffset.x, 0); // Prevent bug when contentOffset.y is negative
    
    CGFloat x = 0;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    if(self.calendarManager.calendarAppearance.ratioContentMenu != 1.){
        width = self.frame.size.width / self.calendarManager.calendarAppearance.ratioContentMenu;
        x = (self.frame.size.width - width) / 2.;
    }
    
    for(UIView *view in monthsViews){
        view.frame = CGRectMake(x, 0, width, height);
        x = CGRectGetMaxX(view.frame);
    }
    
    self.contentSize = CGSizeMake(width * NUMBER_PAGES_LOADED, height);
}

- (void)setCurrentDate:(NSDate *)currentDate
{
    self->_currentDate = currentDate;
 
    NSCalendar *calendar = self.calendarManager.calendarAppearance.calendar;
    NSDateComponents *comps = [calendar components:NSCalendarUnitMonth fromDate:currentDate];
    NSInteger currentMonthIndex = comps.month;
    
    for(int i = 0; i < NUMBER_PAGES_LOADED; ++i){
        JTCalendarMenuMonthView *monthView = monthsViews[i];
        NSInteger monthIndex = currentMonthIndex - (NUMBER_PAGES_LOADED / 2) + i;
        monthIndex = monthIndex % 12;

        [monthView setMonthIndex:monthIndex];
    }
}

#pragma mark - Load Month

- (void)loadPreviousMonth
{
    JTCalendarMenuMonthView *monthView = [monthsViews lastObject];
    
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
        NSDateComponents *comps = [calendar components:NSCalendarUnitMonth fromDate:self.currentDate];
        NSInteger currentMonthIndex = comps.month;
        
        NSInteger monthIndex = currentMonthIndex - (NUMBER_PAGES_LOADED / 2);
        monthIndex = monthIndex % 12;
        [monthView setMonthIndex:monthIndex];
    }
    
    [self configureConstraintsForSubviews];
}

- (void)loadNextMonth
{
    JTCalendarMenuMonthView *monthView = [monthsViews firstObject];
    
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
        NSDateComponents *comps = [calendar components:NSCalendarUnitMonth fromDate:self.currentDate];
        NSInteger currentMonthIndex = comps.month;
        
        NSInteger monthIndex = currentMonthIndex - (NUMBER_PAGES_LOADED / 2) + (NUMBER_PAGES_LOADED - 1);
        monthIndex = monthIndex % 12;
        [monthView setMonthIndex:monthIndex];
    }
    
    [self configureConstraintsForSubviews];
}

#pragma mark - JTCalendarManager

- (void)setCalendarManager:(JTCalendar *)calendarManager
{
    self->_calendarManager = calendarManager;
    
    for(JTCalendarMenuMonthView *view in monthsViews){
        [view setCalendarManager:calendarManager];
    }
}

- (void)reloadAppearance
{
    self.scrollEnabled = !self.calendarManager.calendarAppearance.isWeekMode;
    
    [self configureConstraintsForSubviews];
    for(JTCalendarMenuMonthView *view in monthsViews){
        [view reloadAppearance];
    }
}

@end
