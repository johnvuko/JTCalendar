//
//  JTCalendarDataCache.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTCalendarDataCache.h"

#import "JTCalendar.h"

@interface JTCalendarDataCache(){
    NSMutableDictionary *events;
    NSDateFormatter *dateFormatter;
};

@end

@implementation JTCalendarDataCache

- (instancetype)init
{
    self = [super init];
    if(!self){
        return nil;
    }
    
    dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    events = [NSMutableDictionary new];
    
    return self;
}

- (void)reloadData
{
    [events removeAllObjects];
}

- (NSUInteger)numberOfEvents:(NSDate *)date
{
    if(!self.calendarManager.dataSource){
        return NO;
    }
    
    if (!self.calendarManager.calendarAppearance.useCacheSystem) {
        if ([self.calendarManager.dataSource respondsToSelector:@selector(calendarNumberOfEvents:date:)]) {
            return [self.calendarManager.dataSource calendarNumberOfEvents:self.calendarManager date:date];
        } else if ([self.calendarManager.dataSource respondsToSelector:@selector(calendarHaveEvent:date:)]) {
            return [self.calendarManager.dataSource calendarHaveEvent:self.calendarManager date:date] ? 1 : 0;
        } else {
            return NO;
        }
    }
    
    NSUInteger numberOfEvents;
    NSString *key = [dateFormatter stringFromDate:date];
    
    if(events[key] != nil){
        numberOfEvents = [events[key] unsignedIntegerValue];
    }
    else{
        if ([self.calendarManager.dataSource respondsToSelector:@selector(calendarNumberOfEvents:date:)]) {
            numberOfEvents = [self.calendarManager.dataSource calendarNumberOfEvents:self.calendarManager date:date];
        } else if ([self.calendarManager.dataSource respondsToSelector:@selector(calendarHaveEvent:date:)]) {
            numberOfEvents = [self.calendarManager.dataSource calendarHaveEvent:self.calendarManager date:date] ? 1 : 0;
        } else {
            numberOfEvents = 0;
        }

        events[key] = @(numberOfEvents);
    }
    
    return numberOfEvents;
}

@end