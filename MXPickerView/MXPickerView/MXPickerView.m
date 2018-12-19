//
//  MXPickerView.m
//  1008 - MXPickerView
//
//  Created by Michael on 2018/10/8.
//  Copyright © 2018 Michael. All rights reserved.
//

#import "MXPickerView.h"
#import "MXAnimation.h"

#pragma mark - ----------------------- MXPickerModel -----------------
@interface MXPickerModel : NSObject

@property (nonatomic, copy) NSString *title;

+ (instancetype)modelWithTitle:(NSString *)title;

@end

@implementation MXPickerModel

+ (instancetype)modelWithTitle:(NSString *)title {
    MXPickerModel *model = MXPickerModel.new;
    model.title = title;
    return model;
}

@end

#pragma mark - ----------------------- MXPickerView ---------------------
//RGBA
#define MXPV_RGBA_FROM_HEX(rgbValue, trans) [UIColor \
colorWithRed:((float)((0x##rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((0x##rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(0x##rgbValue & 0xFF))/255.0 alpha:trans]
//RGB
#define MXPV_RGB_FROM_HEX(rgbValue) MXPV_RGBA_FROM_HEX(rgbValue, 1.0f)

@interface MXPickerView () <UIPickerViewDataSource, UIPickerViewDelegate> {
    __weak UIView *_maskView;
    __weak UIToolbar *_toolBar;
    NSArray<NSString *> *_topTipBarTitles;
    BOOL _isClassUIDatePicker;
    id _uiDatePickerOrUIPickerView;
}

@property(nonatomic, readwrite) MXPickerViewMode pickerViewMode;

@end

@implementation MXPickerView
- (void)dealloc {
}
- (instancetype)initWithFrame:(CGRect)frame pickerViewMode:(MXPickerViewMode)pickerViewMode updateBlock:(void (^)(MXPickerView *pickerView, MXPickerViewMode pickerViewMode, id uiDatePickerOrUIPickerView))updateBlock {
    CGFloat safeH = 0;
    if (@available(iOS 11.0, *)) {
        safeH = [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
    }
    frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - frame.size.height  - safeH, frame.size.width, frame.size.height);
    self = [super initWithFrame:frame];
    if (!self) return nil;
    self.backgroundColor = [UIColor colorWithWhite:0.96f alpha:1.0f];
    _yearLocale = ![_yearLocale isKindOfClass:NSString.class] ? @"" : @"年";
    _monthLocale = ![_monthLocale isKindOfClass:NSString.class] ? @"" : @"月";
    _dayLocale = ![_dayLocale isKindOfClass:NSString.class] ? @"" : @"日";
    _modelsM = @[].mutableCopy;
    _toolBarH = _topTipBarH = 44;
    _pickerViewMode = pickerViewMode;
    !updateBlock ?: updateBlock(self, _pickerViewMode, nil);
    [self calculateDateIfNeeded];
    [self addCustomView];
    [self addMaskView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    UIDatePickerMode datePickerMode = UIDatePickerModeTime;
    switch (pickerViewMode) {
        case MXPickerViewModeMMDD_MMDD :
        case MXPickerViewModeMM_DD :
        case MXPickerViewModeMM_MM :
        case MXPickerViewModeMM: {
            NSCalendar *calendar = [NSCalendar currentCalendar];
            //[calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
            NSDateComponents *minComponents = !_minimumDate ? nil : [calendar components:NSCalendarUnitMonth fromDate:_minimumDate], *maxComponents = !_maximumDate ? nil : [calendar components:NSCalendarUnitMonth fromDate:_maximumDate];
            NSInteger min = minComponents.month, max = maxComponents.month;
            NSMutableArray<MXPickerModel *> *mmModelsM = @[].mutableCopy;
            if (min > max) {
                for (NSInteger i = min; i < 12; i++)
                    [mmModelsM addObject:[MXPickerModel modelWithTitle:[NSString stringWithFormat:@"%ld%@", i, _monthLocale]]];
                min = 0;
            }
            for (NSInteger i = min%12; i <= max; i++)
                [mmModelsM addObject:[MXPickerModel modelWithTitle:[NSString stringWithFormat:@"%ld%@", i ?: 12, _monthLocale]]];
            if (_showsDescending) mmModelsM = (id)mmModelsM.reverseObjectEnumerator.allObjects;
            if (pickerViewMode == MXPickerViewModeMM || pickerViewMode == MXPickerViewModeMM_MM) {
                [_modelsM addObject:mmModelsM];
                pickerViewMode == MXPickerViewModeMM ?: [_modelsM addObject:mmModelsM.mutableCopy];
            } else if (pickerViewMode == MXPickerViewModeMM_DD || pickerViewMode == MXPickerViewModeMMDD_MMDD) {
                //DD
                NSMutableArray *ddModelsM = @[].mutableCopy;
                for (NSInteger i = 1; i <= 31; i++)
                    [ddModelsM addObject:[MXPickerModel modelWithTitle:[NSString stringWithFormat:@"%ld%@", i, _dayLocale]]];
                if (_showsDescending) ddModelsM = (id)ddModelsM.reverseObjectEnumerator.allObjects;
                [_modelsM addObject:mmModelsM];
                [_modelsM addObject:ddModelsM];
                if (pickerViewMode == MXPickerViewModeMMDD_MMDD) {
                    [_modelsM addObject:mmModelsM.mutableCopy];
                    [_modelsM addObject:ddModelsM.mutableCopy];
                }
            }
            break;
        }
        case MXPickerViewModeDD:
        case MXPickerViewModeDD_DD: {
            NSInteger numberOfDays = [self numberOfDaysInTheMonthOfDate:_maximumDate];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            //[calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
            NSDateComponents *minComponents = !_minimumDate ? nil : [calendar components:NSCalendarUnitDay fromDate:_minimumDate], *maxComponents = !_maximumDate ? nil : [calendar components:NSCalendarUnitDay fromDate:_maximumDate];
            NSInteger min = minComponents.day, max = maxComponents.day;
            NSMutableArray<MXPickerModel *> *modelsM = @[].mutableCopy;
            if (min > max) {
                for (NSInteger i = min; i < numberOfDays; i++)
                    [modelsM addObject:[MXPickerModel modelWithTitle:[NSString stringWithFormat:@"%ld%@", i, _dayLocale]]];
                min = 0;
            }
            for (NSInteger i = min%numberOfDays; i <= max; i++)
                [modelsM addObject:[MXPickerModel modelWithTitle:[NSString stringWithFormat:@"%ld%@", i ?: numberOfDays, _dayLocale]]];
            if (_showsDescending) modelsM = (id)modelsM.reverseObjectEnumerator.allObjects;
            [_modelsM addObject:modelsM];
            pickerViewMode == MXPickerViewModeDD ?: [_modelsM addObject:modelsM.mutableCopy];
            break;
        }
        case MXPickerViewModeYYYY:
        case MXPickerViewModeYYYY_YYYY:
        case MXPickerViewModeYYYY_MM:
        case MXPickerViewModeYYYYMM_YYYYMM:
        case MXPickerViewModeYYYYMMDD_YYYYMMDD: {
            NSCalendar *calendar = [NSCalendar currentCalendar];
            //[calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
            NSDateComponents *minComponents = !_minimumDate ? nil : [calendar components:NSCalendarUnitYear fromDate:_minimumDate], *maxComponents = !_maximumDate ? nil : [calendar components:NSCalendarUnitYear fromDate:_maximumDate];
            NSInteger min = minComponents.year, max = maxComponents.year;
            NSMutableArray<MXPickerModel *> *yyyyModelsM = @[].mutableCopy, *mmModelsM = @[].mutableCopy, *ddModelsM = @[].mutableCopy;
            //YYYY
            for (NSInteger i = min; i <= max; i++) {
                [yyyyModelsM addObject:[MXPickerModel modelWithTitle:[NSString stringWithFormat:@"%ld%@", i, _yearLocale]]];
            }
            if (_showsDescending) yyyyModelsM = (id)yyyyModelsM.reverseObjectEnumerator.allObjects;
            //MM
            for (NSInteger i = 1; i <= 12; i++)
                [mmModelsM addObject:[MXPickerModel modelWithTitle:[NSString stringWithFormat:@"%ld%@", i, _monthLocale]]];
            if (_showsDescending) mmModelsM = (id)mmModelsM.reverseObjectEnumerator.allObjects;
            //DD
            for (NSInteger i = 1; i <= 31; i++)
                [ddModelsM addObject:[MXPickerModel modelWithTitle:[NSString stringWithFormat:@"%ld%@", i, _dayLocale]]];
            if (_showsDescending) ddModelsM = (id)ddModelsM.reverseObjectEnumerator.allObjects;
            if (pickerViewMode == MXPickerViewModeYYYY || pickerViewMode == MXPickerViewModeYYYY_YYYY) {
                [_modelsM addObject:yyyyModelsM];
                pickerViewMode == MXPickerViewModeYYYY ?: [_modelsM addObject:yyyyModelsM.mutableCopy];
            } else if (pickerViewMode == MXPickerViewModeYYYYMM_YYYYMM || pickerViewMode == MXPickerViewModeYYYY_MM) {
                [_modelsM addObject:yyyyModelsM];
                [_modelsM addObject:mmModelsM];
                if (pickerViewMode == MXPickerViewModeYYYYMM_YYYYMM) {
                    [_modelsM addObject:yyyyModelsM.mutableCopy];
                    [_modelsM addObject:mmModelsM.mutableCopy];
                }
            } else if (pickerViewMode == MXPickerViewModeYYYYMMDD_YYYYMMDD) {
                [_modelsM addObject:yyyyModelsM];
                [_modelsM addObject:mmModelsM];
                [_modelsM addObject:ddModelsM];
                [_modelsM addObject:yyyyModelsM.mutableCopy];
                [_modelsM addObject:mmModelsM.mutableCopy];
                [_modelsM addObject:ddModelsM.mutableCopy];
            }
            break;
        }
        case MXPickerViewModeDate: {
            _isClassUIDatePicker = YES;
            datePickerMode = UIDatePickerModeDate;
            break;
        }
        case MXPickerViewModeTime: {
            _isClassUIDatePicker = YES;
            datePickerMode = UIDatePickerModeTime;
            break;
        }
        case MXPickerViewModeDateAndTime: {
            _isClassUIDatePicker = YES;
            datePickerMode = UIDatePickerModeDateAndTime;
            break;
        }
        case MXPickerViewModeCountDownTimer: {
            _isClassUIDatePicker = YES;
            datePickerMode = UIDatePickerModeCountDownTimer;
            break;
        }
        default:
            break;
    }
    CGFloat y = _toolBarPositionBottom ? 0 : CGRectGetMaxY(_toolBar.frame), h = self.bounds.size.height - _toolBarH, topTipBarH = self.topTipBarH;
    if (topTipBarH) {
        y += topTipBarH;
        h -= y;
        [self addTopTipBarIfNeeded];
    }
    if (_isClassUIDatePicker) {
        UIDatePicker *datePicker = _uiDatePickerOrUIPickerView = [UIDatePicker new];
        datePicker.frame = CGRectMake(0, y, self.bounds.size.width, h);
        datePicker.datePickerMode = datePickerMode;
        [datePicker setTimeZone:[NSTimeZone defaultTimeZone]];
        [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        [datePicker addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:datePicker];
        !updateBlock ?: updateBlock(self, _pickerViewMode, datePicker);
        datePicker.minimumDate ?: [datePicker setMinimumDate:_minimumDate];
        datePicker.maximumDate ?: [datePicker setMaximumDate:_maximumDate];
    } else {
        UIPickerView *pickerView = _uiDatePickerOrUIPickerView = UIPickerView.new;
        pickerView.dataSource = self;
        pickerView.delegate = self;
        pickerView.frame = CGRectMake(0, y, self.bounds.size.width, h);
        [self addSubview:pickerView];
        !updateBlock ?: updateBlock(self, _pickerViewMode, pickerView);
        if (pickerViewMode == MXPickerViewModeCustom) {
            [_selectedTitleOrCustomModels enumerateObjectsUsingBlock:^(id customModel, NSUInteger idx, BOOL *stop) {
                NSUInteger scrollIdx = [self.modelsM[idx] indexOfObject:customModel];
                NSAssert(scrollIdx != NSNotFound, @"%@ does not exist in %@", customModel, self.modelsM);
                [pickerView selectRow:scrollIdx inComponent:idx animated:YES];
            }];
        } else {
            _selectedTitleOrCustomModels = [_selectedTitleOrCustomModels componentsSeparatedByString:@" "];
            [_selectedTitleOrCustomModels enumerateObjectsUsingBlock:^(NSString *componentSelectedTitle, NSUInteger idx, BOOL *stop) {
                NSUInteger scrollIdx = [self.modelsM[idx] indexOfObjectPassingTest:^BOOL(MXPickerModel *model, NSUInteger idx, BOOL *stop) {
                    return [model.title isEqualToString:componentSelectedTitle];
                }];
                NSAssert(scrollIdx != NSNotFound, @"%@ does not exist in %@", componentSelectedTitle, self.modelsM);
                [pickerView selectRow:scrollIdx inComponent:idx animated:YES];
            }];
        }
    }
    return self;
}

#pragma mark - add UI
- (void)addCustomView {
    //toolBar.items
    UIBarButtonItem *cancelBarBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelBarButtonItemClicked:)];
    UIBarButtonItem *flexibleBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBarBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(doneBarButtonItemClicked:)];
    UIToolbar *toolBar = UIToolbar.new;
    toolBar.backgroundColor = [UIColor whiteColor];
    [toolBar setShadowImage:UIImage.new forToolbarPosition:UIBarPositionAny];
    if (!_toolBarPositionBottom) {
        cancelBarBtnItem.width = 60;
        doneBarBtnItem.width = 60;
        toolBar.frame = CGRectMake(0, 0, self.bounds.size.width, _toolBarH);
        toolBar.items = @[cancelBarBtnItem, flexibleBarItem, doneBarBtnItem];
    } else {
        cancelBarBtnItem.width = self.bounds.size.width/2.0f;
        doneBarBtnItem.width = self.bounds.size.width/2.0f;
        toolBar.frame = CGRectMake(0, self.bounds.size.height - _toolBarH, self.bounds.size.width, _toolBarH);
        toolBar.items = @[cancelBarBtnItem, doneBarBtnItem];
    }
    [self addSubview:_toolBar = toolBar];
    [@[@(UIControlStateNormal), @(UIControlStateHighlighted)] enumerateObjectsUsingBlock:^(NSNumber *state, NSUInteger idx, BOOL *stop) {
        if (@available(iOS 9.0, *)) {
            [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[MXPickerView.class]] setTitleTextAttributes:self.barBtnItemTitleTextAttributes forState:state.integerValue];
        } else {
            [[UIBarButtonItem appearanceWhenContainedIn:MXPickerView.class, nil] setTitleTextAttributes:self.barBtnItemTitleTextAttributes forState:state.integerValue];
        }
    }];
}

- (void)addTopTipBarIfNeeded {
    if (!self.topTipBarTitles.count) return;
    NSMutableArray<UIBarButtonItem *> *barBtnItems = @[].mutableCopy;
    [self.topTipBarTitles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
        UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:nil action:nil];
        barBtnItem.width = self.bounds.size.width/self.topTipBarTitles.count;
        [barBtnItems addObject:barBtnItem];
    }];
    //toolBar.items
    UIToolbar *topTipBar = UIToolbar.new;
    topTipBar.userInteractionEnabled = NO;
    topTipBar.backgroundColor = [UIColor whiteColor];
    topTipBar.frame = CGRectMake(0, 0, self.bounds.size.width, self.topTipBarH);
    topTipBar.items = barBtnItems;
    [topTipBar setShadowImage:UIImage.new forToolbarPosition:UIBarPositionAny];
    [self addSubview:topTipBar];
    [@[@(UIControlStateNormal), @(UIControlStateHighlighted)] enumerateObjectsUsingBlock:^(NSNumber *state, NSUInteger idx, BOOL *stop) {
        if (@available(iOS 9.0, *)) {
            [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[MXPickerView.class]] setTitleTextAttributes:self.barBtnItemTitleTextAttributes forState:state.integerValue];
            [[UILabel appearanceWhenContainedInInstancesOfClasses:@[MXPickerView.class]] setBackgroundColor:[UIColor redColor]];
        } else {
            [[UIBarButtonItem appearanceWhenContainedIn:MXPickerView.class, nil] setTitleTextAttributes:self.barBtnItemTitleTextAttributes forState:state.integerValue];
        }
    }];
}

