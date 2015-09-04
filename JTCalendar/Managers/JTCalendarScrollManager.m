//
//  JTCalendarScrollManager.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTCalendarScrollManager.h"

@implementation JTCalendarScrollManager

- (void)setMenuPreviousDate:(NSDate *)previousDate
                currentDate:(NSDate *)currentDate
                   nextDate:(NSDate *)nextDate
{
    if(!_menuView){
        return;
    }
    
    [_menuView setPreviousDate:previousDate currentDate:currentDate nextDate:nextDate];
}

- (void)updateMenuContentOffset:(CGFloat)percentage pageMode:(NSUInteger)pageMode
{
    if(!_menuView){
        return;
    }
    
    [_menuView updatePageMode:pageMode];
    _menuView.scrollView.contentOffset = CGPointMake(percentage * _menuView.scrollView.contentSize.width, 0);
}

- (void)updateHorizontalContentOffset:(CGFloat)percentage
{
    if(!_horizontalContentView){
        return;
    }
    
    _horizontalContentView.contentOffset = CGPointMake(percentage * _horizontalContentView.contentSize.width, 0);
}

- (void)endDragging
{
    if(![_horizontalContentView.delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]){
        return;
    }

    [_horizontalContentView.delegate scrollViewDidEndDragging:_horizontalContentView willDecelerate:NO];
}

- (void)endDecelerating
{
    if(![_horizontalContentView.delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]){
        return;
    }

    [_horizontalContentView.delegate scrollViewDidEndDecelerating:_horizontalContentView];
}

- (void)endHorizontalScrollingAnimation
{
    if(![_horizontalContentView.delegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]){
        return;
    }

    [_horizontalContentView.delegate scrollViewDidEndScrollingAnimation:_horizontalContentView];
}

@end
