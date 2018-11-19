//
//  PreProfileVC.m
//  Doorbell_user
//
//  Created by My Star on 4/12/17.
//  Copyright © 2017 Doorbell. All rights reserved.
//

#import "PreProfileVC.h"
#import "ProfileVC.h"
#import "MBProgressHUD.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface PreProfileVC()
{
    NSTimer *timer;
}
@end
@implementation PreProfileVC
-(void)viewDidLoad
{
    [self initView];
    [self.navigationController.navigationBar setHidden:YES];
    [SharedRef instance].shareUserModel = [self chooseUserMode:[SharedRef instance].shareAdminModel.user_id];

    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initLoadData];
    timer = [NSTimer scheduledTimerWithTimeInterval:15.0f target:self selector:@selector(onUpdateUserModel) userInfo:nil repeats:YES];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [timer invalidate];
    timer = nil;
}
- (UserModel *)chooseUserMode : (NSString *)userid{
    UserModel *userModel = [[UserModel alloc] init];
    for (UserModel *tmpUserModel in [SharedRef instance].arrUsers){
        if ([tmpUserModel._id.lowercaseString isEqualToString:userid.lowercaseString]){
            userModel = tmpUserModel;
            break;
        }
    }
    return userModel;
}
- (void)initView{
    _mImgPic.clipsToBounds = YES;
    _mImgPic.layer.cornerRadius =10.0f;
    _mImgTab.clipsToBounds = YES;
    _mImgTab.layer.cornerRadius = _mImgTab.frame.size.width/2;
    
}
- (void)initLoadData{
            NSString *strURL =@"";
            if (![[SharedRef instance].shareAdminModel.admin_logo containsString:@"https"]) {
                strURL = [NSString stringWithFormat:@"%@%@",baseImgURL,[SharedRef instance].shareAdminModel.admin_logo];
            }else{
                strURL = [SharedRef instance].shareAdminModel.admin_logo;
            }
            if ([[SharedRef instance].shareAdminModel.admin_status isEqualToString:@"Active"]) {

                [self.mImgPic  sd_setImageWithURL:[NSURL URLWithString:strURL] placeholderImage:[UIImage imageNamed:@"ic_nouser"]];
                _mlblName.text = [SharedRef instance].shareAdminModel.admin_name;
                _mlblContent.text = [NSString stringWithFormat:@"You are connected to %@", [SharedRef instance].shareAdminModel.admin_company_name];
                _mlblRequestTitle.text = [SharedRef instance].shareAdminModel.admin_company_name;
                _mlblRequestTitle.textColor = [UIColor colorWithRed:26.0f/255.0f green:160.f/255.0f blue:158.0f/255.0f alpha:1.0f];
            }else{
                [self.mImgPic  sd_setImageWithURL:[NSURL URLWithString:strURL] placeholderImage:[UIImage imageNamed:@"ic_nouser"]];
                _mlblName.text = [SharedRef instance].shareAdminModel.admin_name;
                _mlblContent.text = @"A company administrator needs to accept your registration.";
                _mlblRequestTitle.text = [NSString stringWithFormat:@"Request sent to %@", [SharedRef instance].shareAdminModel.admin_company_name];
                _mlblRequestTitle.textColor = [UIColor colorWithRed:26.0f/255.0f green:160.f/255.0f blue:158.0f/255.0f alpha:1.0f];
            }

}
- (IBAction)onBack:(id)sender {
    if ([SharedRef instance].shareAdminModel != nil) {
        return;
    }
    MainVC *mainVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainVC"]; //or the homeController
    [Utils resetDefaults];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:mainVC];
    [[UIApplication sharedApplication].keyWindow setRootViewController:navController];

}
- (IBAction)onLogout:(id)sender {
    [Utils resetDefaults];
    MainVC *mainVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainVC"];
    [self.navigationController pushViewController:mainVC animated:YES];
}

- (void)onUpdateUserModel{
    if ([SharedRef instance].shareAdminModel != nil) {
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[SharedRef instance].shareAdminModel.admin_email,@"useremail", nil];
        [ApiManager onPostApi:loginEndPoint withDic:dic withCompletion:^(NSDictionary *dic) {
            NSMutableArray *arr = [NSMutableArray arrayWithArray:dic[@"data"]];
            NSLog(@"%@ %d",arr,(int)arr.count);
            if (arr.count < 1) {
                return;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [SharedRef instance].shareAdminModel = [[AdminModel alloc] initWithDictionary:dic[@"data"][0] error:nil];
                NSLog(@"%@",[SharedRef instance].shareAdminModel);
                [self initLoadData];
            });
        } failure:^(NSError *error) {
            NSLog(@"%@",error.localizedDescription);
        }];

    }else
    {
        return;
    }

}
- (IBAction)onProfileView:(id)sender {
        ProfileVC  *profileVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileVC"];
        profileVC.imgUserPIC = [[UIImage alloc] init];
        profileVC.imgUserPIC = _mImgPic.image;
        [self.navigationController pushViewController:profileVC animated:YES];
}
@end
