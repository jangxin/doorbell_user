//
//  ProfileVC.h
//  Doorbell_user
//
//  Created by My Star on 4/12/17.
//  Copyright © 2017 Doorbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"
#import "SignInVC.h"
#import "MainVC.h"
#import "CustomTextField.h"
#import "Header.h"
#import "CustomButton.h"
#import "ApiManager.h"
#import "MBProgressHUD.h"
#import <Toast/UIView+Toast.h>
#import <PopupDialog/PopupDialog-Swift.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <Photos/Photos.h>
#import "OfficeTimeVC.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "UserModel.h"

@import Firebase;
@import FirebaseAuth;
@import FirebaseStorage;
@interface ProfileVC : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property UIImage *imgUserPIC;
@property (weak, nonatomic) IBOutlet UIButton *mBtnChangeName;
@property (weak, nonatomic) IBOutlet UILabel *mLblChangename;
@property (weak, nonatomic) IBOutlet UIButton *mBtnChangePhone;
@property (weak, nonatomic) IBOutlet UILabel *mLblChangePhone;
@property (weak, nonatomic) IBOutlet UISwitch *mSwhSMS;
@property (weak, nonatomic) IBOutlet UISwitch *mSwhNotification;
@property (weak, nonatomic) IBOutlet UIButton *mBtnChangePIC;
@property (weak, nonatomic) IBOutlet UIButton *mBtnChangePass;
@property (weak, nonatomic) IBOutlet UILabel *mLblChangeEmail;

@property (weak, nonatomic) IBOutlet UILabel *mLblTitle;
@property (weak, nonatomic) IBOutlet UIButton *mBtnSetOfficeTime;
@property (weak, nonatomic) IBOutlet UIButton *mBtnChangeEmail;

@property (weak, nonatomic) IBOutlet UILabel *mLblCompanyName;
@property (weak, nonatomic) IBOutlet UIView *mViewChangePhone;
@property (weak, nonatomic) IBOutlet UIImageView *mImgFlag;
@property (weak, nonatomic) IBOutlet UITextField *mTxtPhone;
@property (weak, nonatomic) IBOutlet UIButton *mBtnOK;
@property (weak, nonatomic) IBOutlet UIButton *mBtnCancel;
@property (weak, nonatomic) IBOutlet UITableView *mTblCode;

@end
