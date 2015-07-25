//
//  JTVerticalCalendarView.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTVerticalCalendarView.h"

#import "JTCalendarManager.h"

typedef NS_ENUM(NSInteger, JTCalendarPageMode) {
    JTCalendarPageModeFull,
    JTCalendarPageModeCenter,
    JTCalendarPageModeCenterLeft,
    JTCalendarPageModeCenterRight
};

@interface JTVerticalCalendarView (){
    CGSize _lastSize;
    
    UIView<JTCalendarPage> *_leftView;
    UIView<JTCalendarPage> *_centerView;
    UIView<JTCalendarPage> *_rightView;
    
    JTCalendarPageMode _pageMode;
}

@end

@implementation JTVerticalCalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
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
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.pagingEnabled = YES;
    self.clipsToBounds = YES;
}

- (void)layoutSubviews
{
    [self resizeViewsIfWidthChanged];
    [self viewDidScroll];
}

- (void)resizeViewsIfWidthChanged
{
    CGSize size = self.frame.size;
    if(size.height != _lastSize.height){
        _lastSize = size;
        
        [self repositionViews];
    }
    else if(size.width != _lastSize.width){
        _lastSize = size;
        
        _leftView.frame = CGRectMake(0, _leftView.frame.origin.y, size.width, size.height);
        _centerView.frame = CGRectMake(0, _centerView.frame.origin.y, size.width, size.height);
        _rightView.frame = CGRectMake(0, _rightView.frame.origin.y, size.width, size.height);
        
        self.contentSize = CGSizeMake(size.width, self.contentSize.height);
    }
}

- (void)viewDidScroll
{
    if(self.contentSize.height <= 0){
        return;
    }

    CGSize size = self.frame.size;
    
    switch (_pageMode) {
        case JTCalendarPageModeFull:
            
            if(self.contentOffset.y < size.height / 2.){
                [self loadPreviousPage];
            }
            else if(self.contentOffset.y > size.height * 1.5){
                [self loadNextPage];
            }
            
            break;
        case JTCalendarPageModeCenter:
            
            break;
        case JTCalendarPageModeCenterLeft:
            
            if(self.contentOffset.y < size.height / 2.){
                [self loadPreviousPage];
            }
            
            break;
        case JTCalendarPageModeCenterRight:
            
            if(self.contentOffset.y > size.height / 2.){
                [self loadNextPage];
            }
            
            break;
    }
    
    [_manager.scrollManager updateMenuContentOffset:(self.contentOffset.y / self.contentSize.height) pageMode:_pageMode];
}

- (void)loadPreviousPageWithAnimation
{
    switch (_pageMode) {
        case JTCalendarPageModeCenterRight:
        case JTCalendarPageModeCenter:
            return;
        default:
            break;
    }
    
    CGSize size = self.frame.size;
    CGPoint point = CGPointMake(0, self.contentOffset.y - size.height);
    [self setContentOffset:point animated:YES];
}

- (void)loadNextPageWithAnimation
{
    switch (_pageMode) {
        case JTCalendarPageModeCenterLeft:
        case JTCalendarPageModeCenter:
            return;
        default:
            break;
    }
    
    CGSize size = self.frame.size;
    CGPoint point = CGPointMake(0, self.contentOffset.y + size.height);
    [self setContentOffset:point animated:YES];
}

