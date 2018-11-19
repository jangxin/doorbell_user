//
//  ProfileVC.m
//  Doorbell_user
//
//  Created by My Star on 4/12/17.
//  Copyright © 2017 Doorbell. All rights reserved.
//
#define namechange      1
#define phonechange     2
#define passchange_curr 3
#define passchange_new  4
#define emailchange     5
#import "ProfileVC.h"
#import "CodeCell.h"
@interface ProfileVC()<UITableViewDelegate,UITableViewDataSource>
{
    int tag;
    PopupDialog *popup;
}
@end
@implementation ProfileVC
-(void)viewDidLoad
{
    [self.navigationController.navigationBar setHidden:YES];
    [self initValues];
    NSLog(@"%@",[SharedRef instance].arrUsers);
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _mViewChangePhone.layer.borderWidth = 1.0;
    _mViewChangePhone.layer.borderColor = [[UIColor grayColor] CGColor];
    _mViewChangePhone.clipsToBounds = true;
    _mViewChangePhone.layer.cornerRadius = 2.0;
    [self setView:_mViewChangePhone hidden:YES];
    [self setView:_mTblCode hidden:YES];
    _mImgFlag.image = [SharedRef instance].mFlag ? [SharedRef instance].mFlag : [UIImage imageNamed:@"NO.png"];
}
- (void)initValues{
    tag = 0;
    _mLblChangename.text = [SharedRef instance].shareAdminModel.admin_name;
    _mLblChangePhone.text = [SharedRef instance].shareAdminModel.admin_phone;
    _mLblChangeEmail.text = [SharedRef instance].shareAdminModel.admin_email;
    if ([[SharedRef instance].shareAdminModel.email_noti_set isEqualToString:@"on"]) {
        [_mSwhNotification setOn:YES];
    }else{
        [_mSwhNotification setOn:NO];
    }
    _mLblCompanyName.text = [NSString stringWithFormat:@"You are connected to %@",[SharedRef instance].shareAdminModel.admin_company_name];
    if ([[SharedRef instance].shareAdminModel.sms_noti_set isEqualToString:@"on"]) {
        [_mSwhSMS setOn:YES];
    }else{
        [_mSwhSMS setOn:NO];
    }
    
    
}
- (void)setView:(UIView *)view hidden : (BOOL)hidden{
    [UIView transitionWithView:view duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [view setHidden:hidden];
    } completion:^(BOOL finished) {
        
    }];
}
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)onLogout:(id)sender {
    [Utils resetDefaults];
    MainVC *mainVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainVC"];
    [self.navigationController pushViewController:mainVC animated:YES];
}
- (IBAction)onChangePassTapped:(id)sender {
    tag = passchange_curr;
    [self onShowAlertView:@"Change password" withDes:@"Type in current password"];

}
- (IBAction)onChangePICTapped:(id)sender {
    [self onShowChangePICAlertView];
}
- (IBAction)onChangeNotifiSetting:(id)sender {
    UISwitch *btnSwitch = (UISwitch *)sender;
    if (btnSwitch.isOn) {
        [SharedRef instance].shareAdminModel.email_noti_set = @"on";
        [self onUpdateUserModelInfo];
    }else{
        [SharedRef instance].shareAdminModel.email_noti_set = @"off";
        [self onUpdateUserModelInfo];
    }
}
- (IBAction)onChangeSMSSetting:(id)sender {
    UISwitch *btnSwitch = (UISwitch *)sender;
    if (btnSwitch.isOn) {
        [SharedRef instance].shareAdminModel.sms_noti_set = @"on";
        [self onUpdateUserModelInfo];
    }else{
        [SharedRef instance].shareAdminModel.sms_noti_set = @"off";
        [self onUpdateUserModelInfo];
    }
}
- (IBAction)onSetOfficetimeTapped:(id)sender {
    OfficeTimeVC *officeTimeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OfficeTimeVC"];
    [self.navigationController pushViewController:officeTimeVC animated:YES];
}

