//
//  CustomButton.m
//  Doorbell_user
//
//  Created by My Star on 4/12/17.
//  Copyright © 2017 Doorbell. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton
- (id)initWithCoder:(NSCoder *)coder
{
    // Call the parent implementation of initWithCoder
    self = [super initWithCoder:coder];
    [self setupBtn];
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setupBtn];
    return self;
}
- (void)setupBtn{
    self.layer.cornerRadius = 5;
    self.clipsToBounds = true;

}
@end
