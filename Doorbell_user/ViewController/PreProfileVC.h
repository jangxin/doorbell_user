//
//  PreProfileVC.h
//  Doorbell_user
//
//  Created by My Star on 4/12/17.
//  Copyright © 2017 Doorbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdminModel.h"
#import "UserModel.h"
#import "ApiManager.h"
#import "Header.h"
#import "CompanyModel.h"
#import <Toast/UIView+Toast.h>
#import "Utils.h"
#import "SignInVC.h"
@interface PreProfileVC : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *mImgPic;
@property (weak, nonatomic) IBOutlet UILabel *mlblName;
@property (weak, nonatomic) IBOutlet UILabel *mlblContent;
@property (weak, nonatomic) IBOutlet UILabel *mlblRequestTitle;
@property (weak, nonatomic) IBOutlet UIImageView *mImgTab;
@property CompanyModel *companyModel;
@end
