//
//  JTCalendarManager.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTCalendarManager.h"

#import "JTHorizontalCalendarView.h"

@implementation JTCalendarManager

- (instancetype)init
{
    return [self initWithLocale:[NSLocale currentLocale] andTimeZone:[NSTimeZone localTimeZone]];
}

- (instancetype)initWithLocale:(NSLocale *)locale andTimeZone:(NSTimeZone *)timeZone
{
    self = [super init];
    if(!self){
        return nil;
    }
    [self commonInit:locale andTimeZone:timeZone];
    
    return self;
}

- (void)commonInit:(NSLocale *)locale andTimeZone:(NSTimeZone *)timeZone
{
    _dateHelper = [[JTDateHelper alloc] initWithLocale:locale andTimeZone:timeZone];
    _settings = [JTCalendarSettings new];
    
    _delegateManager = [JTCalendarDelegateManager new];
    _delegateManager.manager = self;
    
    _scrollManager = [JTCalendarScrollManager new];
    _scrollManager.manager = self;
}

- (void)setContentView:(UIScrollView<JTContent> *)contentView
{
    [_contentView setManager:nil];
    self->_contentView = contentView;
    [_contentView setManager:self];
    
    // Can only synchronise JTHorizontalCalendarView
    if([_contentView isKindOfClass:[JTHorizontalCalendarView class]]){
        _scrollManager.horizontalContentView = _contentView;
    }
    else{
        _scrollManager.horizontalContentView = nil;
    }
}

- (void)setMenuView:(UIScrollView<JTMenu> *)menuView
{
    [_menuView setManager:nil];
    self->_menuView = menuView;
    [_menuView setManager:self];
    
    _scrollManager.menuView = _menuView;
}

- (NSDate *)date
{
    return _contentView.date;
}

- (void)setDate:(NSDate *)date
{
    [_contentView setDate:date];
}

- (void)reload
{
    [_contentView setDate:_contentView.date];
}

@end
