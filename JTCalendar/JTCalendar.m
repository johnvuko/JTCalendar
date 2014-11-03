//
//  JTCalendar.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTCalendar.h"

#define NUMBER_PAGES_LOADED 5 // Must be the same in JTCalendarView, JTCalendarMenuView, JTCalendarContentView

@interface JTCalendar(){
    JTCalendarAppearance *calendarAppearance;
    BOOL cacheLastWeekMode;
}

@end

@implementation JTCalendar

- (instancetype)init
{
    self = [super init];
    if(!self){
        return nil;
    }
    
    calendarAppearance = [JTCalendarAppearance new];
    
    return self;
}

- (void)setMenuMonthsView:(JTCalendarMenuView *)menuMonthsView
{
    [self->_menuMonthsView setDelegate:nil];
    [self->_menuMonthsView setCalendarManager:nil];
    
    self->_menuMonthsView = menuMonthsView;
    [self->_menuMonthsView setDelegate:self];
    [self->_menuMonthsView setCalendarManager:self];
    
    cacheLastWeekMode = self.calendarAppearance.isWeekMode;
    
    [self.menuMonthsView reloadAppearance];
}

- (void)setContentView:(JTCalendarContentView *)contentView
{
    [self->_contentView setDelegate:nil];
    [self->_contentView setCalendarManager:nil];
    
    self->_contentView = contentView;
    [self->_contentView setDelegate:self];
    [self->_contentView setCalendarManager:self];
    
    [self.contentView reloadAppearance];
}

- (void)reloadData
{
    if(!self.currentDate){
        [self setCurrentDate:[NSDate date]];
        return; // Because setCurrentDate call reloadData
    }
    
    // Position to the middle page
    CGFloat pageWidth = CGRectGetWidth(self.contentView.frame);
    self.contentView.contentOffset = CGPointMake(pageWidth * ((NUMBER_PAGES_LOADED / 2)), self.contentView.contentOffset.y);
 
    if(self.calendarAppearance.isWeekMode){
        CGFloat menuPageWidth = CGRectGetWidth([self.menuMonthsView.subviews.firstObject frame]);
        self.menuMonthsView.contentOffset = CGPointMake(menuPageWidth * ((NUMBER_PAGES_LOADED / 2)), self.menuMonthsView.contentOffset.y);
    }
    
    [self.contentView reloadData];
}

- (void)reloadAppearance
{
    [self.menuMonthsView reloadAppearance];
    [self.contentView reloadAppearance];
    
    if(cacheLastWeekMode != self.calendarAppearance.isWeekMode){
        cacheLastWeekMode = self.calendarAppearance.isWeekMode;
        [self setCurrentDate:self.currentDate]; // Reload all data
    }
}

- (void)setCurrentDate:(NSDate *)currentDate
{
    self->_currentDate = currentDate;
    
    [self.menuMonthsView setCurrentDate:currentDate];
    [self.contentView setCurrentDate:currentDate];
    
    [self reloadData]; // For be on the good page and update all DayView
}

- (JTCalendarAppearance *)calendarAppearance
{
    return calendarAppearance;
}

#pragma mark - UIScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    if(self.calendarAppearance.isWeekMode){
        return;
    }
    
    if(sender == self.menuMonthsView){
        self.contentView.contentOffset = CGPointMake(sender.contentOffset.x * calendarAppearance.ratioContentMenu, self.contentView.contentOffset.y);
    }
    else{
        self.menuMonthsView.contentOffset = CGPointMake(sender.contentOffset.x / calendarAppearance.ratioContentMenu, self.menuMonthsView.contentOffset.y);
    }
}

// Use for scroll with scrollRectToVisible
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updatePage];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updatePage];
}

- (void)updatePage
{
    // Test which methods is the best
    [self updatePageMethod1];
}

- (void)updatePageMethod1
{
    CGFloat pageWidth = CGRectGetWidth(self.contentView.frame);
    CGFloat fractionalPage = self.contentView.contentOffset.x / pageWidth;
    
    // Faire un truc quand presque sur la bonne page
    
    int currentPage = roundf(fractionalPage);
    if (currentPage == (NUMBER_PAGES_LOADED / 2)){
        return;
    }

    NSCalendar *calendar = calendarAppearance.calendar;
    NSDateComponents *dayComponent = [NSDateComponents new];
    
    if(!self.calendarAppearance.isWeekMode){
        dayComponent.month = currentPage - (NUMBER_PAGES_LOADED / 2);
    }
    else{
        dayComponent.day = 7 * (currentPage - (NUMBER_PAGES_LOADED / 2));
    }
    
    NSDate *currentDate = [calendar dateByAddingComponents:dayComponent toDate:self.currentDate options:0];
    [self setCurrentDate:currentDate];
}

// Doesn't work in weekMode
- (void)updatePageMethod2
{
    CGFloat pageWidth = CGRectGetWidth(self.contentView.frame);
    CGFloat fractionalPage = self.contentView.contentOffset.x / pageWidth;
    
    int currentPage = roundf(fractionalPage);
    if (currentPage == (NUMBER_PAGES_LOADED / 2)){
        return;
    }
    
    int pagesDiff = abs(currentPage - (NUMBER_PAGES_LOADED / 2));
    if(currentPage < (NUMBER_PAGES_LOADED / 2)){
        for(int i = 0; i < pagesDiff; ++i){
            [self.contentView loadPreviousMonth];
            [self.menuMonthsView loadPreviousMonth];
        }
    }
    else{
        for(int i = 0; i < pagesDiff; ++i){
            [self.contentView loadNextMonth];
            [self.menuMonthsView loadNextMonth];
        }
    }
    
    self->_currentDate = self.contentView.currentDate;
    
    self.contentView.contentOffset = CGPointMake(pageWidth * ((NUMBER_PAGES_LOADED / 2)), self.contentView.contentOffset.y);
}

- (void)loadNextMonth
{
    if(self.calendarAppearance.isWeekMode){
        NSLog(@"JTCalendar loadNextMonth ignored");
        return;
    }
    
    CGRect frame = self.contentView.frame;
    frame.origin.x = frame.size.width * ((NUMBER_PAGES_LOADED / 2) + 1);
    frame.origin.y = 0;
    [self.contentView scrollRectToVisible:frame animated:YES];
}

- (void)loadPreviousMonth
{
    if(self.calendarAppearance.isWeekMode){
        NSLog(@"JTCalendar loadPreviousMonth ignored");
        return;
    }
    
    CGRect frame = self.contentView.frame;
    frame.origin.x = frame.size.width * ((NUMBER_PAGES_LOADED / 2) - 1);
    frame.origin.y = 0;
    [self.contentView scrollRectToVisible:frame animated:YES];
}

@end
