//
//  SignInVC.m
//  Doorbell_user
//
//  Created by My Star on 4/12/17.
//  Copyright © 2017 Doorbell. All rights reserved.
//

#import "SignInVC.h"
#import "RequestVC.h"
#import "PreProfileVC.h"
#import "ApiManager.h"
#import "Header.h"
#import "AdminModel.h"
#import <Toast/UIView+Toast.h>

@implementation SignInVC
- (void)viewDidLoad
{
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"ic_logo"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)onSign:(id)sender {
    if (_mTxtUserName.text.length > 0 && _mTxtPassword.text.length > 0){
        NSString *username = _mTxtUserName.text.lowercaseString;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:username,@"useremail", nil];
        [ApiManager onPostApi:loginEndPoint withDic:dic withCompletion:^(NSDictionary *dic) {
            NSMutableArray *arr = [NSMutableArray arrayWithArray:dic[@"data"]];
            NSLog(@"%@ %d",arr,(int)arr.count);
            if (arr.count < 1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [self.view makeToast:@"User doesn't exist. Please create an account" duration:2.0f position:CSToastPositionCenter];
                });
                return;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
           
            AdminModel *adminModel = [[AdminModel alloc] initWithDictionary:dic[@"data"][0] error:nil];
            NSLog(@"%@",adminModel);
            if (adminModel.passcode != nil) {
                if ([_mTxtPassword.text.lowercaseString isEqualToString:adminModel.passcode.lowercaseString]) {
                    [self.view makeToast:@"Successful!"];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [Utils saveAdminObject:adminModel key:ADMIN_MODEL];
                        [SharedRef instance].shareAdminModel = adminModel;
                        NSDictionary *updateDic = [NSDictionary dictionaryWithObjectsAndKeys:adminModel._id,@"userid",[SharedRef instance].devicetoken,@"devicetoken", nil];
                        [ApiManager onPostApi:update_admin_devicetoken withDic:updateDic withCompletion:^(NSDictionary *dic) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                if ([dic[@"status"] isEqualToString:@"success"]) {
                                    [self onGoPreProfileVC];
                                }else{
                                    [self onGoPreProfileVC];
                                }
                            });
                        } failure:^(NSError *error) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self onGoPreProfileVC];
                            });
                        }];
                        
                    });
                }else{
                     [self.view makeToast:@"Wrong password!" duration:2.0f position:CSToastPositionCenter];
                }
            }else{
                [self.view makeToast:@"Please enter email and password!" duration:2.0f position:CSToastPositionCenter];
               
            }
         });
        } failure:^(NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.view makeToast:@"User doesn't exist. Please create an account" duration:2.0f position:CSToastPositionCenter];
            });
        }];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view makeToast:@"Please enter email and password!" duration:2.0f position:CSToastPositionCenter];
        });
    }
}
- (void)onGoPreProfileVC{
    PreProfileVC  *preProfileVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"PreProfileVC"];
    [self.navigationController pushViewController:preProfileVC animated:YES];
}
- (IBAction)onForgotTapped:(id)sender {
    ForgotpassVC *forgotPassVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgotpassVC"];
    [self.navigationController pushViewController:forgotPassVC animated:YES];
}

@end