- (void)addMaskView {
    UIView *maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    maskView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureInvoked:)];
    [maskView addGestureRecognizer:singleTap];
    [[UIApplication sharedApplication].keyWindow addSubview:maskView];
    _maskView = maskView;
}

#pragma mark - private methods
- (void)calculateDateIfNeeded {
    switch (_pickerViewMode) {
        case MXPickerViewModeCustom:
            NSAssert(!_selectedTitleOrCustomModels || [_selectedTitleOrCustomModels isKindOfClass:NSArray.class], @"when mode is MXPickerViewModeCustom, `selectedTitleOrCustomModels` should pass `customModels`, type of NSArray");
            break;
        case MXPickerViewModeDD:
        case MXPickerViewModeDD_DD:
        case MXPickerViewModeMM:
        case MXPickerViewModeMM_MM:
        case MXPickerViewModeMM_DD:
        case MXPickerViewModeMMDD_MMDD:
        case MXPickerViewModeYYYY:
        case MXPickerViewModeYYYY_YYYY:
        case MXPickerViewModeYYYY_MM:
        case MXPickerViewModeYYYYMM_YYYYMM:
        case MXPickerViewModeYYYYMMDD_YYYYMMDD:
            NSAssert(!_selectedTitleOrCustomModels || ([_selectedTitleOrCustomModels isKindOfClass:NSString.class] && [_selectedTitleOrCustomModels componentsSeparatedByString:@" "]), @"when mode is for date such as `MXPickerViewModeDD`..., `selectedTitleOrCustomModels` should pass `selectedTitle`, type of NSString, joined by whitespace, format something like `12 12`");
            break;
        case MXPickerViewModeTime:
        case MXPickerViewModeDate:
        case MXPickerViewModeDateAndTime:
        case MXPickerViewModeCountDownTimer:
            // when mode for `UIDatePicker`, such as `MXPickerViewModeDateAndTime`, `selectedTitleOrCustomModels` should not pass, always be nil!
            _selectedTitleOrCustomModels = nil;
            break;
    }
    if (_minimumDate && _maximumDate) {
        _deltaBetweenMaxAndMin = 0;
        return;
    } else {
        NSCalendar *currentCalendar = [NSCalendar currentCalendar];
        switch (_pickerViewMode) {
            case MXPickerViewModeMM:
            case MXPickerViewModeMM_MM:
            case MXPickerViewModeMM_DD:
            case MXPickerViewModeMMDD_MMDD: {
                _deltaBetweenMaxAndMin %= 12;
                _deltaBetweenMaxAndMin = _deltaBetweenMaxAndMin ?: 12;
                if (_minimumDate) {
                    NSDateComponents *components = [currentCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:_minimumDate];
                    components.month += _deltaBetweenMaxAndMin;
                    if (components.month > 12) {
                        if (_deltaBetweenMaxAndMin == 12) {
                            components.month += _deltaBetweenMaxAndMin - 1;
                        }
                        components.month %= 12;
                    }
                    _maximumDate = [currentCalendar dateFromComponents:components];
                } else if (_maximumDate) {
                    NSDateComponents *components = [currentCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:_maximumDate];
                    components.month -= _deltaBetweenMaxAndMin;
                    if (components.month <= 0) {
                        if (_deltaBetweenMaxAndMin == 12) {
                            components.month -= _deltaBetweenMaxAndMin - 1;
                        }
                        components.month %= 12;
                        components.month += 12;
                    }
                    _minimumDate = [currentCalendar dateFromComponents:components];
                } else if (!_minimumDate && !_maximumDate) {
                    NSDateComponents *components = [currentCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:NSDate.date];
                    components.month = 1;
                    _minimumDate = [currentCalendar dateFromComponents:components];
                    components.month = 12;
                    _maximumDate = [currentCalendar dateFromComponents:components];
                }
                break;
            }
            case MXPickerViewModeDD:
            case MXPickerViewModeDD_DD: {
                NSInteger numberOfDays = [self numberOfDaysInTheMonthOfDate:_maximumDate ?: (_minimumDate ?: NSDate.date)];
                _deltaBetweenMaxAndMin %= numberOfDays;
                _deltaBetweenMaxAndMin = _deltaBetweenMaxAndMin ?: numberOfDays;
                if (_minimumDate) {
                    NSDateComponents *components = [currentCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:_minimumDate];
                    components.day += _deltaBetweenMaxAndMin;
                    if (components.day > numberOfDays) {
                        if (_deltaBetweenMaxAndMin == numberOfDays) {
                            components.day += _deltaBetweenMaxAndMin - 1;
                        }
                        components.day %= numberOfDays;
                    }
                    _maximumDate = [currentCalendar dateFromComponents:components];
                } else if (_maximumDate) {
                    NSDateComponents *components = [currentCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:_maximumDate];
                    components.day -= _deltaBetweenMaxAndMin;
                    if (components.day <= 0) {
                        if (_deltaBetweenMaxAndMin == numberOfDays) {
                            components.day -= _deltaBetweenMaxAndMin - 1;
                        }
                        components.day %= numberOfDays;
                        components.day += numberOfDays;
                    }
                    _minimumDate = [currentCalendar dateFromComponents:components];
                } else if (!_minimumDate && !_maximumDate) {
                    NSDateComponents *components = [currentCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:NSDate.date];
                    components.day = 1;
                    _minimumDate = [currentCalendar dateFromComponents:components];
                    components.day = numberOfDays;
                    _maximumDate = [currentCalendar dateFromComponents:components];
                }
                break;
            }
            case MXPickerViewModeYYYY:
            case MXPickerViewModeYYYY_YYYY:
            case MXPickerViewModeYYYY_MM:
            case MXPickerViewModeYYYYMM_YYYYMM:
            case MXPickerViewModeYYYYMMDD_YYYYMMDD: {
                _deltaBetweenMaxAndMin = _deltaBetweenMaxAndMin ?: 100;
                if (_minimumDate) {
                    NSDateComponents *components = [currentCalendar components:NSCalendarUnitYear fromDate:_minimumDate];
                    components.year += _deltaBetweenMaxAndMin;
                    _maximumDate = [currentCalendar dateFromComponents:components];
                } else if (_maximumDate) {
                    NSDateComponents *components = [currentCalendar components:NSCalendarUnitYear fromDate:_maximumDate];
                    components.year -= _deltaBetweenMaxAndMin;
                    _minimumDate = [currentCalendar dateFromComponents:components];
                } else if (!_minimumDate && !_maximumDate) {
                    NSDateComponents *components = [currentCalendar components:NSCalendarUnitYear fromDate:NSDate.date];
                    _maximumDate = [currentCalendar dateFromComponents:components];
                    components.year -= _deltaBetweenMaxAndMin;
                    _minimumDate = [currentCalendar dateFromComponents:components];
                }
                break;
            }
            default:
                break;
        }
    }
}

