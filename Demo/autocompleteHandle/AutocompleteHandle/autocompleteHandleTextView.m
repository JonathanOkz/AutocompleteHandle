//
//  autocompleteHandleTextView.m
//  AutocompleteHandle
//
//  Created by Jonathan Oleszkiewicz on 04/10/2015.
//  Copyright (c) 2015 Jonathan Oleszkiewicz.
//  See LICENSE for full license agreement.
//

#import "autocompleteHandleTextView.h"


@interface AutocompleteHandleTextView ()

@end

@implementation AutocompleteHandleTextView
@dynamic delegate;

- (id)initWithFrame:(CGRect)frame handleCharacterAllowed:(NSString *)handleCharacterAllowed hashtagCharacterAllowed:(NSString *)hashtagCharacterAllowed colorHandle:(UIColor *)colorHandle colorHashtag:(UIColor *)colorHashtag delegate:(id<AutocompleteHandleTextViewDelegate>)instanceDelegates
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _handleCharacterAllowed = handleCharacterAllowed;
        _hashtagCharacterAllowed = hashtagCharacterAllowed;
        _colorHandle  = colorHandle;
        _colorHashtag = colorHashtag;
        self.delegate = instanceDelegates;
        [self setKeyboardType:UIKeyboardTypeTwitter];
        self.backgroundColor = [UIColor whiteColor];
        [[self layer] setCornerRadius:7.0f];
        [[self layer] setBorderWidth:1.0];
        [[self layer] setBorderColor:[[UIColor colorWithRed:0.667f green:0.667f blue:0.667f alpha:1.0f] CGColor]];
    }
    return self;
}

-(void)autosizing
{
    CGFloat height = self.frame.size.height;
    CGFloat fixedWidth = self.frame.size.width;
    CGSize newSize = [self sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, fixedWidth, newSize.height);
    
    if (height != self.frame.size.height) {
        // call delegate methods
        if (self.delegate && [self.delegate respondsToSelector:@selector(autocompleteHandleTextViewHeightDidChange:)]) {
            [self.delegate autocompleteHandleTextViewHeightDidChange:self.frame.size.height];
        }
    }
}

- (void)colorWord {
    NSRange range0 = self.selectedRange;
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:self.text];
    
    [self colorHandle:attributedText];
    [self colorHashtag:attributedText];
    
    [self setAttributedText:attributedText];
    [self setSelectedRange:range0];
}

-(BOOL)autocomplete:(NSString *)handle
{
    NSRange range0 = self.selectedRange;
    NSString *newHandle = handle;
    NSString *str0 = nil;
    NSString *str1 = nil;
    
    long left = [self left:self.selectedRange string:self.text];
    long right = [self right:self.selectedRange string:self.text];
    if (left == -1 || right == -1) return NO;

    @try {
        str0 = [self.text substringWithRange:NSMakeRange(0, left)];
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
    }
    @try {
        str1 = [self.text substringWithRange:NSMakeRange(right, self.text.length - right)];
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
    }
    
    if (newHandle && ![newHandle isEqual: @""] && str0 && str1)
    {
        self.text = [NSString stringWithFormat:@"%@@%@ %@", str0, newHandle, str1];
        
        NSRange range = range0;
        range.location = str0.length + newHandle.length + 2;
        self.selectedRange = range;
        
        [self autosizing];
        [self colorWord];
        
        return YES;
    }
    return NO;
}

- (NSString *)getActiveHandle
{
    NSString *activeHandle = @"";
    
    long left = [self left:self.selectedRange string:self.text];
    long right = [self right:self.selectedRange string:self.text];
    long beforeLeft = [self beforeLeft:left string:self.text];
    
    if (left == -1 || right == -1 || beforeLeft != -1) return @"";

    long begin = left+1;
    long length = right - begin;
    if ( (begin >= 0 && begin < self.text.length) && (length > 0 && length <= self.text.length) ) {
        activeHandle = [self.text substringWithRange:NSMakeRange(left+1, right - (left+1) )];
    }
    
    return activeHandle;
}

- (void)colorHandle:(NSMutableAttributedString *)attributedText
{
    int begin = 0;
    
    for (int i = 0; i < self.text.length; i++) {
        if ([self.text characterAtIndex:i] == '@' && (i == 0 || [self regex:[self.text characterAtIndex:i-1] characterAllowed:_handleCharacterAllowed] == FALSE)) {
            begin = i;
            i++;
            
            while (i <= self.text.length) {
                
                if (i == self.text.length || [self regex:[self.text characterAtIndex:i] characterAllowed:_handleCharacterAllowed] == FALSE) {
                    
                    NSRange range;
                    range.length = i-begin;
                    range.location = begin;
                    [attributedText addAttribute:NSForegroundColorAttributeName value:_colorHandle range:range];
                    break;
                }
                i++;
            }
            
        }
    }
}

- (void)colorHashtag:(NSMutableAttributedString *)attributedText
{
    
    int begin = 0;
    
    for (int i = 0; i < self.text.length; i++) {
        if ([self.text characterAtIndex:i] == '#') {
            begin = i;
            i++;
            
            while (i <= self.text.length) {
                
                if (i == self.text.length || [self regex:[self.text characterAtIndex:i] characterAllowed:_hashtagCharacterAllowed] == FALSE) {
                    
                    NSRange range;
                    range.length = i-begin;
                    range.location = begin;
                    [attributedText addAttribute:NSForegroundColorAttributeName value:_colorHashtag range:range];
                    break;
                }
                i++;
            }
            
        }
    }
    
}

-(long)left:(NSRange)range string:(NSString *)string
{
        long i = range.location-1;
        while (i >= 0 && i < string.length) {
            if ([string characterAtIndex:i] == '@') return i;
            if ([self regex:[string characterAtIndex:i] characterAllowed:_handleCharacterAllowed] == FALSE) return -1;
            i--;
        }
        return -1;
}

-(long)right:(NSRange)range string:(NSString *)string
{
        long i = range.location-1;
        while (i >= 0 && i <= string.length) {
            if (i == string.length || ([string characterAtIndex:i] != '@' && [self regex:[string characterAtIndex:i] characterAllowed:_handleCharacterAllowed] == FALSE) ) return i;
            i++;
        }
        return -1;
}

-(long)beforeLeft:(long)left string:(NSString *)string
{
    long i = left-1;
    if (i >= 0 && i < string.length) {
        if ([self regex:[string characterAtIndex:i] characterAllowed:_handleCharacterAllowed] == TRUE) return i;
    }
    return -1;
}

-(BOOL)regex:(unsigned char)c characterAllowed:(NSString *)characterAllowed
{
    for (int i = 0; i < characterAllowed.length; i++) {
        if (c == (unsigned char)[characterAllowed characterAtIndex:i]) return TRUE;
    }
    return FALSE;
}

@end
