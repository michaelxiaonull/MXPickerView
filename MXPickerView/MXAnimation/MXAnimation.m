//
//  CALayer+MXAnimation.m
//  Yunlu
//
//  Created by Michael on 2018/9/6.
//  Copyright © 2018年 DCloud. All rights reserved.
//

#import "MXAnimation.h"
#import <objc/runtime.h>

#pragma mark - -------------------------------- CAAnimation (StartEndCallbacks)  -------------------------------
@implementation CAAnimation (StartEndCallbacks)

#pragma mark - setter
- (void)setAnimationDidStartBlock:(void (^)(CAAnimation *))animationDidStartBlock {
    [self setValue:animationDidStartBlock forKey:[NSString stringWithFormat:@"_%@", NSStringFromSelector(@selector(animationDidStartBlock))]];
}

- (void)setAnimationDidStopBlock:(void (^)(CAAnimation *, BOOL))animationDidStopBlock {
    [self setValue:animationDidStopBlock forKey:[NSString stringWithFormat:@"_%@", NSStringFromSelector(@selector(animationDidStopBlock))]];
}

#pragma mark - getter
- (void (^)(CAAnimation *))animationDidStartBlock {
    return [self valueForKey:[NSString stringWithFormat:@"_%@", NSStringFromSelector(_cmd)]];
}

- (void (^)(CAAnimation *, BOOL))animationDidStopBlock {
    return [self valueForKey:[NSString stringWithFormat:@"_%@", NSStringFromSelector(_cmd)]];
}

@end

#pragma mark - -------------------------------- MXAnimation  -------------------------------
typedef NS_ENUM(NSUInteger, MXAnimationType) {
    MXAnimationTypeTranslateY,
    MXAnimationTypeAlpha,
    MXAnimationTypeScale,
    MXAnimationTypeRotationZ,
};

@interface MXAnimation () <CAAnimationDelegate>

@end

@implementation MXAnimation

#pragma mark - convenience animations
+ (CAKeyframeAnimation *)popOutScaleAnimationWithDuration:(NSTimeInterval)duration updateBlock:(void (^)(CAKeyframeAnimation *animation))updateBlock {
    return [self scaleAnimatonWithValues:@[@0.01, @1.13, @0.9, @1.0] duration:duration updateBlock:updateBlock];
}

+ (CAKeyframeAnimation *)popInScaleAnimationWithDuration:(NSTimeInterval)duration updateBlock:(void (^)(CAKeyframeAnimation *animation))updateBlock {
    return [self scaleAnimatonWithValues:@[@1.0, @0.01] duration:duration ?: 0.2f updateBlock:updateBlock];
}