- (void)animationForShow:(BOOL)shouldShow {
    [self translateAnimationForShow:shouldShow];
    [self alphaAnimatonForShow:shouldShow];
}

- (void)translateAnimationForShow:(BOOL)shouldShow {
    [self.layer addAnimation:shouldShow ? [MXAnimation upFromKeyWindowAnimationWithDuration:0 addToView:self updateBlock:nil] : [MXAnimation downToKeyWindowAnimationWithDuration:0.2 addToView:self updateBlock:nil] forKey:nil];
}

- (void)alphaAnimatonForShow:(BOOL)shouldShow {
    [_maskView.layer addAnimation:shouldShow ? [MXAnimation showAlphaAnimationWithDuration:0 updateBlock:nil] : [MXAnimation hideAlphaAnimationWithDuration:0 updateBlock:^(CAKeyframeAnimation *animation) {
        animation.animationDidStopBlock = ^(CAAnimation *anim, BOOL finished) {
            [self removeFromSuperview];
            [self->_maskView removeFromSuperview];
            self->_maskView = nil;
        };
    }] forKey:nil];
}

- (NSUInteger)numberOfDaysInTheMonthOfDate:(NSDate *)date {
    NSRange range = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

#pragma mark - public
+ (instancetype)showWithSize:(CGSize)size pickerViewMode:(MXPickerViewMode)pickerViewMode updateBlock:(void (^)(MXPickerView *pickerView, MXPickerViewMode pickerViewMode, id uiDatePickerOrUIPickerView))updateBlock {
    MXPickerView *pickerView = [[MXPickerView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height) pickerViewMode:pickerViewMode updateBlock:updateBlock];
    [pickerView animationForShow:YES];
    return pickerView;
}

#pragma mark - override
- (BOOL)respondsToSelector:(SEL)aSelector {
    NSString *aSelectorStr = NSStringFromSelector(aSelector);
    if ([aSelectorStr isEqualToString:NSStringFromSelector(@selector(pickerView:attributedTitleForRow:forComponent:))]) {
        return (BOOL)self.configPickerViewAttributedTitleForRowForComponentBlock;
    } else {
        return [super respondsToSelector:aSelector];
    }
}

#pragma mark - getter
- (CGFloat)topTipBarH {
    return self.topTipBarTitles.count ? _topTipBarH : 0;
}

- (NSArray<NSString *> *)topTipBarTitles {
    if (_topTipBarTitles.count) return _topTipBarTitles;
    return _topTipBarTitles = nil;
}

- (NSDictionary<NSAttributedStringKey,id> *)barBtnItemTitleTextAttributes {
    if (_barBtnItemTitleTextAttributes.count) return _barBtnItemTitleTextAttributes;
    return @{NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: MXPV_RGB_FROM_HEX(333333)};
}

- (CGFloat)componentWidth {
    if (_componentWidth) return _componentWidth;
    UIPickerView *pickerView = (id)_uiDatePickerOrUIPickerView;
    NSInteger numberOfComponents = [self numberOfComponentsInPickerView:pickerView];
    return _componentWidth = (pickerView.bounds.size.width - (numberOfComponents - 1) * 5)/numberOfComponents;
}

- (CGFloat)componentRowHeight {
    if (_componentRowHeight) return _componentRowHeight;
    return _componentRowHeight = 40;
}

#pragma mark - setter
- (void)setToolBarPositionBottom:(BOOL)toolBarPositionBottom {
    if (_topTipBarTitles.count) {
        _toolBarPositionBottom = YES;
        return;
    }
    _toolBarPositionBottom = toolBarPositionBottom;
}

- (void)setTopTipBarTitles:(NSArray<NSString *> *)topTipBarTitles {
    if (!topTipBarTitles.count) {
        _topTipBarTitles = nil;
        _topTipBarH = 0;
        return;
    }
    if ([_topTipBarTitles isEqualToArray:topTipBarTitles]) {
        return;
    }
    _topTipBarTitles = topTipBarTitles.copy;
    self.toolBarPositionBottom = YES;
}

#pragma mark - button actions
- (void)cancelBarButtonItemClicked:(UIBarButtonItem *)barButtonItem {
    [self animationForShow:NO];
}

- (void)doneBarButtonItemClicked:(UIBarButtonItem *)barButtonItem {
    [self animationForShow:NO];
    if (_isClassUIDatePicker) {
        UIDatePicker *datePicker = (id)_uiDatePickerOrUIPickerView;
        CGFloat countDownDuration = datePicker.datePickerMode != UIDatePickerModeCountDownTimer ? 0 : datePicker.countDownDuration;
        NSDate *date = datePicker.datePickerMode != UIDatePickerModeCountDownTimer ? datePicker.date : nil;
        !_doneButtonDidClickBlock ?: _doneButtonDidClickBlock(_pickerViewMode, countDownDuration, date, nil);
    } else {
        if (_pickerViewMode == MXPickerViewModeCustom) {
            UIPickerView *pickerView = (id)_uiDatePickerOrUIPickerView;
            NSMutableArray *arrM = @[].mutableCopy;
            for (NSInteger i = 0, count = pickerView.numberOfComponents; i < count; i++) {
                id curModel = _modelsM[i][[pickerView selectedRowInComponent:i]];
                [arrM addObject:curModel];
            }
            !_doneButtonDidClickBlock ?: _doneButtonDidClickBlock(_pickerViewMode, 0, nil, arrM);
        } else {
            UIPickerView *pickerView = (id)_uiDatePickerOrUIPickerView;
            NSMutableString *strM = @"".mutableCopy;
            for (NSInteger i = 0, count = pickerView.numberOfComponents; i < count; i++) {
                NSString *curTitle = [_modelsM[i][[pickerView selectedRowInComponent:i]] title];
                if (i == count - 1) {
                    [strM appendFormat:@"%@", curTitle];
                } else {
                    [strM appendFormat:@"%@ ", curTitle];
                }
            }
            !_doneButtonDidClickBlock ?: _doneButtonDidClickBlock(_pickerViewMode, 0, nil, strM);
        }
    }
}

#pragma mark - control actions
- (void)valueChanged:(UIDatePicker *)datePicker {
    //NSLog(@"%@", datePicker.date);
    CGFloat countDownDuration = datePicker.datePickerMode != UIDatePickerModeCountDownTimer ? 0 : datePicker.countDownDuration;
    NSDate *date = datePicker.datePickerMode != UIDatePickerModeCountDownTimer ? datePicker.date : nil;
    !_datePickerDidChangeBlock ?: _datePickerDidChangeBlock(_pickerViewMode, countDownDuration, date, nil);
}

#pragma mark - gesture actions
- (void)singleTapGestureInvoked:(UITapGestureRecognizer *)recognizer {
    [self animationForShow:NO];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return _modelsM.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_modelsM[component] count];
}

