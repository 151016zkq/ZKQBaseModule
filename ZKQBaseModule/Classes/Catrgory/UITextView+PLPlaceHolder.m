//
//  UITextView+PLPlaceHolder.m
//  SmartPicc
//
//  Created by zrq on 2019/2/1.
//  Copyright © 2019年 cn.picclife. All rights reserved.
//

#import "UITextView+PLPlaceHolder.h"
#import "UIColor+Add.h"
#import <objc/runtime.h>
static const void *textView_key = @"placeHolder";

@implementation UITextView (PLPlaceHolder)
- (void)setPlaceHolder:(NSString *)placeHolder
{
    objc_setAssociatedObject(self, textView_key, placeHolder, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if ([self viewWithTag:1000] == nil) {
        UILabel *placeHolderLb = [[UILabel alloc] initWithFrame:CGRectMake(2, 7, [UIScreen mainScreen].bounds.size.width - 2 * 16, 21)];
        placeHolderLb.tag = 1000;
        placeHolderLb.contentMode = UIViewContentModeTop;
        placeHolderLb.numberOfLines = 0;
        placeHolderLb.textColor = [UIColor colorWithHexString:@"C4C4C7"];
        placeHolderLb.font = [UIFont systemFontOfSize:14];
        placeHolderLb.alpha = 1;
        placeHolderLb.text = placeHolder;
        //placeHolderLb.hidden = self.text.length > 0?YES:NO;
        [self addSubview:placeHolderLb];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChanged:) name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChanged:) name:UITextViewTextDidChangeNotification object:nil];
}
- (NSString *)placeHolder
{
    return objc_getAssociatedObject(self, textView_key);
}

- (void)textViewbegin:(NSNotification *)noti
{
    UILabel *label = [self viewWithTag:1000];
    label.hidden = YES;
}

- (void)textViewChanged:(NSNotification *)noti
{
    UILabel *label = [self viewWithTag:1000];
    label.hidden = self.text.length > 0;
}
- (void)showPlaceHolder{
    UILabel *label = [self viewWithTag:1000];
    
    label.hidden = NO;
}
- (void)hiddenPlaceHolder{
    UILabel *label = [self viewWithTag:1000];
       
    label.hidden = YES;
}
@end
