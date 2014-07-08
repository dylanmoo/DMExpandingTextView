//
//  DMExpandingTextView.m
//
//  Created by Dylan Moore on 7/7/14.
//  Copyright (c) 2014 Dylan Moore. All rights reserved.
//
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

#import "DMExpandingTextView.h"

@implementation DMExpandingTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //self.delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textChanged)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:self];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textBeginEdit)
                                                     name:UITextViewTextDidBeginEditingNotification
                                                   object:self];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textDoneEdit)
                                                     name:UITextViewTextDidEndEditingNotification
                                                   object:self];
        
    }
    return self;
}



//Expanding code
-(void)textChanged{
    [self resize];
}

-(void)resize{
    CGRect newFrame = self.frame;
    newFrame.size.height = self.contentSize.height;
    self.frame = newFrame;
    [self layoutIfNeeded];
    
    if([self.delegate respondsToSelector:@selector(expandingTextViewResized)]){
        [self.delegate expandingTextViewResized];
    }
}




//Placeholder code
-(void)textBeginEdit{
    //Replace placeholder with editing color and no text
    [self setTextColor:self.editingTextColor];
    if([self.text isEqualToString:self.placeholderText]){
        [self setText:nil];
    }
}

-(void)textDoneEdit{
    //Replace with placeholder if no text
    NSString *text = [self.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if([text isEqualToString:@""]){
        [self setTextColor:self.placeholderTextColor];
        [self setText:self.placeholderText];
        
        if([self.delegate respondsToSelector:@selector(expandingTextViewShowingPlaceholder)]){
            [self.delegate expandingTextViewShowingPlaceholder];
        }
    }
}

-(void)showPlaceholder
{
    [self setText:self.placeholderText];
    self.textColor = self.placeholderTextColor;
    
    if([self.delegate respondsToSelector:@selector(expandingTextViewShowingPlaceholder)]){
        [self.delegate expandingTextViewShowingPlaceholder];
    }
}

- (void)dealloc
{
    // Stop listening when deallo cating your class:
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}






-(bool)showingPlaceholder
{
    return [self.text isEqualToString:self.placeholderText] ? YES:NO;
}

@end