+ (CAKeyframeAnimation *)upFromKeyWindowAnimationWithDuration:(NSTimeInterval)duration addToView:(UIView *)view updateBlock:(void (^)(CAKeyframeAnimation *animation))updateBlock {
    CGFloat h = view.bounds.size.height, keyWindowH = [UIScreen mainScreen].bounds.size.height, safeH = 0;
    if (@available(iOS 11.0, *)) {
        safeH = [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
    }
    view.frame = CGRectMake(0, keyWindowH - h - safeH, view.bounds.size.width, h);
    return [self translateYAnimationWithValues:@[@(h + safeH), @0] duration:duration updateBlock:updateBlock];
}

+ (CAKeyframeAnimation *)downToKeyWindowAnimationWithDuration:(NSTimeInterval)duration addToView:(UIView *)view updateBlock:(void (^)(CAKeyframeAnimation *animation))updateBlock {
    CGFloat h = view.bounds.size.height, keyWindowH = [UIScreen mainScreen].bounds.size.height, safeH = 0;
    if (@available(iOS 11.0, *)) {
        safeH = [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
    }
    view.frame = CGRectMake(0, keyWindowH - h - safeH, view.bounds.size.width, h);
    return [self translateYAnimationWithValues:@[@0, @(h + safeH)] duration:duration updateBlock:updateBlock];
}

+ (CAKeyframeAnimation *)showAlphaAnimationWithDuration:(NSTimeInterval)duration updateBlock:(void (^)(CAKeyframeAnimation *animation))updateBlock {
    return [self alphaAnimatonWithValues:@[@(0.01f), @(1.0)] duration:duration updateBlock:updateBlock];
}

+ (CAKeyframeAnimation *)hideAlphaAnimationWithDuration:(NSTimeInterval)duration updateBlock:(void (^)(CAKeyframeAnimation *animation))updateBlock {
    return [self alphaAnimatonWithValues:@[@(1.0), @(0.01f)] duration:duration updateBlock:updateBlock];
}

+ (CAKeyframeAnimation *)deleteAnimationWithDuration:(NSTimeInterval)duration updateBlock:(void (^)(CAKeyframeAnimation *animation))updateBlock {
    return [self ratationZAnimatonWithValues:@[@0, @(-3/180.0f * M_PI), @0, @(3/180.0f * M_PI), @0] duration:duration updateBlock:^(CAKeyframeAnimation *animation) {
        animation.repeatCount = MAXFLOAT;
    }];
}

#pragma mark - basic animations
+ (CAKeyframeAnimation *)translateYAnimationWithValues:(NSArray *)values duration:(NSTimeInterval)duration updateBlock:(void (^)(CAKeyframeAnimation *animation))updateBlock {
    return [self animationWithType:MXAnimationTypeTranslateY values:values duration:duration updateBlock:updateBlock];
}

+ (CAKeyframeAnimation *)alphaAnimatonWithValues:(NSArray *)values duration:(NSTimeInterval)duration updateBlock:(void (^)(CAKeyframeAnimation *animation))updateBlock {
    return [self animationWithType:MXAnimationTypeAlpha values:values duration:duration updateBlock:updateBlock];
}

+ (CAKeyframeAnimation *)scaleAnimatonWithValues:(NSArray *)values duration:(NSTimeInterval)duration updateBlock:(void (^)(CAKeyframeAnimation *animation))updateBlock {
    return [self animationWithType:MXAnimationTypeScale values:values duration:duration updateBlock:updateBlock];
}

+ (CAKeyframeAnimation *)ratationZAnimatonWithValues:(NSArray *)values duration:(NSTimeInterval)duration updateBlock:(void (^)(CAKeyframeAnimation *animation))updateBlock {
    return [self animationWithType:MXAnimationTypeRotationZ values:values duration:duration updateBlock:updateBlock];
}

+ (CAKeyframeAnimation *)animationWithType:(MXAnimationType)animationType values:(NSArray *)values duration:(NSTimeInterval)duration updateBlock:(void (^)(CAKeyframeAnimation *animation))updateBlock {
    
    NSString *keyPath = nil;
    switch (animationType) {
        case MXAnimationTypeTranslateY:
            keyPath = @"transform.translation.y";
            break;
        case MXAnimationTypeAlpha:
            keyPath = @"opacity";
            break;
        case MXAnimationTypeScale:
            keyPath = @"transform.scale";
            break;
        case MXAnimationTypeRotationZ:
            keyPath = @"transform.rotation.z";
            break;
        default:
            break;
    }
    if (!keyPath) return nil;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    animation.values = values;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = duration ?: 0.35f;
    animation.delegate = (id)self;
    //animation.keyTimes = @[@0.0f, @0.3f, @0.6f, @1.0f];
    !updateBlock ?:updateBlock(animation);
    return animation;
}

#pragma mark - CAAnimationDelegate
+ (void)animationDidStart:(CAAnimation *)anim {
    !anim.animationDidStartBlock ?: anim.animationDidStartBlock(anim);
    anim.animationDidStartBlock = nil;
}

+ (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    !anim.animationDidStopBlock ?: anim.animationDidStopBlock(anim, flag);
    anim.animationDidStopBlock = nil;
}

@end
