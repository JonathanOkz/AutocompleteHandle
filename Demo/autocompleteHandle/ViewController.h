//
//  ViewController.h
//  autocompleteHandle
//
//  Created by Jonathan Olesz on 19/09/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "autocompleteHandle.h"

@interface ViewController : UIViewController<AutocompleteHandleDelegate>

@property (weak, nonatomic) IBOutlet AutocompleteHandle *text;

@end

