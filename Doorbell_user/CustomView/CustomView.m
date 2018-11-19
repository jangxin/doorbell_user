//
//  CustomView.m
//  Doorbell_user
//
//  Created by My Star on 5/18/17.
//  Copyright © 2017 Doorbell. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (id)initWithCoder:(NSCoder *)coder
{
    // Call the parent implementation of initWithCoder
    self = [super initWithCoder:coder];
    [self setupView];
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}
- (void)setupView{
    self.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    self.layer.cornerRadius = 10;
    self.clipsToBounds = true;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 2.0;
}

@end
