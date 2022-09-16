//
//  UITextField+Add.m
//  LifeInsurance
//
//  Created by zrq on 2018/10/17.
//  Copyright © 2018年 cn.picclife.  All rights reserved.
//

#import "UITextField+Add.h"
#import "UIColor+Add.h"

@implementation UITextField (Add)

- (NSRange)selectedRange
{
    UITextPosition* beginning = self.beginningOfDocument;
    
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}

- (void)setSelectedRange:(NSRange) range
{
    UITextPosition* beginning = self.beginningOfDocument;
    
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    
    [self setSelectedTextRange:selectionRange];
}

//- (void)cursorLocation:(UITextField*)textField index:(NSInteger)index
//
//{
//    NSRange range = NSMakeRange(index,0);
//    UITextPosition *start = [textField positionFromPosition:[textField beginningOfDocument] offset:range.location];
//    UITextPosition *end = [textField positionFromPosition:start offset:range.length];
//    [textField setSelectedTextRange:[textField textRangeFromPosition:start toPosition:end]];
//}


@end
