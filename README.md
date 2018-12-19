



# MXPickerView

**MXPickerView** is an encapsulation for **UIPickerView** and **UIDatePicker** 

## ScreenShot

MXPickerViewModeCustom | MXPickerViewModeDD | MXPickerViewModeDD_DD | MXPickerViewModeMM
:---:|:---:| :---:| :---:|
<image src="https://user-images.githubusercontent.com/38175174/50068092-3476cd00-01ff-11e9-9669-a1109d951e23.png" width="250px"> | <image src="https://user-images.githubusercontent.com/38175174/50200836-a5022300-0392-11e9-96a0-9027cb33dfb9.png" width="250px"> | <image src="https://user-images.githubusercontent.com/38175174/50200843-adf2f480-0392-11e9-8af8-cc048476703b.png" width="250px"> | <image src="https://user-images.githubusercontent.com/38175174/50200850-b5b29900-0392-11e9-9aaa-910f441da4a1.png" width="250px">
**MXPickerViewModeMM_MM** | **MXPickerViewModeMM_DD** | **MXPickerViewModeMMDD_MMDD** | **MXPickerViewModeYYYY**
<image src="https://user-images.githubusercontent.com/38175174/50200860-ba774d00-0392-11e9-9c33-eadade1afca8.png" width="250px"> | <image src="https://user-images.githubusercontent.com/38175174/50200867-c06d2e00-0392-11e9-88e8-9808fe0ee6de.png" width="250px"> | <image src="https://user-images.githubusercontent.com/38175174/50200878-c82cd280-0392-11e9-8500-d13167f91c3b.png" width="250px"> | <image src="https://user-images.githubusercontent.com/38175174/50200885-cf53e080-0392-11e9-9e38-02a10993ff2e.png" width="250px">
**MXPickerViewModeYYYY_YYYY** | **MXPickerViewModeYYYY_MM** | **MXPickerViewModeYYYYMM_YYYYMM** | **MXPickerViewModeYYYYMMDD_YYYYMMDD**
<image src="https://user-images.githubusercontent.com/38175174/50200897-d7138500-0392-11e9-8291-c1f0fe2beea9.png" width="250px"> | <image src="https://user-images.githubusercontent.com/38175174/50200903-dd096600-0392-11e9-9010-053d9737b8f6.png" width="250px"> | <image src="https://user-images.githubusercontent.com/38175174/50200916-e266b080-0392-11e9-8c22-0ca507d7ffee.png" width="250px"> | <image src="https://user-images.githubusercontent.com/38175174/50200923-e692ce00-0392-11e9-97e8-b0c3c07e10d6.png" width="250px">
**MXPickerViewModeTime** | **MXPickerViewModeDate** | **MXPickerViewModeDateAndTime** | **MXPickerViewModeCountDownTimer**
<image src="https://user-images.githubusercontent.com/38175174/50201144-dc250400-0393-11e9-8693-02cf0b1f722e.png" width="250px"> | <image src="https://user-images.githubusercontent.com/38175174/50201063-97996880-0393-11e9-9ea2-06c7fe2ac892.png" width="250px"> | <image src="https://user-images.githubusercontent.com/38175174/50201064-97996880-0393-11e9-9f42-3bc893ccdadf.png" width="250px"> | <image src="https://user-images.githubusercontent.com/38175174/50201062-97996880-0393-11e9-88e3-a95256dd6ff6.png" width="250px">





## Attributes

