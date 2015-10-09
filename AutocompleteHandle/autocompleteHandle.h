//
//  autocompleteHandle.h
//  AutocompleteHandle
//
//  Created by Jonathan Oleszkiewicz on 04/10/2015.
//  Copyright (c) 2015 Jonathan Oleszkiewicz.
//  See LICENSE for full license agreement.
//

#import <UIKit/UIKit.h>
#import "autocompleteHandleTextView.h"
#import "autocompleteHandleView.h"


@protocol AutocompleteHandleDelegate<AutocompleteHandleTextViewDelegate, AutocompleteHandleViewDelegate>

@optional
- (void)autocompleteHandleHeightDidChange:(CGFloat)height;
- (void)autocompleteHandleSelectedHandle:(nonnull NSString *)handle;

@end

@interface AutocompleteHandle : UIView<AutocompleteHandleTextViewDelegate, AutocompleteHandleViewDelegate>  {
@private
    AutocompleteHandleTextView  *_autocompleteHandleTextView;
    AutocompleteHandleView      *_autocompleteHandleView;
}


- (nonnull id)init __attribute__((unavailable("init is not a valid initializer for the class AutocompleteHandle")));

- (nonnull id)initWithFrame:(CGRect)frame __attribute__((unavailable("initWithFrame: is not a valid initializer for the class AutocompleteHandle")));

- (nonnull id)initWithFrame:(CGRect)frame backgroundColor:(nonnull UIColor *)backgroundColor;

@property(nullable,nonatomic,weak) id<AutocompleteHandleDelegate> delegate;


@end