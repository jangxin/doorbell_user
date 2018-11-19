//
//  ForgotpassVC.h
//  Doorbell_user
//
//  Created by My Star on 5/30/17.
//  Copyright © 2017 Doorbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomView.h"
#import "CustomButton.h"
#import "CustomTextField.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "ApiManager.h"
#import "Header.h"
#import "Utils.h"
#import <Toast/UIView+Toast.h>

@interface ForgotpassVC : UIViewController
@property (weak, nonatomic) IBOutlet CustomTextField *mTxtEmail;
@property (weak, nonatomic) IBOutlet CustomButton *mBtnResetPass;

@end