- (IBAction)onChangePhoneTapped:(id)sender {
//    tag = phonechange;
//    [self onShowAlertView:_mLblChangePhone.text withDes:@"Edit phone number"];
//    [_mViewChangePhone setHidden:NO];
    [self setView:_mViewChangePhone hidden:NO];
    _mTxtPhone.text = _mLblChangePhone.text;
}
- (IBAction)onChangeNameTapped:(id)sender {
    tag = namechange;
    [self onShowAlertView:_mLblChangename.text withDes:@"Edit name"];
}
- (IBAction)onChnageEmailTapped:(id)sender {
    tag = emailchange;
    [self onShowAlertView:_mLblChangeEmail.text withDes:@"Edit email"];
}
- (void)onShowChangePICAlertView{
    popup = [[PopupDialog alloc] initWithTitle:@"Update  profile picture"
                                                    message:@"Select an option"
                                                      image:_imgUserPIC
                                            buttonAlignment:UILayoutConstraintAxisHorizontal
                                            transitionStyle:PopupDialogTransitionStyleBounceUp
                                           gestureDismissal:YES
                                                 completion:nil];
    
    DefaultButton *upload = [[DefaultButton alloc] initWithTitle:@"Confirm" height:40.0f dismissOnTap:YES action:^{
        dispatch_async(dispatch_get_main_queue(), ^{
           [self imageUpload:_imgUserPIC withTableName:@"UsersPhoto" withUserID:[SharedRef instance].shareAdminModel._id withCompletion:^(NSURL *downLoadURL) {
               [SharedRef instance].shareAdminModel.admin_logo = downLoadURL.absoluteString;
               [self onUpdateUserModelInfo];
           }];
        });
    }];
    DefaultButton *takePhoto = [[DefaultButton alloc] initWithTitle:@"Take photo" height:40.0f dismissOnTap:YES action:^{
        [self openPhotoPicker:UIImagePickerControllerSourceTypeCamera];
    }];
    
    DefaultButton *choosePhoto = [[DefaultButton alloc] initWithTitle:@"Choose photo" height:40.0f dismissOnTap:YES action:^{
        [self openPhotoPicker:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    [popup addButtons: @[upload, takePhoto, choosePhoto]];
    [self presentViewController:popup animated:YES completion:nil];

}

- (void)onShowAlertView:(NSString *)title withDes:(NSString *)description{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: title
                                                                              message: description
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = title;
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        if (tag == passchange_new || tag == passchange_curr) {
            textField.secureTextEntry = YES;
        }
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * txtField = textfields[0];
        NSLog(@"%@",txtField.text);
        [self onUpdateUserInfo:txtField.text];
    }]];

    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)onUpdateUserInfo:(NSString *)strValue
{
    switch (tag) {
        case namechange:
            [SharedRef instance].shareAdminModel.admin_name = strValue;
            [self onUpdateUserModelInfo];
            break;
        case passchange_curr:
            if ([self onCheckPassword:strValue]) {
                tag = passchange_new;
                [self onShowAlertView:@"Change password" withDes:@"New password"];
                
            }
            break;
        case passchange_new:
            [SharedRef instance].shareAdminModel.passcode = strValue;
            [self onUpdateUserModelInfo];
            break;
        case emailchange:
            [SharedRef instance].shareAdminModel.admin_email = strValue;
            [self onUpdateUserModelInfo];
            break;
        default:
            break;
    }
}
- (IBAction)onShowTblCodeView:(id)sender {
    [self setView:_mTblCode hidden:NO];
    [_mTblCode reloadData];
}
- (IBAction)onChangePhone:(id)sender {
    if(_mTxtPhone.text.length > 3){
        [SharedRef instance].shareAdminModel.admin_phone = _mTxtPhone.text;
//        [self setView:_mViewChangePhone hidden:YES];
        [UIView transitionWithView:_mViewChangePhone duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [_mViewChangePhone setHidden:YES];
        } completion:^(BOOL finished) {
            [self onUpdateUserModelInfo];
        }];
        
    }
}
- (IBAction)onChangeCancelTapped:(id)sender {
//    [_mViewChangePhone setHidden:YES];
    [self setView:_mViewChangePhone hidden:YES];
}

