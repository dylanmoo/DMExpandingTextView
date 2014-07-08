//
//  DMExpandingTextView.h
//
//  Created by Dylan Moore on 7/7/14.
//  Copyright (c) 2014 Dylan Moore. All rights reserved.

//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.

#import <UIKit/UIKit.h>

@protocol DMExpandingTextViewDelegate <UITextViewDelegate>

@optional
//Called after the textview has resized itself
-(void)expandingTextViewResized;

//Called after the textview has switched to placeholder
-(void)expandingTextViewShowingPlaceholder;

@end

@interface DMExpandingTextView : UITextView

//Set these at any time, but make sure to call showPlaceholder

@property float minimumHeight;

@property (nonatomic) NSString *placeholderText;

@property (nonatomic) UIColor *placeholderTextColor;

@property (nonatomic) UIColor *editingTextColor;

//Superview should be a DMExpandingTextViewDelegate to recieve expandingTextViewResized call

@property (nonatomic, weak) NSObject<DMExpandingTextViewDelegate> *delegate;

//

-(void)showPlaceholder;

-(bool)showingPlaceholder;



@end
