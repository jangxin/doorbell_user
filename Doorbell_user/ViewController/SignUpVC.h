//
//  SignUpVC.h
//  Doorbell_user
//
//  Created by My Star on 4/12/17.
//  Copyright © 2017 Doorbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "CustomButton.h"
#import "Utils.h"
#import "UserModel.h"
#import "ApiManager.h"
#import <Toast/UIView+Toast.h>
#import "SharedRef.h"
#import "MBProgressHUD.h"
#import "PreProfileVC.h"
#import "SharedRef.h"
@interface SignUpVC : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property UITableView *mTblCompanies;
@property UITableView *mTblUsers;

@property (weak, nonatomic) IBOutlet UIView *mNavView;


@property (weak, nonatomic) IBOutlet CustomTextField *mTxtUserID;
@property (weak, nonatomic) IBOutlet CustomTextField *mTxtCompanies;
@property (weak, nonatomic) IBOutlet CustomTextField *mTxtName;
@property (weak, nonatomic) IBOutlet CustomTextField *mTxtEmail;
@property (weak, nonatomic) IBOutlet CustomTextField *mTxtPhone;
@property (weak, nonatomic) IBOutlet CustomTextField *mTxtPassword;
@property (weak, nonatomic) IBOutlet CustomButton *mBtnSignUp;
@property (weak, nonatomic) IBOutlet UIImageView *mImgFlag;

@end
