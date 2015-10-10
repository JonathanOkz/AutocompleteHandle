//
//  ViewController.m
//  autocompleteHandle
//
//  Created by Jonathan Olesz on 19/09/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.text.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidChange:(UITextView *)textView {
    NSLog(@"textViewDidChange");

}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    
    NSLog(@"textViewDidChangeSelection");
}

-(void)autocompleteHandleSelectedHandle:(NSString *)handle {
    NSLog(@"autocompleteHandleSelectedHandle:%@", handle);
}

-(void)autocompleteHandleHeightDidChange:(CGFloat)height {
    NSLog(@"autocompleteHandleHeightDidChange:%f", height);
}

@end