ScreenshotsInDemoxxxxxxxxx | Attribute Name | Example
:---: | :---: | :---: | 
<image src="https://user-images.githubusercontent.com/38175174/50138825-d3242c00-02da-11e9-8d10-187aabda8dfd.gif" width="250px"> | NSDictionary<NSAttributedStringKey, id> *barBtnItemTitleTextAttributes; | pickerView.barBtnItemTitleTextAttributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:14], NSForegroundColorAttributeName: [UIColor redColor]}
<image src="https://user-images.githubusercontent.com/38175174/50142173-63b33a00-02e4-11e9-88bd-cf5ade6c36f9.gif" width="250px"> | NSString *yearLocale, *monthLocale, *dayLocale;  | pickerView.yearLocale = @"年";<br>pickerView.monthLocale = @"月";<br>pickerView.dayLocale = @"号";<br>
<image src="https://user-images.githubusercontent.com/38175174/50142877-1cc64400-02e6-11e9-98c3-dbe74dcf5d47.gif" width="250px"> | <br> BOOL toolBarPositionBottom; <br> <br> //默认为`NO`,`返回`和`确定`按钮显示在顶部，<br> 当设为`YES`,`返回`和`确定`按钮显示在底部 <br> <br> | pickerView.toolBarPositionBottom = YES;
<image src="https://user-images.githubusercontent.com/38175174/50143295-3caa3780-02e7-11e9-948a-a4b5b051182d.gif" width="250px"> | <br> NSArray<NSString *> *topTipBarTitles; <br> <br> //不为`nil`时, `toolBarPositionBottom`<br>会自动设置为`YES`，底部显示`返回`和`确定`按钮，<br>顶部显示`topTipBarTitles`, 如`开始日期 - 结束日期`  <br> <br> | pickerView.topTipBarTitles = @[@"开始日期", @"结束日期"];
<image src="https://user-images.githubusercontent.com/38175174/50143818-8fd0ba00-02e8-11e9-8a18-076d2b2f5c3e.gif" width="250px"> | <br> CGFloat topTipBarH, toolBarH; <br> <br> pickerView.topTipBarH = 50; <br> pickerView.toolBarH = 30; <br>// 底部显示`返回`和`确定`按钮，顶部显示`开始日期 - 结束日期` <br> `topTipBarTitles`一栏高度，默认是44; <br> `返回`和`确定`按钮一栏高度，默认是44  <br> <br> | pickerView.topTipBarTitles = @[@"开始日期", @"结束日期"];
<image src="https://user-images.githubusercontent.com/38175174/50144764-efc86000-02ea-11e9-9009-d68d86db39d8.gif" width="250px"> | <br> BOOL showsDescending; <br> <br> // 默认升序,结果为12, 1, 2, 3... 11, 12，<br> 当为降序，结果为12, 11, 10, ...4, 3, 2, 1, 12, 仅支持`mode`是日期类的，如`MXPickerViewModeDD`... <br> <br> | pickerView.showsDescending = YES;
<image src="https://user-images.githubusercontent.com/38175174/50146414-9cf0a780-02ee-11e9-9e78-11bb91e134d7.gif" width="250px"> | <br> id selectedTitleOrCustomModels; <br><br> //如果值不为空，则`pickerView`会把当前值选中，<br> demo中是把上一个值记录为`selectedTitleOrCustomModels`，<br> 当模式为`MXPickerViewModeCustom`, `selectedTitleOrCustomModels` 应该为`customModels`, 是一个 `NSArray`数组类型, 如 `@[@"0-1", @"1-2", @"2-3"]` <br> 当模式为日期一类的，如`MXPickerViewModeDD`..., `selectedTitleOrCustomModels`应该为`selectedTitle`, 是一个用空格拼接的`NSString`数组类型, 格式类似于`2018 12 12` <br>当模式为`UIDatePicker`一类的, 如`MXPickerViewModeDateAndTime`, `selectedTitleOrCustomModels` 不应该传, 默认值总是nil! <br> <br> | //当模式为`MXPickerViewModeCustom` <br> pickerView.selectedTitleOrCustomModels = @[@"0-1", @"1-2", @"2-3"]; <br> <br> //当模式为日期一类的，如`MXPickerViewModeDD`..., <br> pickerView.selectedTitleOrCustomModels = @"12月 1号"
<image src="https://user-images.githubusercontent.com/38175174/50195090-a3c3fc80-0378-11e9-84fc-ff7cad339cb4.gif" width="250px"> | NSDate *minimumDate; <br> NSDate *maximumDate; <br> //仅支持`mode`是日期类的，如`MXPickerViewModeDD`... <br> <br> | <br> //创建从（今天 - 今天 + 10天），如（1号 - 10号）的列表 <br> <br> //方式1，设置`中间的时间间隔`，超过当月的`最大天数`, <br> 代码内部会取余`deltaBetweenMaxAndMin%最大天数`，<br> 推荐方式一 <br>pickerView.minimumDate = [NSDate date];<br>pickerView.deltaBetweenMaxAndMin = 10; <br> <br> //方式二, 设置`最小日期`和`最大日期`，超过 <br> 当月的`最大天数`,代码内部会取余 <br> `deltaBetweenMaxAndMin%最大天数` <br> pickerView.minimumDate = [NSDate date]; <br> pickerView.maximumDate = [NSDate dateWithTimeInterval:10 * 24 * 60 * 60 sinceDate:pickerView.minimumDate]; <br> <br>
<image src="https://user-images.githubusercontent.com/38175174/50195483-4335bf00-037a-11e9-85c5-75a5be453ae2.gif" width="250px"> | <br> CGFloat componentWidth; <br> //设置每个`component`的宽度，等宽，如果不设置，<br> 默认为`pickerView.bounds.size.width/numberOfComponents` <br> <br> | pickerView.componentWidth = 100; <br> //每一列`component`列宽都为`100`
<image src="https://user-images.githubusercontent.com/38175174/50195824-ae33c580-037b-11e9-8d4e-479496d1edf1.gif" width="250px"> | <br> CGFloat componentRowHeight; <br> //设置每个`component`的行高，如果不设置，默认为`40` <br> <br> | pickerView.componentRowHeight = 100;
<image src="https://user-images.githubusercontent.com/38175174/50196531-6e221200-037e-11e9-9a09-2cfbfbea2abb.gif" width="250px"> | <br> `CGFloat (^configPickerViewWidthForComponentBlock)(MXPickerView *mxPickerView, UIPickerView *pickerView, NSInteger component)` <br> //为每个`component`设置不同的宽度,相同的可以直接设置`pickerView.componentWidth = xx` <br> <br> | ```pickerView.configPickerViewWidthForComponentBlock = ^CGFloat(MXPickerView *mxPickerView, UIPickerView *pickerView, NSInteger component) { return (component == 0 || component == 3) ? 80 : (mxPickerView.bounds.size.width - 2 * 80)/4;};``` 
<image src="https://user-images.githubusercontent.com/38175174/50198069-f7d4de00-0384-11e9-9601-ec6c891fa3bf.gif" width="250px"> | <br> `CGFloat(^configPickerViewRowHeightForComponentBlock)(MXPickerView *mxPickerView, UIPickerView *pickerView, NSInteger component)` <br> //为每个`component`设置相同的行高, 等价于`pickerView.componentRowHeight = xx` <br> <br> | ```pickerView.configPickerViewRowHeightForComponentBlock = ^CGFloat(MXPickerView *mxPickerView, UIPickerView *pickerView, NSInteger component) {return 100;};``` 
<image src="https://user-images.githubusercontent.com/38175174/50198325-1ab3c200-0386-11e9-913d-8d22e262a160.gif" width="250px"> | <br> `NSString * (^configPickerViewTitleForRowForComponentBlock)(MXPickerView *mxPickerView, UIPickerView *pickerView, NSInteger row, NSInteger component);` <br> //设置每一行的`title` <br> <br> | ```pickerView.configPickerViewTitleForRowForComponentBlock = ^NSString *(MXPickerView *mxPickerView, UIPickerView *pickerView, NSInteger row, NSInteger component) {return @"row content";};``` 
<image src="https://user-images.githubusercontent.com/38175174/50198501-e55ba400-0386-11e9-875f-5f269e372d97.gif" width="250px"> | <br> `NSAttributedString * (^configPickerViewAttributedTitleForRowForComponentBlock)(MXPickerView *mxPickerView, UIPickerView *pickerView, NSInteger row, NSInteger component)` <br> //设置每一行的`attributedTitle` <br> <br> | ```pickerView.configPickerViewAttributedTitleForRowForComponentBlock = ^NSAttributedString *(MXPickerView *mxPickerView, UIPickerView *pickerView, NSInteger row, NSInteger component) {return [[NSAttributedString alloc] initWithString:@"attributed title" attributes:@{NSForegroundColorAttributeName:[UIColor purpleColor]}];};``` 
<image src="https://user-images.githubusercontent.com/38175174/50199621-f4ddeb80-038c-11e9-9f10-6b75dd76b863.gif" width="250px"> | <br> `void (^configPickerViewContentLabelAppearanceForRowForComponentBlock)(MXPickerView *mxPickerView, UIPickerView *pickerView, UILabel *contentLabel, NSInteger row, NSInteger component);` <br> //设置 content label 的样式，如字体，文字对齐方式，背景颜色等... <br> <br> | ```pickerView.configPickerViewContentLabelAppearanceForRowForComponentBlock = ^(MXPickerView *mxPickerView, UIPickerView *pickerView, UILabel *contentLabel, NSInteger row, NSInteger component){ contentLabel.backgroundColor = [UIColor yellowColor];//黄色 contentLabel.textAlignment = NSTextAlignmentRight;};//右对齐``` 
<image src="https://user-images.githubusercontent.com/38175174/50199895-636f7900-038e-11e9-80d5-ee00501fb3b3.gif" width="250px"> | <br> ` UIView * (^configPickerViewViewForRowForComponentBlock)(MXPickerView *mxPickerView, UIPickerView *pickerView, NSInteger row, NSInteger component, UIView *reusingView);` <br> //自定义在`component`中的`contentView` <br> <br> | ```pickerView.configPickerViewViewForRowForComponentBlock = ^UIView *(MXPickerView *mxPickerView, UIPickerView *pickerView, NSInteger row, NSInteger component, UIView *reusingView) {return [UIButton buttonWithType:UIButtonTypeContactAdd];//返回UIButtonTypeContactAdd};``` 




## How to use

### MXPickerViewModeCustom

```objective-c
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
```

### Other date Mode

**MXPickerViewModeDD**， 
**MXPickerViewModeDD_DD**
**MXPickerViewModeMM**
**MXPickerViewModeMM_MM**
**MXPickerViewModeMM_DD**
**MXPickerViewModeMMDD_MMDD**
**MXPickerViewModeYYYY**
**MXPickerViewModeYYYY_YYYY**
**MXPickerViewModeYYYY_MM**
**MXPickerViewModeYYYYMM_YYYYMM**
**MXPickerViewModeYYYYMMDD_YYYYMMDD**

``` objc
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
```

### Date and time

**MXPickerViewModeTime**
**MXPickerViewModeDate**
**MXPickerViewModeDateAndTime**
**MXPickerViewModeCountDownTimer**

``` objective-c
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
```

