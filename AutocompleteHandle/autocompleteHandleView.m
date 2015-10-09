//
//  autocompleteHandleView.m
//  AutocompleteHandle
//
//  Created by Jonathan Oleszkiewicz on 04/10/2015.
//  Copyright (c) 2015 Jonathan Oleszkiewicz.
//  See LICENSE for full license agreement.
//

#import "autocompleteHandleView.h"


@implementation AutocompleteHandleView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor delegate:(nonnull id<AutocompleteHandleViewDelegate>)instanceDelegates
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.delegate = instanceDelegates;
        self.backgroundColor = backgroundColor;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)showHandle:(NSArray *)handleArray
{
    self.hidden = FALSE;
    
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    
    float heightHandleView = 30.0f * handleArray.count;
    
    [UIView animateWithDuration:0.7f animations:^{
        self.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, -heightHandleView);
    }];
    
    for (int i = 0; i < handleArray.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(5.0f, 30.0f * i,  self.frame.size.width, 30.0f)];
        [btn setTitle:handleArray[i] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setTitleColor:[UIColor colorWithRed:0.00627 green:0.627 blue:0.286 alpha:1.0f] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:13.0f];
        [btn addTarget:self action:@selector(handleClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

- (void)hiddenHandle
{
    self.hidden = TRUE;
    self.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, 0.0f);
}

-(void)handleClicked:(UIButton *)sender
{
    // call delegate methods
    if (delegate && [delegate respondsToSelector:@selector(autocompleteHandleViewSelectedHandle:)]) {
        [delegate autocompleteHandleViewSelectedHandle:[sender currentTitle]];
    }
}

@end
