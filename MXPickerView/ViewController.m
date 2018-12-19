//
//  ViewController.m
//  MXPickerView
//
//  Created by Michael on 2018/10/30.
//  Copyright © 2018 Michael. All rights reserved.
//

#import "ViewController.h"
#import "MXPickerView.h"

@interface ViewController ()

@property (nonatomic) NSMutableDictionary<NSNumber *, id> *selectedTitleOrCustomModelsDictM;// 记录每种mode的上一个`selectedTitleOrCustomModels`

@end

@implementation ViewController

- (void)viewDidLoad {
    _selectedTitleOrCustomModelsDictM = @{}.mutableCopy;
}

#pragma mark - button actions
- (IBAction)button:(UIButton *)sender {
    MXPickerViewMode mode = [self.view.subviews indexOfObject:sender];
    switch (mode) {
        case MXPickerViewModeCustom:
            [self showPickerViewForModeCustom];
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
            [self showPickerViewForModeDate:mode];
            break;
        case MXPickerViewModeTime:
        case MXPickerViewModeDate:
        case MXPickerViewModeDateAndTime:
        case MXPickerViewModeCountDownTimer:
            [self showPickerViewForModeTime:mode];
            break;
        default:
            break;
    }
}

#pragma mark - private
- (void)showPickerViewForModeCustom {
    [MXPickerView showWithSize:CGSizeMake(self.view.bounds.size.width, 200) pickerViewMode:MXPickerViewModeCustom updateBlock:^(MXPickerView *pickerView, MXPickerViewMode pickerViewMode, id uiDatePickerOrUIPickerView) {
        // 设置`contentlLabel`文字
        pickerView.modelsM = (id)@[@[@"0-0", @"0-1", @"0-2", @"0-3"], @[@"1-0", @"1-1", @"1-2", @"1-3"], @[@"2-0", @"2-1", @"2-2", @"2-3"]];
        //pickerView.selectedTitleOrCustomModels = @[@"0-1", @"1-2", @"2-3"];
        pickerView.selectedTitleOrCustomModels = (NSArray *)self.selectedTitleOrCustomModelsDictM[@(pickerViewMode)];
        pickerView.configPickerViewTitleForRowForComponentBlock = ^NSString *(MXPickerView *mxPickerView, UIPickerView *pickerView, NSInteger row, NSInteger component) {
            return [NSString stringWithFormat:@"%@", mxPickerView.modelsM[component][row]];
        };
        //pickerView.barBtnItemTitleTextAttributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:14], NSForegroundColorAttributeName: [UIColor redColor]};
        pickerView.doneButtonDidClickBlock = ^(MXPickerViewMode pickerViewMode, CGFloat countDownDuration, NSDate *date, id selectedTitleOrCustomModels) {
            NSLog(@"selectedTitleOrCustomModels: %@", selectedTitleOrCustomModels);
            self.selectedTitleOrCustomModelsDictM[@(pickerViewMode)] = (NSArray *)selectedTitleOrCustomModels;
        };
        /*// 设置`contentlLabel`属性字符串，打开注释
         pickerView.configPickerViewAttributedTitleForRowForComponentBlock = ^NSAttributedString *(MXPickerView *mxPickerView, UIPickerView *pickerView, NSInteger row, NSInteger component) {
            return [[NSAttributedString alloc] initWithString:@"attributed title" attributes:@{NSForegroundColorAttributeName:[UIColor purpleColor]}];
        };*/
        /*// 需要为不同`component`返回不一样列高时，打开注释
         pickerView.configPickerViewWidthForComponentBlock = ^CGFloat(MXPickerView *mxPickerView, UIPickerView *pickerView, NSInteger component) {
             return (component == 0 || component == 3) ? 70 : (self.view.bounds.size.width - 2 * 80)/4;
         };*/
        /*// 为每个`component`设置不同的行高, 相同的可以直接设置`pickerView.componentRowHeight = xx`
         pickerView.configPickerViewRowHeightForComponentBlock = ^CGFloat(MXPickerView *mxPickerView, UIPickerView *pickerView, NSInteger component) {
             return 100;
         };*/
        //pickerView.componentRowHeight = 100; //默认每一列`component`行高都为40,当所有的`component`行高相等时，可统一设置, 相当于`tableView.rowHeight`
        //pickerView.toolBarPositionBottom = YES; //默认为`NO`,`返回`和`确定`按钮显示在顶部，当设为`YES`,`返回`和`确定`按钮显示在底部
        //pickerView.topTipBarTitles = @[@"开始日期", @"结束日期"]; //不为`nil`时,`toolBarPositionBottom`会自动设置为`YES`，底部显示`返回`和`确定`按钮，顶部显示`开始日期 - 结束日期`
        //pickerView.topTipBarH = 50; //`topTipBarTitles`一栏高度，默认是44
        //pickerView.toolBarH = 30; //`返回`和`确定`按钮一栏高度，默认是44
        //pickerView.backgroundColor = [UIColor lightGrayColor];
        /*//自定义在`component`中的`contentView`
         pickerView.configPickerViewViewForRowForComponentBlock = ^UIView *(MXPickerView *mxPickerView, UIPickerView *pickerView, NSInteger row, NSInteger component, UIView *reusingView) {
             return [UIButton buttonWithType:UIButtonTypeContactAdd];
        };*/
        // 想设置`contentLabel`的各个属性，实现`appearance block`
        pickerView.configPickerViewContentLabelAppearanceForRowForComponentBlock = ^(MXPickerView *mxPickerView, UIPickerView *pickerView, UILabel *contentLabel, NSInteger row, NSInteger component) {
            contentLabel.backgroundColor = [UIColor yellowColor];
            contentLabel.textAlignment = NSTextAlignmentRight;
         };
        /*pickerView.datePickerDidChangeBlock = ^(MXPickerViewMode pickerViewMode, CGFloat countDownDuration, NSDate *date, NSString *selectedTitle) {
            NSLog(@"pickerViewMode\n: %ld, countDownDuration\n: %f, date\n: %@, selectedTitle\n: %@", pickerViewMode, countDownDuration, date, selectedTitle);
        };*/
    }];
}

