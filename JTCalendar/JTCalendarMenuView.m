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

@property (assign, nonatomic) BOOL autoDissolve;
@property (assign, nonatomic) CGFloat autoDissolveMinAlpha;
@property (assign, nonatomic) CGFloat autoDissolveMaxAlpha;

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

- (void)dealloc
{
    @try {
        [self removeObserver:self forKeyPath:@"contentOffset"];
    }@catch (NSException *exception) {
        
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
    NSDateComponents *dayComponent = [NSDateComponents new];
    
    for(int i = 0; i < NUMBER_PAGES_LOADED; ++i){
        JTCalendarMenuMonthView *monthView = monthsViews[i];
        
        dayComponent.month = i - (NUMBER_PAGES_LOADED / 2);
        NSDate *monthDate = [calendar dateByAddingComponents:dayComponent toDate:self.currentDate options:0];
        [monthView setCurrentDate:monthDate];
    }
}

- (void)setAutoDissolve:(BOOL)autoDissolve
{
    if (_autoDissolve != autoDissolve) {
        _autoDissolve = autoDissolve;
        if (_autoDissolve) {
            [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        } else {
            @try {
                [self removeObserver:self forKeyPath:@"contentOffset"];
            }
            @catch (NSException *exception) {
                
            }
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [monthsViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIView *monthView = obj;
            CGFloat offsetX = [monthView convertPoint:CGPointMake(monthView.bounds.size.width/2, monthView.bounds.size.height/2) toView:self.window].x;
            CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
            CGFloat alpha = _autoDissolveMaxAlpha - ABS(screenWidth/2-offsetX)/(screenWidth/2)*(_autoDissolveMaxAlpha-_autoDissolveMinAlpha);
            monthView.alpha = alpha;
        }];
    }
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
    _autoDissolveMinAlpha = self.calendarManager.calendarAppearance.autoDissolveMinAlpha;
    _autoDissolveMaxAlpha = self.calendarManager.calendarAppearance.autoDissolveMaxAlpha;
    self.autoDissolve = self.calendarManager.calendarAppearance.autoDissolveMenu;
}

@end
