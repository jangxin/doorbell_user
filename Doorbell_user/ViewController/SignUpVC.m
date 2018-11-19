//
//  SignUpVC.m
//  Doorbell_user
//
//  Created by My Star on 4/12/17.
//  Copyright © 2017 Doorbell. All rights reserved.
//

#import "SignUpVC.h"
@interface SignUpVC()
{
    NSString *user_ID;
    NSString *company_ID;
}
@end
@implementation SignUpVC
- (void)viewDidLoad
{
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"ic_logo"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self initValues];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onReceiveNotification:) name:@"ChangeCountry" object:nil];
    
}
- (void)onReceiveNotification:(NSNotification *)notification{
    _mImgFlag.image = [SharedRef instance].mFlag;
    _mTxtPhone.text = [SharedRef instance].strCountryCode;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ChangeCountry" object:nil];
}
- (void)initValues{
    user_ID = @"";
    company_ID = @"";
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _mImgFlag.image = [SharedRef instance].mFlag;
    _mTxtPhone.text = [SharedRef instance].strCountryCode;
    [self getUsers];
}
- (void)getUsers{
    [ApiManager onPostApi:getusers withDic:nil withCompletion:^(NSDictionary *dic) {
        [SharedRef instance].arrUsers = [NSMutableArray array];
        for (NSDictionary *tmpdic in dic[@"data"])
        {
            [[SharedRef instance].arrUsers addObject:[[UserModel alloc] initWithDictionary:tmpdic error:nil]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}
- (void)getCompamies:(NSString *)userID{
    [SharedRef instance].arrCompanies = [NSMutableArray array];
    if (userID != nil && userID.length > 0) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:userID,@"user_id", nil];
        [ApiManager onPostApi:getcompanies withDic:dic withCompletion:^(NSDictionary *dic) {
            dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
                NSMutableArray *arrtemp = [NSMutableArray arrayWithArray:dic[@"data"]];
                if (arrtemp.count > 0) {
                    for (NSDictionary *tmpdic in dic[@"data"])
                    {
                        [[SharedRef instance].arrCompanies addObject:[[CompanyModel alloc] initWithDictionary:tmpdic error:nil]];
                    }
                    
                    [self.view addSubview:[self makeCompaniesTableView:(CGFloat)[SharedRef instance].arrCompanies.count * 40.0f]];
                    CompanyModel *companyModel = [SharedRef instance].arrCompanies[0];
                    self.mTxtCompanies.text  = companyModel.company_name;
                }else{
                   [self.view makeToast:@"There is no any company. Please add your company first" duration:2.0f position:CSToastPositionCenter];
                }

            });
            
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:error.localizedDescription];
        }];
    }else{
        [self.view makeToast:@"Please select a user" duration:2.0f position:CSToastPositionCenter];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [_mTblUsers setHidden:YES];
    [_mTblCompanies setHidden:YES];
}
- (IBAction)onCreateAdminTapped:(id)sender {
    [self onCreateAdminModel];
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark makeCurrencyTable
-(UITableView *)makeCompaniesTableView:(CGFloat)realheight{
    CGFloat x = _mTxtCompanies.frame.origin.x;
    CGFloat y = _mTxtCompanies.frame.origin.y + _mTxtCompanies.frame.size.height;
    CGFloat width = _mTxtCompanies.frame.size.width;
    CGRect tableViewFrame = CGRectMake(x, y, width, realheight);
    _mTblCompanies = [[UITableView alloc] initWithFrame:tableViewFrame];
    _mTblCompanies.delegate  = self;
    _mTblCompanies.dataSource = self;
    _mTblCompanies.backgroundColor  = [UIColor whiteColor];
    _mTblCompanies.estimatedRowHeight = 55.0f;
    _mTblCompanies.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    return _mTblCompanies;
}
-(UITableView *)makeUsersTableView:(CGFloat)realheight{
    CGFloat x = _mTxtUserID.frame.origin.x;
    CGFloat y = _mTxtUserID.frame.origin.y + _mTxtUserID.frame.size.height;
    CGFloat width = _mTxtUserID.frame.size.width;
    CGRect tableViewFrame = CGRectMake(x, y, width, realheight);
    _mTblUsers = [[UITableView alloc] initWithFrame:tableViewFrame];
    _mTblUsers.delegate  = self;
    _mTblUsers.dataSource = self;
    _mTblUsers.backgroundColor  = [UIColor whiteColor];
    _mTblUsers.estimatedRowHeight = 55.0f;
    _mTblUsers.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    return _mTblUsers;
}
- (IBAction)onShowUsersList:(id)sender {
    if ([SharedRef instance].arrUsers.count>0){
        [self.view addSubview:[self makeUsersTableView:(CGFloat)[SharedRef instance].arrUsers.count * 40.0f]];
    }else{
        [self.view makeToast:@"Can not connect to server!" duration:2.0f position:CSToastPositionCenter];
    }
}
- (IBAction)onShowCompaniesList:(id)sender {
    if (_mTxtUserID.text.length > 0){
        NSString * userid = [NSString stringWithFormat:@"%@%@",[_mTxtUserID.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]],@".doorbell.as"];
        NSLog(@"%@", [SharedRef instance].arrUsers);
        for (UserModel *tmpUserModel in [SharedRef instance].arrUsers){
            if ([userid.lowercaseString isEqualToString:tmpUserModel.username.lowercaseString]){
                user_ID = tmpUserModel._id;
                break;
            }
        }
        if (user_ID.length > 0) {
            [self getCompamies:user_ID];
            
        }else{
            [self.view makeToast:@"Please select doorbell domain first!" duration:2.0f position:CSToastPositionCenter];
        }
    }else{
        [self.view makeToast:@"Please select doorbell domain first!" duration:2.0f position:CSToastPositionCenter];
    }
}
#pragma mark TableView Datasource & delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.mTblUsers) {
        return [SharedRef instance].arrUsers.count;
    }else{
        return [SharedRef instance].arrCompanies.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *expensesCellID = @"ExpensesCell";
    UITableViewCell *expensesCell = [tableView dequeueReusableCellWithIdentifier:expensesCellID];
    
    if (!expensesCell) {
        expensesCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:expensesCellID];
    }
    expensesCell.selectionStyle = UITableViewCellSelectionStyleDefault;
    expensesCell.selected = NO;

    if (tableView == self.mTblUsers) {
        UserModel *userModel = [[UserModel alloc] init];
        userModel = [SharedRef instance].arrUsers[indexPath.row];
        expensesCell.textLabel.text = userModel.username;
    }else{
        CompanyModel *companyModel = [[CompanyModel alloc] init];
        companyModel = [SharedRef instance].arrCompanies[indexPath.row];
        expensesCell.textLabel.text = companyModel.company_name;
    }
    return expensesCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

        return 40.0f;  
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (tableView == self.mTblUsers) {
        UserModel *userModel = [[UserModel alloc] init];
        userModel = [SharedRef instance].arrUsers[indexPath.row];
        _mTxtUserID.text = userModel.username;
        user_ID = userModel._id;
        
        [self.mTblUsers setHidden:YES];
    }else{
        CompanyModel *companyModel = [[CompanyModel alloc] init];
        companyModel = [SharedRef instance].arrCompanies[indexPath.row];
        _mTxtCompanies.text = companyModel.company_name;
        company_ID = companyModel._id;
        [self.mTblCompanies setHidden:YES];
    }
    [self.mTblUsers setHidden:YES];
    [self.mTblCompanies setHidden:YES];
    
}
- (void)onCreateAdminModel{
    if (_mTxtCompanies.text.length > 0 && _mTxtUserID.text.length > 0 && _mTxtName.text.length > 0 && _mTxtEmail.text.length > 0 && _mTxtPhone.text.length > 4 && _mTxtPassword.text.length > 0) {
        NSDictionary *body = [NSDictionary dictionaryWithObjectsAndKeys:
            _mTxtPassword.text.lowercaseString , Passcode
            ,_mTxtPhone.text.lowercaseString ,Admin_phone
            ,_mTxtEmail.text.lowercaseString ,Admin_email
            ,_mTxtName.text.lowercaseString  ,Admin_name
            ,user_ID,         User_id
            ,company_ID      ,Admin_company_id
            ,_mTxtCompanies.text.lowercaseString , Admin_company_name
            ,@"https://firebasestorage.googleapis.com/v0/b/doorbell-1cf1b.appspot.com/o/download.jpg?alt=media&amp;token=08a56f13-ec75-4056-a1ba-d6fd4422931b",Admin_logo
            ,@"Inactive",Admin_status,
             @"01" , Officetime_from,
             @"23" , Officetime_to,
             @"MTWHFAU",Strweekavailable,
             @"on",Sms_noti_set,
             @"on",Email_noti_set,
            [SharedRef instance].strLat ,Lat ,
            [SharedRef instance].strLong , Llong,
            [SharedRef instance].devicetoken   ,@"devicetoken",nil];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [ApiManager onPostApi:signupEndPoint withDic:body withCompletion:^(NSDictionary *dic) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([dic[@"status"] isEqualToString:@"success"]) {
                    [self.view makeToast:@"Successful!" duration:2.0f position:CSToastPositionCenter];
                    [Utils saveAdminObject:[[AdminModel alloc] initWithDictionary:body error:nil] key:ADMIN_MODEL];
                    [SharedRef instance].shareAdminModel = [[AdminModel alloc] initWithDictionary:body error:nil];
                    [self onGoPreProfileVC];
                }else if([dic[@"status"] isEqualToString:@"user_exist"]){
                    [self.view makeToast:@"User already exist." duration:2.0f position:CSToastPositionCenter];
                }else{
                    [self.view makeToast:network_error_msg];
                }
            });
        } failure:^(NSError *error) {
             [self.view makeToast:error.localizedDescription];
        }];
    }else{
        [self.view makeToast:@"Please fill all of field." duration:2.0f position:CSToastPositionCenter];
    }
}
- (void)onGoPreProfileVC{
    PreProfileVC  *preProfileVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"PreProfileVC"];
    [self.navigationController pushViewController:preProfileVC animated:YES];
}
@end
