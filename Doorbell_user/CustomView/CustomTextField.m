//
//  CustomTextField.m
//  Doorbell_user
//
//  Created by My Star on 4/12/17.
//  Copyright © 2017 Doorbell. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField
- (id)initWithCoder:(NSCoder *)coder
{
    // Call the parent implementation of initWithCoder
    self = [super initWithCoder:coder];
    self.delegate = self;
    [self setupTxt];
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setupTxt];
    self.delegate = self;
    return self;
}
- (void)setupTxt{
    self.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
//    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.height, 10)];
//    self.leftView = paddingView;
//    self.leftViewMode = UITextFieldViewModeAlways;
    self.layer.cornerRadius = 5;
    self.clipsToBounds = true;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 0.0;
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
@end
