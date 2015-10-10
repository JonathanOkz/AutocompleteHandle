//
//  autocompleteHandleView.h
//  AutocompleteHandle
//
//  Created by Jonathan Oleszkiewicz on 04/10/2015.
//  Copyright (c) 2015 Jonathan Oleszkiewicz.
//  See LICENSE for full license agreement.
//

#import <UIKit/UIKit.h>


@protocol AutocompleteHandleViewDelegate<NSObject>

@optional
- (void)autocompleteHandleViewSelectedHandle:(nonnull NSString *)handle;

@end

@interface AutocompleteHandleView : UIView


- (nonnull id)initWithFrame:(CGRect)frame backgroundColor:(nonnull UIColor *)backgroundColor delegate:(nonnull id<AutocompleteHandleViewDelegate>)instanceDelegates;

- (void)showHandle:(nonnull NSArray *)usernameArray;

- (void)hiddenHandle;

@property(nullable,nonatomic,weak) id<AutocompleteHandleViewDelegate> delegate;


@end