- (BOOL)onCheckPassword:(NSString *)passcode{
    if ([[SharedRef instance].shareAdminModel.passcode isEqualToString:passcode])
    {
        return true;
    }else{
        [self.view makeToast:@"Wrong password" duration:2.0f position:CSToastPositionCenter];
        return false;
    }
}
- (void)onUpdateUserModelInfo{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ApiManager onPostApi:updateEndPoint withDic:[Utils convertModeltoDic:[SharedRef instance].shareAdminModel] withCompletion:^(NSDictionary *dic) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([dic[@"status"] isEqualToString:@"success"]) {
                [Utils saveAdminObject:[SharedRef instance].shareAdminModel key:ADMIN_MODEL];
                [self initValues];
                [self.view makeToast:@"Successful"];
            }else{
                [self.view makeToast:network_error_msg];
            }
        });
    } failure:^(NSError *error) {
        [self.view makeToast:error.localizedDescription duration:2.0f position:CSToastPositionCenter];
    }];
}

- (void)openPhotoPicker:(UIImagePickerControllerSourceType)sourceType {
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
        if ([availableMediaTypes containsObject:(NSString *)kUTTypeImage]) {
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
            imagePickerController.sourceType = sourceType;
            imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
            imagePickerController.delegate = self;
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
    }
}
#pragma mark ImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *selecetdImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:^{
            _imgUserPIC = selecetdImage;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self onShowChangePICAlertView];
            });
            
        }];
        
    });
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark tableview delegate and datasource
#pragma makr UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [SharedRef instance].dictCountryCodes.allKeys.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CodeCell";
    CodeCell *cell = (CodeCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"CodeCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *allKeys = [[SharedRef instance].dictCountryCodes allKeys];
    NSArray *sortedKeys  = [allKeys sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSString *first = [[SharedRef instance].dictCountryCodes objectForKey:a][0];
        NSString *second = [[SharedRef instance].dictCountryCodes objectForKey:b][0];
        return [first compare:second];
    }];
    NSString *txtName = [[SharedRef instance].dictCountryCodes objectForKey:sortedKeys[indexPath.row]][0];
    NSString *txtCode = [[SharedRef instance].dictCountryCodes objectForKey:sortedKeys[indexPath.row]][1];
    NSString *imagePath = [NSString stringWithFormat:@"CountryPicker.bundle/%@", sortedKeys[indexPath.row]];
    cell.mLblName.text = [NSString stringWithFormat:@"%@ (%@)",txtName,sortedKeys[indexPath.row]];
    cell.mLblCode.text = [NSString stringWithFormat:@"+%@",txtCode];
    cell.mImgFlag.image = [UIImage imageNamed:imagePath];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CodeCell *codeCell = [tableView cellForRowAtIndexPath:indexPath];
    _mImgFlag.image = codeCell.mImgFlag.image;
    [SharedRef instance].mFlag = _mImgFlag.image;
    _mTxtPhone.text = codeCell.mLblCode.text;
    [self setView:_mTblCode hidden:YES];
    
}
#pragma mark signimage upload
- (void)imageUpload:(UIImage *)uploadImage withTableName:(NSString *)imageTatbleName withUserID:(NSString *)userID withCompletion:(void (^)(NSURL *downLoadURL))completion{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSData *imageData = UIImageJPEGRepresentation(uploadImage, 0.7);
    FIRStorageReference *storageRef = [mainStorageRef child:[NSString stringWithFormat:@"%@/%@.%@",imageTatbleName,userID,[self contentTypeForImageData:imageData]]];
    FIRStorageMetadata *metadata = [[FIRStorageMetadata alloc] init];
    metadata.cacheControl = @"public,max-age=300";
    metadata.contentType = @"image/jpeg";
    [storageRef putData:imageData metadata:metadata completion:^(FIRStorageMetadata * _Nullable metadata, NSError * _Nullable error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!error) {
            NSURL *downloadURL = metadata.downloadURL;
            completion(downloadURL);
            NSLog(@"DownLoad URL = %@",downloadURL);
        }else
        {
            NSLog(@"Error = %@",error);
        }
    }];
}
- (NSString *)contentTypeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
            break;
        case 0x42:
            return @"bmp";
        case 0x4D:
            return @"tiff";
    }
    return nil;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [self.mTblCode setHidden:YES];
}
@end