- (void)loadPreviousPage
{
    NSDate *nextDate = [_manager.delegateManager dateForPreviousPageWithCurrentDate:_leftView.date];
    
    // Must be set before chaging date for PageView for updating day views
    self->_date = _leftView.date;
    
    UIView<JTCalendarPage> *tmpView = _rightView;
    
    _rightView = _centerView;
    _centerView = _leftView;
    
    _leftView = tmpView;
    _leftView.date = nextDate;
    
    [self updateMenuDates];
    
    JTCalendarPageMode previousPageMode = _pageMode;
    
    [self updatePageMode];
    
    CGSize size = self.frame.size;
    
    switch (_pageMode) {
        case JTCalendarPageModeFull:
            
            _leftView.frame = CGRectMake(0, 0, size.width, size.height);
            _centerView.frame = CGRectMake(0, size.height, size.width, size.height);
            _rightView.frame = CGRectMake(0, size.height * 2, size.width, size.height);
            
            if(previousPageMode == JTCalendarPageModeFull){
                self.contentOffset = CGPointMake(0, self.contentOffset.y + size.height);
            }
            else if(previousPageMode ==  JTCalendarPageModeCenterLeft){
                self.contentOffset = CGPointMake(0, self.contentOffset.y + size.height);
            }
            
            self.contentSize = CGSizeMake(size.width, size.height * 3);
            
            break;
        case JTCalendarPageModeCenter:
            // Not tested
            
            _leftView.frame = CGRectMake(0, - size.height, size.width, size.height);
            _centerView.frame = CGRectMake(0, 0, size.width, size.height);
            _rightView.frame = CGRectMake(0, size.height, size.width, size.height);
            
            self.contentSize = size;
            
            break;
        case JTCalendarPageModeCenterLeft:
            
            _leftView.frame = CGRectMake(0, 0, size.width, size.height);
            _centerView.frame = CGRectMake(0, size.height, size.width, size.height);
            _rightView.frame = CGRectMake(0, size.height * 2, size.width, size.height);
            
            self.contentOffset = CGPointMake(0, self.contentOffset.y + size.height);
            self.contentSize = CGSizeMake(size.width, size.height * 2);
            
            break;
        case JTCalendarPageModeCenterRight:
            
            _leftView.frame = CGRectMake(0, - size.height, size.width, size.height);
            _centerView.frame = CGRectMake(0, 0, size.width, size.height);
            _rightView.frame = CGRectMake(0, size.height, size.width, size.height);
            
            self.contentSize = CGSizeMake(size.width, size.height * 2);
            
            break;
    }
    
    // Update subviews
    [_rightView reload];
    [_centerView reload];
    
    if(_manager.delegate && [_manager.delegate respondsToSelector:@selector(calendarDidLoadPreviousPage:)]){
        [_manager.delegate calendarDidLoadPreviousPage:_manager];
    }
}

- (void)loadNextPage
{
    NSDate *nextDate = [_manager.delegateManager dateForNextPageWithCurrentDate:_rightView.date];
    
    // Must be set before chaging date for PageView for updating day views
    self->_date = _rightView.date;
    
    UIView<JTCalendarPage> *tmpView = _leftView;
    
    _leftView = _centerView;
    _centerView = _rightView;
    
    _rightView = tmpView;
    _rightView.date = nextDate;
    
    [self updateMenuDates];
    
    JTCalendarPageMode previousPageMode = _pageMode;
    
    [self updatePageMode];
    
    CGSize size = self.frame.size;
    
    switch (_pageMode) {
        case JTCalendarPageModeFull:
            
            _leftView.frame = CGRectMake(0, 0, size.width, size.height);
            _centerView.frame = CGRectMake(0, size.height, size.width, size.height);
            _rightView.frame = CGRectMake(0, size.height * 2, size.width, size.height);
            
            if(previousPageMode == JTCalendarPageModeFull){
                self.contentOffset = CGPointMake(0, self.contentOffset.y - size.height);
            }
            self.contentSize = CGSizeMake(size.width, size.height * 3);
            
            break;
        case JTCalendarPageModeCenter:
            // Not tested
            
            _leftView.frame = CGRectMake(0, - size.height, size.width, size.height);
            _centerView.frame = CGRectMake(0, 0, size.width, size.height);
            _rightView.frame = CGRectMake(0, size.height, size.width, size.height);
            
            self.contentSize = size;
            
            break;
        case JTCalendarPageModeCenterLeft:
            
            _leftView.frame = CGRectMake(0, 0, size.width, size.height);
            _centerView.frame = CGRectMake(0, size.height, size.width, size.height);
            _rightView.frame = CGRectMake(0, size.height * 2, size.width, size.height);
            
            self.contentOffset = CGPointMake(0, self.contentOffset.y - size.height);
            
            // Must be set a the end else the scroll freeze
            self.contentSize = CGSizeMake(size.width, size.height * 2);
            
            break;
        case JTCalendarPageModeCenterRight:
            // Not tested
            
            _leftView.frame = CGRectMake(0, - size.height, size.width, size.height);
            _centerView.frame = CGRectMake(0, 0, size.width, size.height);
            _rightView.frame = CGRectMake(0, size.height, size.width, size.height);
            
            self.contentSize = CGSizeMake(size.width, size.height * 2);
            
            break;
    }
    
    // Update subviews
    [_leftView reload];
    [_centerView reload];
    
    if(_manager.delegate && [_manager.delegate respondsToSelector:@selector(calendarDidLoadNextPage:)]){
        [_manager.delegate calendarDidLoadNextPage:_manager];
    }
}

