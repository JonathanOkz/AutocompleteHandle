//
//  autocompleteHandleTextView.h
//  AutocompleteHandle
//
//  Created by Jonathan Oleszkiewicz on 04/10/2015.
//  Copyright (c) 2015 Jonathan Oleszkiewicz.
//  See LICENSE for full license agreement.
//

#import <UIKit/UIKit.h>


@protocol AutocompleteHandleTextViewDelegate<UITextViewDelegate>

@optional
- (void)autocompleteHandleTextViewHeightDidChange:(CGFloat)height;

@end

@interface AutocompleteHandleTextView : UITextView {
    @private
    NSString    *_handleCharacterAllowed;
    NSString    *_hashtagCharacterAllowed;
    UIColor     *_colorHandle;
    UIColor     *_colorHashtag;
}

- (nonnull id)initWithFrame:(CGRect)frame handleCharacterAllowed:(nonnull NSString *)handleCharacterAllowed hashtagCharacterAllowed:(nonnull NSString *)hashtagCharacterAllowed colorHandle:(nonnull UIColor *)colorHandle colorHashtag:(nonnull UIColor *)colorHashtag delegate:(nonnull id<AutocompleteHandleTextViewDelegate>)instanceDelegates;

- (void)autosizing;

- (void)colorWord;

- (nonnull NSString *)getActiveHandle;

-(BOOL)autocomplete:(nonnull NSString *)handle;

@property(nullable,nonatomic,weak) id<AutocompleteHandleTextViewDelegate> delegate;


@end

