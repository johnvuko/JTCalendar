//
//  JTCalendarMenuMonthView.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTCalendarMenuMonthView.h"

@interface JTCalendarMenuMonthView(){
    UILabel *textLabel;
}
@property (assign, nonatomic) BOOL autoDissolve;
@property (assign, nonatomic) CGFloat autoDissolveMinAlpha;
@property (assign, nonatomic) CGFloat autoDissolveMaxAlpha;

@end

@implementation JTCalendarMenuMonthView

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
    {
        textLabel = [UILabel new];
        [self addSubview:textLabel];
        
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.numberOfLines = 0;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGFloat offsetX = [self convertPoint:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) toView:self.window].x;
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat alpha = _autoDissolveMaxAlpha - (ABS(screenWidth/2-offsetX)/(screenWidth/2))*(_autoDissolveMaxAlpha-_autoDissolveMinAlpha);
        self.alpha = alpha;
    }
}

- (void)setCurrentDate:(NSDate *)currentDate
{
    textLabel.text = self.calendarManager.calendarAppearance.monthBlock(currentDate, self.calendarManager);
}

- (void)setAutoDissolve:(BOOL)autoDissolve
{
    if (_autoDissolve != autoDissolve) {
        _autoDissolve = autoDissolve;
        if (_autoDissolve) {
            [self.calendarManager.menuMonthsView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        } else {
            [self.calendarManager.menuMonthsView removeObserver:self forKeyPath:@"contentOffset"];
        }
    }
}

- (void)layoutSubviews
{
    textLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);

    // No need to call [super layoutSubviews]
}

- (void)reloadAppearance
{
    textLabel.textColor = self.calendarManager.calendarAppearance.menuMonthTextColor;
    textLabel.font = self.calendarManager.calendarAppearance.menuMonthTextFont;
    _autoDissolveMinAlpha = self.calendarManager.calendarAppearance.autoDissolveMinAlpha;
    _autoDissolveMaxAlpha = self.calendarManager.calendarAppearance.autoDissolveMaxAlpha;
    self.autoDissolve = self.calendarManager.calendarAppearance.autoDissolveMenu;
}

- (void)dealloc
{
    [self.calendarManager.menuMonthsView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
