//
//  OfficeTimeVC.m
//  Doorbell_user
//
//  Created by My Star on 5/18/17.
//  Copyright © 2017 Doorbell. All rights reserved.
//

#import "OfficeTimeVC.h"

@interface OfficeTimeVC ()
{
    
    NSString *strWeekChoose;
    Boolean isMo;
    Boolean isTu;
    Boolean isWe;
    Boolean isTh;
    Boolean isFr;
    Boolean isSa;
    Boolean isSu;
    
    Boolean isFrom;
    Boolean isTo;
}
@end

@implementation OfficeTimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [_mTimePicker setDate:[NSDate date]];
    _mTimePicker.datePickerMode = UIDatePickerModeTime;
    [_mTimePicker addTarget:self action:@selector(updatetimes:) forControlEvents:UIControlEventValueChanged];
    [_mTimePicker setHidden:YES];

    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initValue];
    [self initView];
    [self initViewTime];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)updatetimes:(id)sender{
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"HH"];
     if (isFrom) {
         if ([[dateFormater stringFromDate:self.mTimePicker.date] integerValue] > 12) {
             _mLblFromTime.text = [NSString stringWithFormat:@"%@ PM",[dateFormater stringFromDate:self.mTimePicker.date]];
         }else{
             _mLblFromTime.text = [NSString stringWithFormat:@"%@ AM",[dateFormater stringFromDate:self.mTimePicker.date]];
         }
    }else{
        if ([[dateFormater stringFromDate:self.mTimePicker.date] integerValue] > 12) {
            _mLblToTime.text = [NSString stringWithFormat:@"%@ PM",[dateFormater stringFromDate:self.mTimePicker.date]];
        }else{
            _mLblToTime.text = [NSString stringWithFormat:@"%@ AM",[dateFormater stringFromDate:self.mTimePicker.date]];
        }
    }
    [_mTimePicker setHidden:YES];
    [self setValueTime];
    
}
- (void)initValue{
    if (![[SharedRef instance].shareAdminModel.strweekavailable isEqualToString:@""] && [SharedRef instance].shareAdminModel.strweekavailable != nil) {
        NSMutableArray *arrStr = [NSMutableArray array];
        for (int i = 0; i < [[SharedRef instance].shareAdminModel.strweekavailable length]; i++) {
            NSString *ch = [[SharedRef instance].shareAdminModel.strweekavailable substringWithRange:NSMakeRange(i, 1)];
            [arrStr addObject:ch];
        }
        if ([arrStr[0] isEqualToString:@"M"]) {
            isMo = true;
        }else{
            isMo = false;
        }
        
        if ([arrStr[1] isEqualToString:@"T"]) {
            isTu = true;
        }else{
            isTu = false;
        }
        
        if ([arrStr[2] isEqualToString:@"W"]) {
            isWe = true;
        }else{
            isWe = false;
        }
        
        if ([arrStr[3] isEqualToString:@"H"]) {
            isTh = true;
        }else{
            isTh = false;
        }
        if ([arrStr[4] isEqualToString:@"F"]) {
            isFr = true;
        }else{
            isFr = false;
        }
        if ([arrStr[5] isEqualToString:@"A"]) {
            isSa = true;
        }else{
            isSa = false;
        }
        if ([arrStr[6] isEqualToString:@"U"]) {
            isSu = true;
        }else{
            isSu = false;
        }
        
    }else{
        [SharedRef instance].shareAdminModel.strweekavailable  = @"OOOOOOO";
        isMo = false;
        isTu = false;
        isWe = false;
        isTh = false;
        isFr = false;
        isSa = false;
        isSu = false;
    }
}
- (void)initView{
    if (isMo)
    {
        [_mViewMo setBackgroundColor:customgraycolor];
    }else{
        [_mViewMo setBackgroundColor:[UIColor clearColor]];
    }
    
    if (isTu)
    {
        [_mViewTu setBackgroundColor:customgraycolor];
    }else{
        [_mViewTu setBackgroundColor:[UIColor clearColor]];
    }
    if (isWe)
    {
        [_mViewWe setBackgroundColor:customgraycolor];
    }else{
        [_mViewWe setBackgroundColor:[UIColor clearColor]];
    }
    if (isTh)
    {
       [_mViewTh setBackgroundColor:customgraycolor];
    }else{
        [_mViewTh setBackgroundColor:[UIColor clearColor]];
    }
    if (isFr)
    {
        [_mViewFr setBackgroundColor:customgraycolor];
    }else{
        [_mViewFr setBackgroundColor:[UIColor clearColor]];
    }
    
    if (isSa)
    {
        [_mViewSa setBackgroundColor:customgraycolor];
    }else{
        [_mViewSa setBackgroundColor:[UIColor clearColor]];
    }
    if (isSu)
    {
        [_mViewSu setBackgroundColor:customgraycolor];
    }else{
        [_mViewSu setBackgroundColor:[UIColor clearColor]];
    }
    

        
        
}
- (void)initViewTime{
    if ([[SharedRef instance].shareAdminModel.officetime_from isEqualToString:@""])
    {
        _mLblFromTime.text  = @"00 AM";
    }else{
        
        if ([[SharedRef instance].shareAdminModel.officetime_from intValue] > 12)
        {
            _mLblFromTime.text = @"";
            _mLblFromTime.text = [NSString stringWithFormat:@"%@ PM",[SharedRef instance].shareAdminModel.officetime_from];
        }else{
            _mLblFromTime.text = @"";
            _mLblFromTime.text = [NSString stringWithFormat:@"%@ AM",[SharedRef instance].shareAdminModel.officetime_from];
        }
    }
    
    if ([[SharedRef instance].shareAdminModel.officetime_to isEqualToString:@""])
    {
        _mLblToTime.text = @"23 PM";
    }else{
        
        if ([[SharedRef instance].shareAdminModel.officetime_to intValue] > 12)
        {
            _mLblToTime.text = @"";
            
            _mLblToTime.text = [NSString stringWithFormat:@"%@ PM",[SharedRef instance].shareAdminModel.officetime_to];
        }else{
            _mLblToTime.text = @"";
            _mLblToTime.text = [NSString stringWithFormat:@"%@ AM",[SharedRef instance].shareAdminModel.officetime_to];
        }
        
        
    }
}
- (void)setValueTime{
     if ([_mLblFromTime.text isEqualToString:@""])
     {
         [SharedRef instance].shareAdminModel.officetime_from = @"00";
     }else{
         [SharedRef instance].shareAdminModel.officetime_from = [_mLblFromTime.text componentsSeparatedByString:@" "].firstObject;
     }
     
     if ([_mLblToTime.text isEqualToString:@""])
     {
         [SharedRef instance].shareAdminModel.officetime_to = @"23";
     }else{
         
         [SharedRef instance].shareAdminModel.officetime_to = [_mLblToTime.text componentsSeparatedByString:@" "].firstObject;
     }
    NSLog(@"AdminModel %@ %@" ,[SharedRef instance].shareAdminModel.officetime_to,[SharedRef instance].shareAdminModel.officetime_from);
}
- (IBAction)onFromTimeChooseTapped:(id)sender {
    isFrom = true;
    isTo = false;
    [_mTimePicker setHidden:NO];
}
- (IBAction)onToTimeChooseTapped:(id)sender {
    isFrom = false;
    isTo = true;
    [_mTimePicker setHidden:NO];
}
- (IBAction)onMoChooseTapped:(id)sender {
    if (isMo) {
        isMo = !isMo;
    }else{
        isMo = !isMo;
    }
    NSString *strTemp = [SharedRef instance].shareAdminModel.strweekavailable;
    if (isMo)
    {
        [SharedRef instance].shareAdminModel.strweekavailable = [strTemp stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"M"];
    }else{
        [SharedRef instance].shareAdminModel.strweekavailable = [strTemp stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"O"];
    }
    [self initView];
    NSLog(@"AdminModel %@",[SharedRef instance].shareAdminModel.strweekavailable);
}
- (IBAction)onTuChooseTapped:(id)sender {
    if (isTu) {
        isTu = !isTu;
    }else{
        isTu = !isTu;
    }
    [self initView];
    NSString *strTemp = [SharedRef instance].shareAdminModel.strweekavailable;
    
    if (isTu)
    {
        [SharedRef instance].shareAdminModel.strweekavailable = [strTemp stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"T"];
    }else{
        [SharedRef instance].shareAdminModel.strweekavailable = [strTemp stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"O"];
    }
    NSLog(@"AdminModel %@",[SharedRef instance].shareAdminModel.strweekavailable);
    
}
- (IBAction)onWeChooseTapped:(id)sender {
    if (isWe) {
        isWe = !isWe;
    }else{
        isWe = !isWe;
    }
    [self initView];
    NSString *strTemp = [SharedRef instance].shareAdminModel.strweekavailable;
    if (isWe)
    {
        [SharedRef instance].shareAdminModel.strweekavailable = [strTemp stringByReplacingCharactersInRange:NSMakeRange(2, 1) withString:@"W"];
    }else{
        [SharedRef instance].shareAdminModel.strweekavailable = [strTemp stringByReplacingCharactersInRange:NSMakeRange(2, 1) withString:@"O"];
    }
    NSLog(@"AdminModel %@",[SharedRef instance].shareAdminModel.strweekavailable);
    
}
- (IBAction)onThChooseTapped:(id)sender {
    if (isTh) {
        isTh = !isTh;
    }else{
        isTh = !isTh;
    }
    [self initView];
    NSString *strTemp = [SharedRef instance].shareAdminModel.strweekavailable;
    if (isTh)
    {
        [SharedRef instance].shareAdminModel.strweekavailable =  [strTemp stringByReplacingCharactersInRange:NSMakeRange(3, 1) withString:@"H"];
    }else{
        [SharedRef instance].shareAdminModel.strweekavailable = [strTemp stringByReplacingCharactersInRange:NSMakeRange(3, 1) withString:@"O"];
    }
    NSLog(@"AdminModel %@",[SharedRef instance].shareAdminModel.strweekavailable);
    
}
- (IBAction)onFrChooseTapped:(id)sender {
    if (isFr) {
        isFr = !isFr;
    }else{
        isFr = !isFr;
    }
    [self initView];
    NSString *strTemp = [SharedRef instance].shareAdminModel.strweekavailable;
    if (isFr)
    {
        [SharedRef instance].shareAdminModel.strweekavailable =  [strTemp stringByReplacingCharactersInRange:NSMakeRange(4, 1) withString:@"F"];
    }else{
        [SharedRef instance].shareAdminModel.strweekavailable = [strTemp stringByReplacingCharactersInRange:NSMakeRange(4, 1) withString:@"O"];
    }
    NSLog(@"AdminModel %@",[SharedRef instance].shareAdminModel.strweekavailable);
}
- (IBAction)onSaChooseTapped:(id)sender {
    if (isSa) {
        isSa = !isSa;
    }else{
        isSa = !isSa;
    }
    [self initView];
    NSString *strTemp = [SharedRef instance].shareAdminModel.strweekavailable;
    if (isSa)
    {
        [SharedRef instance].shareAdminModel.strweekavailable =  [strTemp stringByReplacingCharactersInRange:NSMakeRange(5, 1) withString:@"A"];
    }else{
        [SharedRef instance].shareAdminModel.strweekavailable = [strTemp stringByReplacingCharactersInRange:NSMakeRange(5, 1) withString:@"O"];
    }
    NSLog(@"AdminModel %@",[SharedRef instance].shareAdminModel.strweekavailable);
}
- (IBAction)onSuChooseTapped:(id)sender {
    if (isSu) {
        isSu = !isSu;
    }else{
        isSu = !isSu;
    }
    [self initView];
    NSString *strTemp = [SharedRef instance].shareAdminModel.strweekavailable;
    if (isSu)
    {
        [SharedRef instance].shareAdminModel.strweekavailable =  [strTemp stringByReplacingCharactersInRange:NSMakeRange(6, 1) withString:@"U"];
    }else{
        [SharedRef instance].shareAdminModel.strweekavailable = [strTemp stringByReplacingCharactersInRange:NSMakeRange(6, 1) withString:@"O"];
    }
    NSLog(@"AdminModel %@",[SharedRef instance].shareAdminModel.strweekavailable);
}
- (IBAction)onBackTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)onUpdateUserModelInfo{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ApiManager onPostApi:updateEndPoint withDic:[Utils convertModeltoDic:[SharedRef instance].shareAdminModel] withCompletion:^(NSDictionary *dic) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([dic[@"status"] isEqualToString:@"success"]) {
                [self.view makeToast:@"Successful!" duration:2.0f position:CSToastPositionCenter];
                [Utils saveAdminObject:[SharedRef instance].shareAdminModel key:ADMIN_MODEL];
            }else{
                [self.view makeToast:network_error_msg];
            }
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view makeToast:error.localizedDescription];
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
}
- (IBAction)onDoneTapped:(id)sender {
    [self onUpdateUserModelInfo];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
