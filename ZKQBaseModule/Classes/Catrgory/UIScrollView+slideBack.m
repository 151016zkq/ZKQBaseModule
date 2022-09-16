//
//  UIScrollView+slideBack.m
//  SGPagingViewExample
//
//  Created by Mia on 2017/10/20.
//  Copyright © 2017年 Sorgle. All rights reserved.
//

#import "UIScrollView+slideBack.h"


@implementation UIScrollView (slideBack)
//一句话总结就是此方法返回YES时，手势事件会一直往下传递，不论当前层次是否对该事件进行响应。
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([self panBack:gestureRecognizer]) {
        return YES;
    }
    return NO;
}

//location_X可自己定义,其代表的是滑动返回手势生效的范围：距离屏幕左侧的距离
- (BOOL)panBack:(UIGestureRecognizer *)gestureRecognizer {
    //是滑动返回距左边的有效长度
    int location_X = 40;
    if (gestureRecognizer == self.panGestureRecognizer) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint point = [pan translationInView:self];
        UIGestureRecognizerState state = gestureRecognizer.state;
        if (UIGestureRecognizerStateBegan == state || UIGestureRecognizerStatePossible == state) {
            CGPoint location = [gestureRecognizer locationInView:self];
            //这是允许每张图片都可实现滑动返回
            int temp1 = location.x;
            int temp2 = [UIScreen mainScreen].bounds.size.width;
            NSInteger XX = temp1 % temp2;
            if (point.x > 0 && XX < location_X) {
                return YES;
            }
            //下面的是只允许在第一张时滑动返回生效
            //            if (point.x > 0 && location.x < location_X && self.contentOffset.x <= 0) {
            //                return YES;
            //            }
        }
    }
    return NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self panBack:gestureRecognizer]) {
        return NO;
    }
    return YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //add by jins 2020.04.14 fix 听云-[UIKBBlurredKeyView candidateList]: unrecognized selector sent to instance 0x13debaab0
    if (![self isMemberOfClass:[UIScrollView class]]) {
        //UIKBCandidateCollectionView 键盘手写输入时，此类型不处理。
     } else {
         [[self nextResponder] touchesBegan:touches withEvent:event];
         if ([super respondsToSelector:@selector(touchesBegan:withEvent:)]) {
             [super touchesBegan:touches withEvent:event];
         }
     }
    //add by jins 2020.02.03 fix 听云-[UIKBBlurredKeyView candidateList]: unrecognized selector sent to instance 0x13debaab0
//    if ([self isMemberOfClass:[UIScrollView class]]) {
//        [[self nextResponder] touchesBegan:touches withEvent:event];
//    }
//    [super touchesBegan:touches withEvent:event];
//    [[self nextResponder] touchesBegan:touches withEvent:event];
//    [super touchesBegan:touches withEvent:event];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (![self isMemberOfClass:[UIScrollView class]]) {
        //UIKBCandidateCollectionView 键盘手写输入时，此类型不处理
    } else {
        [[self nextResponder] touchesMoved:touches withEvent:event];
        if ([super respondsToSelector:@selector(touchesBegan:withEvent:)]) {
            [super touchesMoved:touches withEvent:event];
        }
    }
    
//    [[self nextResponder] touchesMoved:touches withEvent:event];
//    [super touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (![self isMemberOfClass:[UIScrollView class]]) {
        //UIKBCandidateCollectionView 键盘手写输入时，此类型不处理
    } else {
        [[self nextResponder] touchesEnded:touches withEvent:event];
        if ([super respondsToSelector:@selector(touchesBegan:withEvent:)]) {
            [super touchesEnded:touches withEvent:event];
        }
    }
//    [[self nextResponder] touchesEnded:touches withEvent:event];
//    [super touchesEnded:touches withEvent:event];
}
@end
