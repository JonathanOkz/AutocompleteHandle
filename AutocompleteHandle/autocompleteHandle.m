//
//  autocompleteHandle.m
//  AutocompleteHandle
//
//  Created by Jonathan Oleszkiewicz on 04/10/2015.
//  Copyright (c) 2015 Jonathan Oleszkiewicz.
//  See LICENSE for full license agreement.
//

#import "autocompleteHandle.h"


@implementation AutocompleteHandle

@synthesize delegate;

-(id)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor {
    if ((self = [super initWithFrame:frame]))
    {
        self.backgroundColor = backgroundColor;
        [self initialize];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self initialize];
    }
    return self;
}

-(void)initialize
{
    _autocompleteHandleView = [[AutocompleteHandleView alloc]
                               initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, 0.0f)
                               backgroundColor:self.backgroundColor
                               delegate:self
                              ];
    [self addSubview:_autocompleteHandleView];
    
    _autocompleteHandleTextView = [[AutocompleteHandleTextView alloc]
                                   initWithFrame:CGRectMake(10.0f, 10.0f, self.frame.size.width-20.0f, self.frame.size.height-20.0f)
                                   handleCharacterAllowed:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-"
                                   hashtagCharacterAllowed:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_"
                                   colorHandle:[UIColor colorWithRed:0.00627 green:0.627 blue:0.286 alpha:1.0f]
                                   colorHashtag:[UIColor colorWithRed:0.00627 green:0.627 blue:0.586 alpha:1.0f]
                                   delegate:self
                                  ];
    [self addSubview:_autocompleteHandleTextView];
    
}

// Simulate asynchronous server request
- (void)findForUsername:(NSString *)username cb:(nullable void (^)(NSArray *usernameArray))cb
{
    NSMutableArray *cars = [NSMutableArray arrayWithObjects:@"Maruthi",@"Maruthi",@"Mauthi",@"Maruhi",@"aruthi",@"Hyundai", @"Ford",@"For",@"Fordgf",@"Fgord",@"Benz", @"BMW",@"fbgt",@"bddggt",@"bdggted",@"bnhgt",@"Toyota",@"Toota",@"Tjoyota",@"Tolkta",@"Tyjhhota",@"Tuyta",nil];
    NSString *regexString  = [NSString stringWithFormat:@".*\\b%@.*", username];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", regexString];
    NSArray *results = [cars filteredArrayUsingPredicate:pred];
    
    return cb(results);
}

#pragma mark - AutocompleteHandleView Delegate Methods

-(void)autocompleteHandleViewSelectedHandle:(NSString *)handle {
    if ([_autocompleteHandleTextView autocomplete:handle] == TRUE) {
        [_autocompleteHandleView hiddenHandle];
        
        // call delegate methods
        if (delegate && [delegate respondsToSelector:@selector(autocompleteHandleSelectedHandle:)]) {
            [delegate autocompleteHandleSelectedHandle:handle];
        }
    }
}

#pragma mark - AutocompleteHandleTextView Delegate Methods

- (void)autocompleteHandleTextViewHeightDidChange:(CGFloat)height
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height+20.0f);
    
    // call delegate methods
    if (delegate && [delegate respondsToSelector:@selector(autocompleteHandleHeightDidChange:)]) {
        [delegate autocompleteHandleHeightDidChange:self.frame.size.height];
    }
}

#pragma mark - UITextView Delegate Methods

- (void)textViewDidChange:(UITextView *)textView
{
    [_autocompleteHandleTextView autosizing];
    [_autocompleteHandleTextView colorWord];
    
    NSString *handle = [_autocompleteHandleTextView getActiveHandle];
    if (![handle isEqual: @""])
    {
        [self findForUsername:handle cb:^(NSArray *usernameArray) {
            [_autocompleteHandleView showHandle:usernameArray];
        }];
        
    }else{
        [_autocompleteHandleView hiddenHandle];
    }
    
    // call delegate methods
    if (delegate && [delegate respondsToSelector:@selector(textViewDidChange:)]) {
        [delegate textViewDidChange:textView];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView * _Nonnull)textView
{
    if (delegate && [delegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        return [delegate textViewShouldBeginEditing:textView];
    }
    return YES;
}


- (void)textViewDidBeginEditing:(UITextView * _Nonnull)textView
{
    if (delegate && [delegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [delegate textViewDidBeginEditing:textView];
    }
}


- (BOOL)textViewShouldEndEditing:(UITextView * _Nonnull)textView
{
    if (delegate && [delegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [delegate textViewShouldEndEditing:textView];
    }
    return YES;
}


- (void)textViewDidEndEditing:(UITextView * _Nonnull)textView
{
    if (delegate && [delegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [delegate textViewDidEndEditing:textView];
    }
}


- (BOOL)textView:(UITextView * _Nonnull)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString * _Nonnull)text
{
    if (delegate && [delegate respondsToSelector:@selector(textView: shouldChangeTextInRange: replacementText:)]) {
        return [delegate textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}


- (void)textViewDidChangeSelection:(UITextView * _Nonnull)textView
{
    if (delegate && [delegate respondsToSelector:@selector(textViewDidChangeSelection:)]) {
        [delegate textViewDidChangeSelection:textView];
    }
}


- (BOOL)textView:(UITextView * _Nonnull)textView shouldInteractWithTextAttachment:(NSTextAttachment * _Nonnull)textAttachment inRange:(NSRange)characterRange
{
    if (delegate && [delegate respondsToSelector:@selector(textView: shouldInteractWithTextAttachment: inRange:)]) {
        return [delegate textView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange];
    }
    return YES;
}


- (BOOL)textView:(UITextView * _Nonnull)textView shouldInteractWithURL:(NSURL * _Nonnull)URL inRange:(NSRange)characterRange
{
    if (delegate && [delegate respondsToSelector:@selector(textView: shouldInteractWithURL: inRange:)]) {
        return [delegate textView:textView shouldInteractWithURL:URL inRange:characterRange];
    }
    return YES;
}

#pragma mark - hitTest Methods

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (!self.clipsToBounds && !self.hidden && self.alpha > 0) {
        for (UIView *subview in self.subviews.reverseObjectEnumerator) {
            CGPoint subPoint = [subview convertPoint:point fromView:self];
            UIView *result = [subview hitTest:subPoint withEvent:event];
            if (result != nil) {
                return result;
            }
        }
    }
    
    return [super hitTest:point withEvent:event];
}

@end
