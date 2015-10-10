# AutocompleteHandle
UITextView subclass that automatically displays suggestions in real-time #hashtag and @Handle

## Installation
* Drop the "AutocompleteHandle" folder into your project
* Import AutocompleteHandle class in your project
```
#import "autocompleteHandle.h"
```

## Usage
#### Create AutocompleteHandle programmatically
```objc
AutocompleteHandle *autocompleteHandle = [[AutocompleteHandle alloc] initWithFrame:CGRectMake(10.0f, 200.0f, self.view.frame.size.width-20.0f, 50.0f) backgroundColor:[UIColor greenColor]];
autocompleteHandle.delegate = self;
[self.view addSubview:autocompleteHandle];
```
Don't missing to add `<AutocompleteHandleDelegate>` in your viewcontroller.h if you want to access at the delegate methods
#### Create AutocompleteHandle graphically
* Drop the "UIView" element in your view
* Set the class propriety of the view to 'AutocompleteHandle'
* Set attributes (color, size, etc.)
* Enjoy

#### AutocompleteHandle Delegate Methods
* Send the new height of the AutocompleteHandle when it's changed
```objc
- (void)autocompleteHandleHeightDidChange:(CGFloat)height;
```
* Send the handle selected (trigger when user click on handle)
```objc
- (void)autocompleteHandleSelectedHandle:(nonnull NSString *)handle;
```
All delegate methods of UITextView are also accessible
## Example
Please launch the Xcode project in the 'Demo' folder

## License
```
The MIT License (MIT)

Copyright (c) 2015 

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
