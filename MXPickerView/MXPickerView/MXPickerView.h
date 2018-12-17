//
//  MXPickerView.h
//  1008 - MXPickerView
//
//  Created by Michael on 2018/10/8.
//  Copyright © 2018 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MXPickerViewMode) {
    MXPickerViewModeCustom,
    //mode for `UIPickerView`
    MXPickerViewModeDD, // 29号
    MXPickerViewModeDD_DD, // 29号 - 29号
    MXPickerViewModeMM, // 1月
    MXPickerViewModeMM_MM, // 12月 - 12月
    MXPickerViewModeMM_DD, // 12月 - 29号
    MXPickerViewModeMMDD_MMDD, // 12月 29号 - 12月 29号
    MXPickerViewModeYYYY, // 2018年
    MXPickerViewModeYYYY_YYYY, // 2018年 - 2018年
    MXPickerViewModeYYYY_MM, // 2018年 12月
    MXPickerViewModeYYYYMM_YYYYMM, // 2018年 12月 - 2018年 12月
    MXPickerViewModeYYYYMMDD_YYYYMMDD, // 2018年 12月 29日 - 2018年 12月 29日
    //mode for `UIDatePicker`
    MXPickerViewModeTime,           // Displays hour, minute, and optionally AM/PM designation depending on the locale setting (e.g. 6 | 53 | PM)
    MXPickerViewModeDate,           // Displays month, day, and year depending on the locale setting (e.g. November | 15 | 2007)
    MXPickerViewModeDateAndTime,    // Displays date, hour, minute, and optionally AM/PM designation depending on the locale setting (e.g. Wed Nov 15 | 6 | 53 | PM)
    MXPickerViewModeCountDownTimer, // Displays hour and minute (e.g. 1 | 53)
};

@interface MXPickerView : UIView

/**
 * apperances for `UIBarButtonItem` in `MXPickerView`
 */
@property (nonatomic, copy) NSDictionary<NSAttributedStringKey, id> *barBtnItemTitleTextAttributes;

/**
 * yearLocale e.g., 年
 * monthLocale e.g., 月
 * dayLocale e.g., 日
 */
@property (nonatomic, copy) NSString *yearLocale, *monthLocale, *dayLocale;

/**
 * if `isToolBarPositionBottom` set to YES, toolBarBottom will postion bottom, cancel bar button item and done bar button item position center
 */
@property (nonatomic, getter=isToolBarPositionBottom) BOOL toolBarPositionBottom;
@property (nonatomic, copy) NSArray<NSString *> *topTipBarTitles;
@property (nonatomic, readonly) MXPickerViewMode pickerViewMode;
/**
 * both defalut is `44`
 */
@property (nonatomic) CGFloat topTipBarH, toolBarH;
@property (nonatomic) NSMutableArray *modelsM;

/**
 * default is nil, use for `MXPickerViewModeMM_MM`, `MXPickerViewModeDD_DD`, `MXPickerViewModeMMDD_MMDD`, `MXPickerViewModeYYYY_YYYY`, `MXPickerViewModeYYYYMM_YYYYMM`, `MXPickerViewModeYYYYMMDD_YYYYMMDD`
    e.g., ascending(1, 2, 3, 4, 5), descending(5, 4, 3, 2, 1)
 */
@property (nonatomic, getter=shouldShowDescending) BOOL showsDescending;

@property (nonatomic) NSString *selectedStr;

/**
 * specify min/max date range. default is nil. When min > max, the values are ignored. Ignored in countdown timer mode
 */
@property (nonatomic) NSDate *minimumDate;

/**
 * default is nil
 */
@property (nonatomic) NSDate *maximumDate;

/**
 * `minimumDate` + `deltaBetweenMaxAndMin` = `maximumDate`
 */
@property (nonatomic) NSInteger deltaBetweenMaxAndMin;

/**
 * each component's width height in picker view will set to `componentWidth`
 */
@property (nonatomic) CGFloat componentWidth;

/**
 * each component's row height in picker view will set to `componentRowHeight `
 */
@property (nonatomic) CGFloat componentRowHeight;

/**
 * set component's width with different values
 */
@property (nonatomic, copy) CGFloat (^configPickerViewWidthForComponentBlock)(MXPickerView *mxPickerView, UIPickerView *pickerView, NSInteger component);

/**
 * set component's row height with different values
 */
@property (nonatomic, copy) CGFloat (^configPickerViewRowHeightForComponentBlock)(MXPickerView *mxPickerView, UIPickerView *pickerView, NSInteger component);

/**
 * set content label text
 */
@property (nonatomic, copy) NSString * (^configPickerViewTitleForRowForComponentBlock)(MXPickerView *mxPickerView, UIPickerView *pickerView, NSInteger row, NSInteger component);

/**
 * set content label attributedTitle
 */
@property (nonatomic, copy) NSAttributedString * (^configPickerViewAttributedTitleForRowForComponentBlock)(MXPickerView *mxPickerView, UIPickerView *pickerView, NSInteger row, NSInteger component);

/**
 * set content label appearance such as font, alignment, backgroundColor
 */
@property (nonatomic, copy) void (^configPickerViewContentLabelAppearanceForRowForComponentBlock)(MXPickerView *mxPickerView, UIPickerView *pickerView, UILabel *contentLabel, NSInteger row, NSInteger component);

@property (nonatomic, copy) UIView * (^configPickerViewViewForRowForComponentBlock)(MXPickerView *mxPickerView, UIPickerView *pickerView, NSInteger row, NSInteger component, UIView *reusingView);

//callbacks
@property (nonatomic, copy) void (^datePickerDidChangeBlock)(MXPickerViewMode pickerViewMode, CGFloat countDownDuration, NSDate *date, NSString *selectedTitle);

@property (nonatomic, copy) void (^doneButtonDidClickBlock)(MXPickerViewMode pickerViewMode, CGFloat countDownDuration, NSDate *date, id selectedTitleOrCustomModels);

+ (instancetype)showWithSize:(CGSize)size pickerViewMode:(MXPickerViewMode)pickerViewMode updateBlock:(void (^)(MXPickerView *pickerView, MXPickerViewMode pickerViewMode, id uiDatePickerOrUIPickerView))updateBlock;

@end