#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return !_configPickerViewWidthForComponentBlock ? self.componentWidth : _configPickerViewWidthForComponentBlock(self, pickerView, component);
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return !_configPickerViewRowHeightForComponentBlock ? self.componentRowHeight : _configPickerViewRowHeightForComponentBlock(self, pickerView, component);
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (_pickerViewMode == MXPickerViewModeYYYYMMDD_YYYYMMDD) {
        NSInteger dayCompnent = 0;
        if (component == 0 || component == 1 || component == 3 || component == 4) {
            NSString *year = nil, *month = nil;
            if (component == 1 || component == 4) {
                //curr component is month
                dayCompnent = component + 1;
                year = [_modelsM[component - 1][[pickerView selectedRowInComponent:component - 1]] title];
                month = [_modelsM[component][row] title];
            } else {
                //curr component is year
                dayCompnent = component + 2;
                year = [_modelsM[component][row] title];
                month = [_modelsM[component + 1][[pickerView selectedRowInComponent:component + 1]] title];
            }
            NSDateFormatter *fmt = NSDateFormatter.new;
            fmt.dateFormat = [NSString stringWithFormat:@"yyyy%@MM%@", _yearLocale, _monthLocale];
            NSDate *date = [fmt dateFromString:[NSString stringWithFormat:@"%@%02ld", year, month.integerValue]];
            if (!date) return;
            NSInteger numberOfDays = [self numberOfDaysInTheMonthOfDate:date];
            //DD
            NSMutableArray<MXPickerModel *> *ddModelsM = @[].mutableCopy;
            for (NSInteger i = 1; i <= numberOfDays; i++)
                [ddModelsM addObject:[MXPickerModel modelWithTitle:[NSString stringWithFormat:@"%ld%@", i, _dayLocale]]];
            if (_showsDescending) ddModelsM = (id)ddModelsM.reverseObjectEnumerator.allObjects;
            [_modelsM[dayCompnent] removeAllObjects];
            _modelsM[dayCompnent] = ddModelsM;
            [pickerView reloadComponent:dayCompnent];
        }
    } else if (_pickerViewMode == MXPickerViewModeMMDD_MMDD || _pickerViewMode == MXPickerViewModeMM_DD) {
        if (component == 0 || component == 2) {
            NSInteger dayCompnent = component + 1;
            NSString *year = [NSString stringWithFormat:@"%ld", [NSCalendar.currentCalendar components:NSCalendarUnitYear fromDate:NSDate.date].year], *month = [_modelsM[component][row] title];
            //curr component is month
            NSDateFormatter *fmt = NSDateFormatter.new;
            fmt.dateFormat = [NSString stringWithFormat:@"yyyy%@MM%@", _yearLocale, _monthLocale];
            NSDate *date = [fmt dateFromString:[NSString stringWithFormat:@"%@%@%ld%@", year, _yearLocale, month.integerValue, _monthLocale]];
            if (!date) return;
            NSInteger numberOfDays = [self numberOfDaysInTheMonthOfDate:date];
            //DD
            NSMutableArray<MXPickerModel *> *ddModelsM = @[].mutableCopy;
            for (NSInteger i = 1; i <= numberOfDays; i++)
                [ddModelsM addObject:[MXPickerModel modelWithTitle:[NSString stringWithFormat:@"%ld%@", i, _dayLocale]]];
            if (_showsDescending) ddModelsM = (id)ddModelsM.reverseObjectEnumerator.allObjects;
            [_modelsM[dayCompnent] removeAllObjects];
            _modelsM[dayCompnent] = ddModelsM;
            [pickerView reloadComponent:dayCompnent];
        }
    }
    !_datePickerDidChangeBlock ?: _datePickerDidChangeBlock(_pickerViewMode, 0, 0, [_modelsM[component][row] title]);
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UIView *reusingView = nil;
    if (_configPickerViewViewForRowForComponentBlock) {
        return _configPickerViewViewForRowForComponentBlock(self, pickerView, row, component, view);
    } else {
        if (!reusingView) {
            UILabel *reusingLabel = UILabel.new;
            reusingLabel.textAlignment = NSTextAlignmentCenter;
            reusingLabel.font = [UIFont systemFontOfSize:17];
            reusingView = reusingLabel;
        }
        if (_configPickerViewAttributedTitleForRowForComponentBlock) {
            NSAttributedString *attrTitle = _configPickerViewAttributedTitleForRowForComponentBlock(self, pickerView, row, component);
            ((UILabel *)reusingView).attributedText = ![attrTitle isKindOfClass:NSAttributedString.class] ? nil : attrTitle;
        } else if (_configPickerViewTitleForRowForComponentBlock) {
            NSString *title = !_configPickerViewTitleForRowForComponentBlock ? nil : _configPickerViewTitleForRowForComponentBlock(self, pickerView, row, component);
            ((UILabel *)reusingView).text = ![title isKindOfClass:NSString.class] ? nil : title;
        } else {
            MXPickerModel *model = _modelsM[component][row];
            ((UILabel *)reusingView).text = ![model isKindOfClass:MXPickerModel.class] ? nil : model.title;
        }
        !_configPickerViewContentLabelAppearanceForRowForComponentBlock ?: _configPickerViewContentLabelAppearanceForRowForComponentBlock(self, pickerView, (id)reusingView, row, component);
    }
    return reusingView;
}

@end
