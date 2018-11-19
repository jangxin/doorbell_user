//
//  SignInVC.h
//  Doorbell_user
//
//  Created by My Star on 4/12/17.
//  Copyright © 2017 Doorbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "Utils.h"
#import "ProfileVC.h"
#import "ForgotpassVC.h"
@interface SignInVC : UIViewController
@property (weak, nonatomic) IBOutlet CustomTextField *mTxtUserName;
@property (weak, nonatomic) IBOutlet CustomTextField *mTxtPassword;

@end
