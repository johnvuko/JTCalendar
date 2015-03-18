//
//  JTUtils.m
//  Pods
//
//  Created by George Polak on 3/18/15.
//
//

#import "JTUtils.h"

@implementation JTUtils

+ (NSDate *)dateOnlyFromDate:(NSDate *)date {
    if (!date)
        return nil;
    
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:flags fromDate:date];
    
    return [calendar dateFromComponents:components];
}

@end
