//
//  CALayer+MXAnimation.h
//  Yunlu
//
//  Created by Michael on 2018/9/6.
//  Copyright © 2018年 DCloud. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - -------------------------------- CAAnimation (StartEndCallbacks)  -------------------------------
@interface CAAnimation (StartEndCallbacks)

@property (nonatomic, copy) void (^animationDidStartBlock)(CAAnimation *anim);

@property (nonatomic, copy) void (^animationDidStopBlock)(CAAnimation *anim, BOOL finished);

@end

#pragma mark - -------------------------------- MXAnimation  -------------------------------
@interface MXAnimation : NSObject

#pragma mark - convenience animations
+ (CAKeyframeAnimation *)popOutScaleAnimationWithDuration:(NSTimeInterval)duration updateBlock:(void (^)(CAKeyframeAnimation *animation))updateBlock;
+ (CAKeyframeAnimation *)popInScaleAnimationWithDuration:(NSTimeInterval)duration updateBlock:(void (^)(CAKeyframeAnimation *animation))updateBlock;

+ (CAKeyframeAnimation *)upFromKeyWindowAnimationWithDuration:(NSTimeInterval)duration addToView:(UIView *)view updateBlock:(void (^)(CAKeyframeAnimation *animation))updateBlock;
+ (CAKeyframeAnimation *)downToKeyWindowAnimationWithDuration:(NSTimeInterval)duration addToView:(UIView *)view updateBlock:(void (^)(CAKeyframeAnimation *animation))updateBlock;

+ (CAKeyframeAnimation *)showAlphaAnimationWithDuration:(NSTimeInterval)duration updateBlock:(void (^)(CAKeyframeAnimation *animation))updateBlock;
+ (CAKeyframeAnimation *)hideAlphaAnimationWithDuration:(NSTimeInterval)duration updateBlock:(void (^)(CAKeyframeAnimation *animation))updateBlock;

+ (CAKeyframeAnimation *)deleteAnimationWithDuration:(NSTimeInterval)duration updateBlock:(void (^)(CAKeyframeAnimation *animation))updateBlock;

#pragma mark - basic animations
+ (CAKeyframeAnimation *)translateYAnimationWithValues:(NSArray *)values duration:(NSTimeInterval)duration updateBlock:(void (^)(CAKeyframeAnimation *animation))updateBlock;

+ (CAKeyframeAnimation *)alphaAnimatonWithValues:(NSArray *)values duration:(NSTimeInterval)duration updateBlock:(void (^)(CAKeyframeAnimation *animation))updateBlock;

+ (CAKeyframeAnimation *)scaleAnimatonWithValues:(NSArray *)values duration:(NSTimeInterval)duration updateBlock:(void (^)(CAKeyframeAnimation *animation))updateBlock;

@end