- (void)setDate:(NSDate *)date
{
    NSAssert(date != nil, @"date cannot be nil");
    NSAssert(_manager != nil, @"manager cannot be nil");
    
    self->_date = date;
    
    if(!_leftView){
        _leftView = [_manager.delegateManager buildPageView];
        [self addSubview:_leftView];
        
        _centerView = [_manager.delegateManager buildPageView];
        [self addSubview:_centerView];
        
        _rightView = [_manager.delegateManager buildPageView];
        [self addSubview:_rightView];
        
        [self updateManagerForViews];
    }
    
    _leftView.date = [_manager.delegateManager dateForPreviousPageWithCurrentDate:date];
    _centerView.date = date;
    _rightView.date = [_manager.delegateManager dateForNextPageWithCurrentDate:date];
    
    [self updateMenuDates];
    
    [self updatePageMode];
    [self repositionViews];
}

- (void)setManager:(JTCalendarManager *)manager
{
    self->_manager = manager;
    [self updateManagerForViews];
}

- (void)updateManagerForViews
{
    if(!_manager || !_leftView){
        return;
    }
    
    _leftView.manager = _manager;
    _centerView.manager = _manager;
    _rightView.manager = _manager;
}

- (void)updatePageMode
{
    BOOL haveLeftPage = [_manager.delegateManager canDisplayPageWithDate:_leftView.date];
    BOOL haveRightPage = [_manager.delegateManager canDisplayPageWithDate:_rightView.date];
    
    if(haveLeftPage && haveRightPage){
        _pageMode = JTCalendarPageModeFull;
    }
    else if(!haveLeftPage && !haveRightPage){
        _pageMode = JTCalendarPageModeCenter;
    }
    else if(!haveLeftPage){
        _pageMode = JTCalendarPageModeCenterRight;
    }
    else{
        _pageMode = JTCalendarPageModeCenterLeft;
    }
    
    if(_manager.settings.pageViewHideWhenPossible){
        _leftView.hidden = !haveLeftPage;
        _rightView.hidden = !haveRightPage;
    }
    else{
        _leftView.hidden = NO;
        _rightView.hidden = NO;
    }
}

- (void)repositionViews
{
    CGSize size = self.frame.size;
    
    switch (_pageMode) {
        case JTCalendarPageModeFull:
            self.contentSize = CGSizeMake(size.width, size.height * 3);
            
            _leftView.frame = CGRectMake(0, 0, size.width, size.height);
            _centerView.frame = CGRectMake(0, size.height, size.width, size.height);
            _rightView.frame = CGRectMake(0, size.height * 2, size.width, size.height);
            
            self.contentOffset = CGPointMake(0, size.height);
            break;
        case JTCalendarPageModeCenter:
            self.contentSize = size;
            
            _leftView.frame = CGRectMake(0, - size.height, size.width, size.height);
            _centerView.frame = CGRectMake(0, 0, size.width, size.height);
            _rightView.frame = CGRectMake(0, size.height, size.width, size.height);
            
            self.contentOffset = CGPointZero;
            break;
        case JTCalendarPageModeCenterLeft:
            self.contentSize = CGSizeMake(size.width, size.height * 2);
            
            _leftView.frame = CGRectMake(0, 0, size.width, size.height);
            _centerView.frame = CGRectMake(0, size.height, size.width, size.height);
            _rightView.frame = CGRectMake(0, size.height * 2, size.width, size.height);
            
            self.contentOffset = CGPointMake(0, size.height);
            break;
        case JTCalendarPageModeCenterRight:
            self.contentSize = CGSizeMake(size.width, size.height * 2);
            
            _leftView.frame = CGRectMake(0, - size.height, size.width, size.height);
            _centerView.frame = CGRectMake(0, 0, size.width, size.height);
            _rightView.frame = CGRectMake(0, size.height, size.width, size.height);
            
            self.contentOffset = CGPointZero;
            break;
    }
}

- (void)updateMenuDates
{
    [_manager.scrollManager setMenuPreviousDate:_leftView.date
                                    currentDate:_centerView.date
                                       nextDate:_rightView.date];
}
@end