- (void)showPickerViewForModeDate:(MXPickerViewMode)mode {
    [MXPickerView showWithSize:CGSizeMake(self.view.bounds.size.width, 200) pickerViewMode:mode updateBlock:^(MXPickerView *pickerView, MXPickerViewMode pickerViewMode, id uiDatePickerOrUIPickerView) {
        switch (mode) {
            case MXPickerViewModeDD:
            case MXPickerViewModeDD_DD: {
                //创建从（今天 - 今天 + 10天），如（1号 - 10号）的列表，方式1和方式2结果一样
                //方式1，设置中间的时间间隔，超过当月的`最大天数`,代码内部会取余`deltaBetweenMaxAndMin%最大天数`，推荐方式一，方式二需要算日期，麻烦
                pickerView.minimumDate = [NSDate date];
                pickerView.deltaBetweenMaxAndMin = 10;
                /*
                 //方式2, 设置`最小日期`和`最大日期`，超过当月的`最大天数`,代码内部会取余`deltaBetweenMaxAndMin%最大天数`
                 pickerView.minimumDate = [NSDate date];
                 pickerView.maximumDate = [NSDate dateWithTimeInterval:10 * 24 * 60 * 60 sinceDate:pickerView.minimumDate];
                 */
                //方式3，什么都不写，全部使用默认值，1号 - 当月最大天数，`pickerView.deltaBetweenMaxAndMin = 当月最大天数`;//会根据当前模式设置默认值,`MXPickerViewModeDD_DD`会自动算当月最大几号，以及闰年
                //
                break;
            }
            case MXPickerViewModeMM:
            case MXPickerViewModeMM_MM: {
                //创建从（今月 - 今月 + 10月），如（1月 - 10月）的列表，方式1和方式2结果一样，推荐方式一，方式二需要算日期，麻烦
                //方式1，设置`最小日期`和`中间的时间间隔`，超过12,代码内部会取余`deltaBetweenMaxAndMin%12`
                pickerView.minimumDate = [NSDate date];
                pickerView.deltaBetweenMaxAndMin = 10;
                /*
                 //方式2, 设置`最小日期`和`最大日期`，超过12代码内部会取余`deltaBetweenMaxAndMin%12`
                 pickerView.minimumDate = [NSDate date];
                 pickerView.maximumDate = [NSDate dateWithTimeInterval:10 * 60 * 60 sinceDate:pickerView.minimumDate];
                 */
                //方式3，什么都不写，全部使用默认值 1月 - 12月，`pickerView.deltaBetweenMaxAndMin = 12`;//会根据当前模式设置默认值,`MXPickerViewModeMM_MM`则为12
                break;
            }
            case MXPickerViewModeMM_DD: // 1月1号
            case MXPickerViewModeMMDD_MMDD: {
                //创建从（今月1号 -（今月 + 10）31号）的列表，如（1月1号 - 10月31号），方式1和方式2结果一样，推荐方式一，方式二需要算日期，麻烦
                //方式1，设置中间的时间间隔，超过12,代码内部会取余`deltaBetweenMaxAndMin%12`
                pickerView.minimumDate = [NSDate date];
                pickerView.deltaBetweenMaxAndMin = 10;
                ///*
                 //方式2, 设置`最小日期`和`最大日期`，超过12，代码内部会取余`deltaBetweenMaxAndMin%12`
                //pickerView.minimumDate = [NSDate date];
                //pickerView.maximumDate = [NSDate dateWithTimeInterval:10 * 30 * 24 * 60 * 60 sinceDate:pickerView.minimumDate];
                 //*/
                //方式3，什么都不写，全部使用默认值，1月1号 - 12月31号，`pickerView.deltaBetweenMaxAndMin = 12`;//会根据当前模式为`MXPickerViewModeDD_DD`设置默认值12，会自动算当月最大几号，以及闰年
                break;
            }
            case MXPickerViewModeYYYY:
            case MXPickerViewModeYYYY_YYYY: {
                //创建从（今年 -（今年 + 10）的列表，如（2018年 - 2028年），方式1和方式2结果一样，推荐方式一，方式二需要算日期，麻烦
                //方式1，设置中间的时间间隔，超过12,代码内部会取余`deltaBetweenMaxAndMin%12`
                pickerView.minimumDate = [NSDate date];
                pickerView.deltaBetweenMaxAndMin = 10;
                ///*
                //方式2, 设置最大的日期
                //pickerView.minimumDate = [NSDate date];
                //pickerView.maximumDate = [NSDate dateWithTimeInterval:10 * 12 * 30 * 24 * 60 * 60 sinceDate:pickerView.minimumDate];
                //*/
                //方式3，什么都不写，全部使用默认值，1918年 - 今年，`pickerView.deltaBetweenMaxAndMin = 100`;//会根据当前模式为`MXPickerViewModeYYYY_YYYY`设置默认值100
                break;
            }
            case MXPickerViewModeYYYY_MM: // 2018年1月
            case MXPickerViewModeYYYYMM_YYYYMM: {
                //创建从（今年1月 -（今年 + 10）12月）的列表，如（2018年1月 - 2028年12月），方式1和方式2结果一样，推荐方式一，方式二需要算日期，麻烦
                //方式1，设置中间的时间间隔，超过12,代码内部会取余`deltaBetweenMaxAndMin%12`
                pickerView.minimumDate = [NSDate date];
                pickerView.deltaBetweenMaxAndMin = 10;
                ///*
                //方式2, 设置最大的日期
                //pickerView.minimumDate = [NSDate date];
                //pickerView.maximumDate = [NSDate dateWithTimeInterval:10 * 12 * 30 * 24 * 60 * 60 sinceDate:pickerView.minimumDate];
                //*/
                //方式3，什么都不写，全部使用默认值，1918年1月 - 今年12月，`pickerView.deltaBetweenMaxAndMin = 100`;//会根据当前模式为`MXPickerViewModeYYYY_YYYY`设置默认值100
                break;
            }
            case MXPickerViewModeYYYYMMDD_YYYYMMDD: {
                //pickerView.componentWidth = 70;//6列需要在block中单独设置每一列的宽度，要不然2018显示20..
                //创建从（今年1月1号 -（今年 + 10）12月31号）的列表，如（2018年1月1号 - 2028年12月31号），方式1和方式2结果一样，推荐方式一，方式二需要算日期，麻烦
                //方式1，设置中间的时间间隔，超过12,代码内部会取余`deltaBetweenMaxAndMin%12`
                pickerView.minimumDate = [NSDate date];
                pickerView.deltaBetweenMaxAndMin = 10;
                ///*
                //方式2, 设置最大的日期
                //pickerView.minimumDate = [NSDate date];
                //pickerView.maximumDate = [NSDate dateWithTimeInterval:10 * 12 * 30 * 24 * 60 * 60 sinceDate:pickerView.minimumDate];
                //*/
                //方式3，什么都不写，全部使用默认值，1918年1月1号 - 今年12月31号，`pickerView.deltaBetweenMaxAndMin = 100`;//会根据当前模式为`MXPickerViewModeYYYY_YYYY`设置默认值100
                break;
            }
            default:
                break;
        }
        //pickerView.showsDescending = YES;//默认升序,结果为12, 1, 2, 3... 11, 12，当为降序，12, 11, 10,...4, 3, 2, 1, 12
        
        //pickerView.componentRowHeight = 100; //默认每一列`component`行高都为40,当所有的`component`行高相等时，可统一设置, 相当于`tableView.rowHeight`
        //需要为不同`component`返回不一样行高时，打开注释
        /*pickerView.configPickerViewRowHeightForComponentBlock = ^CGFloat(MXPickerView *mxPickerView, UIPickerView *pickerView, NSInteger component) {
            return 100;
        };*/
        
        //pickerView.componentWidth = 100; //默认每一列`component`列宽都为`pickerView.bounds.size.width/numberOfComponents`,当所有的`component`行高相等时，可统一设置
        //需要为不同`component`返回不一样列宽时，打开注释
        if (mode == MXPickerViewModeYYYYMMDD_YYYYMMDD) {
            pickerView.configPickerViewWidthForComponentBlock = ^CGFloat(MXPickerView *mxPickerView, UIPickerView *pickerView, NSInteger component) {
                return (component == 0 || component == 3) ? 60 : (mxPickerView.bounds.size.width - 2 * 60 - 15)/4;
            };
        }

        //pickerView.toolBarPositionBottom = YES; //默认为`NO`,`返回`和`确定`按钮显示在顶部，当设为`YES`,`返回`和`确定`按钮显示在底部
        //pickerView.topTipBarTitles = @[@"开始日期", @"结束日期"]; //不为`nil`时,`toolBarPositionBottom`会自动设置为`YES`，底部显示`返回`和`确定`按钮，顶部显示`开始日期 - 结束日期`
        //pickerView.topTipBarH = 50; //`topTipBarTitles`一栏高度，默认是44
        //pickerView.toolBarH = 30; //`返回`和`确定`按钮一栏高度，默认是44
        //pickerView.backgroundColor = [UIColor lightGrayColor];
        /*
         // 想设置`contentLabel`的各个属性，实现`appearance block`
         pickerView.configPickerViewContentLabelAppearanceForRowForComponentBlock = ^(MXPickerView *mxPickerView, UIPickerView *pickerView, UILabel *contentLabel, NSInteger row, NSInteger component) {
             contentLabel.backgroundColor = [UIColor yellowColor];
             contentLabel.textAlignment = NSTextAlignmentRight;
         };*/
        pickerView.yearLocale = @"年";
        pickerView.monthLocale = @"月";
        pickerView.dayLocale = @"号";
        pickerView.selectedTitleOrCustomModels = (NSString *)self.selectedTitleOrCustomModelsDictM[@(mode)];;
        pickerView.doneButtonDidClickBlock = ^(MXPickerViewMode pickerViewMode, CGFloat countDownDuration, NSDate *date, id selectedTitleOrCustomModels) {
            NSLog(@"selectedTitleOrCustomModels: %@", selectedTitleOrCustomModels);
            self.selectedTitleOrCustomModelsDictM[@(pickerViewMode)] = (NSString *)selectedTitleOrCustomModels;
        };
    }];
}


