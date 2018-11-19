//
//  RequestVC.m
//  Doorbell_user
//
//  Created by My Star on 4/12/17.
//  Copyright © 2017 Doorbell. All rights reserved.
//

#import "RequestVC.h"

@implementation RequestVC
-(void)viewDidLoad
{
    [self.navigationController.navigationBar setHidden:YES];
//    [self initView];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)loadView{
    
}
- (void)initView{
    _mImgPIC.layer.cornerRadius = 10;
    _mImgProPIC.layer.cornerRadius = _mImgProPIC.frame.size.width/2;
}
@end
