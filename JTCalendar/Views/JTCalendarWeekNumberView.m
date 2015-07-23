//
//  JTCalendarWeekNumberView.m
//  Pods
//
//  Created by SSL on 23/07/15.
//
//

#import "JTCalendarWeekNumberView.h"
#import "JTCalendarManager.h"


@implementation JTCalendarWeekNumberView

- (void)reload
{
    static NSCalendar *cal = nil;
    
    if (!cal) {
        cal = [NSCalendar currentCalendar];
    }
    
    NSDateComponents *components = [cal components:NSWeekOfYearCalendarUnit fromDate:self.date];
    self.textLabel.text = [NSString stringWithFormat:@"%ld", [components weekOfYear]];

    
    [self.manager.delegateManager prepareWeekNumberView:self];
}

- (void)didTouch
{
    [self.manager.delegateManager didTouchWeekNumberView:self];
}


@end