- (void)showPickerViewForModeTime:(MXPickerViewMode)mode {
    [MXPickerView showWithSize:CGSizeMake(self.view.bounds.size.width, 200) pickerViewMode:mode updateBlock:^(MXPickerView *pickerView, MXPickerViewMode pickerViewMode, id uiDatePickerOrUIPickerView) {
        UIDatePicker *datePicker = (UIDatePicker *)uiDatePickerOrUIPickerView;
        datePicker.minuteInterval = 1;
        switch (mode) {
            case MXPickerViewModeTime: {
                //前1小时 - 后1小时
                datePicker.date = [NSDate date];
                datePicker.minimumDate = [NSDate dateWithTimeInterval:-1 * 60 * 60 sinceDate:datePicker.date];
                datePicker.maximumDate = [NSDate dateWithTimeInterval:1 * 60 * 60 sinceDate:datePicker.date];
                break;
            }
            case MXPickerViewModeDate:
            case MXPickerViewModeDateAndTime: {
                //前天 - 后天
                datePicker.date = [NSDate date];
                datePicker.minimumDate = [NSDate dateWithTimeInterval:-24 * 60 * 60 sinceDate:datePicker.date];
                datePicker.maximumDate = [NSDate dateWithTimeInterval:24 * 60 * 60 sinceDate:datePicker.date];
                break;
            }
            case MXPickerViewModeCountDownTimer: {
                datePicker.countDownDuration = 60 * 10;//选中为10分钟
                break;
            }
            default:
                break;
        }
        //pickerView.toolBarPositionBottom = YES; //默认为`NO`,`返回`和`确定`按钮显示在顶部，当设为`YES`,`返回`和`确定`按钮显示在底部
        //pickerView.topTipBarTitles = @[@"开始日期", @"结束日期"]; //不为`nil`时,`toolBarPositionBottom`会自动设置为`YES`，底部显示`返回`和`确定`按钮，顶部显示`开始日期 - 结束日期`
        //pickerView.topTipBarH = 50; //`topTipBarTitles`一栏高度，默认是44
        //pickerView.toolBarH = 30; //`返回`和`确定`按钮一栏高度，默认是44
        //pickerView.backgroundColor = [UIColor lightGrayColor];
        pickerView.doneButtonDidClickBlock = ^(MXPickerViewMode pickerViewMode, CGFloat countDownDuration, NSDate *date, id selectedTitleOrCustomModels) {
            NSLog(@"date: %@", date);
        };
    }];
}

@end
