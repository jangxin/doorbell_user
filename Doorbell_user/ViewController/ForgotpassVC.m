//
//  ForgotpassVC.m
//  Doorbell_user
//
//  Created by My Star on 5/30/17.
//  Copyright © 2017 Doorbell. All rights reserved.
//

#import "ForgotpassVC.h"

@interface ForgotpassVC ()

@end

@implementation ForgotpassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onResetpassTapped:(id)sender {
    if (_mTxtEmail.text.length > 0 && [_mTxtEmail.text rangeOfString:@"@"].location != NSNotFound) {
        NSString *email = [_mTxtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [self callForgotPassword:email.lowercaseString];
        
    }
}
- (void)callForgotPassword :(NSString *)strEmail{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:strEmail,@"email", nil];
    [ApiManager onPostApi:forgotpass withDic:dic withCompletion:^(NSDictionary *dic) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([dic[@"status"] isEqualToString:@"success"]) {
                [self.view makeToast:@"Successful" duration:2.0f position:CSToastPositionCenter];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self.view makeToast:network_error_msg duration:2.0f position:CSToastPositionCenter];
            }
        });
    } failure:^(NSError *error) {
        [self.view makeToast:error.localizedDescription duration:2.0f position:CSToastPositionCenter];
    }];
}
- (IBAction)onBackTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
