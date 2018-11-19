//
//  OfficeTimeVC.h
//  Doorbell_user
//
//  Created by My Star on 5/18/17.
//  Copyright © 2017 Doorbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ApiManager.h"
#import "SharedRef.h"
#import "UserModel.h"
#import "Utils.h"
#import "SignInVC.h"
#import "PreProfileVC.h"
#import "ProfileVC.h"
#import "AdminModel.h"
#import "MainVC.h"
#import <CoreLocation/CoreLocation.h>
#import "SharedRef.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "IQKeyboardManager.h"
#import "CustomView.h"
@interface OfficeTimeVC : UIViewController
@property (weak, nonatomic) IBOutlet UIView *mViewNav;
@property (weak, nonatomic) IBOutlet UIButton *mBtnback;
@property (weak, nonatomic) IBOutlet UIView *mViewFromTime;
@property (weak, nonatomic) IBOutlet UIButton *mBtnChooseFrom;
@property (weak, nonatomic) IBOutlet UILabel *mLblFromTime;



@property NSString *strWeekAvailable;

@property (weak, nonatomic) IBOutlet UIView *mViewToTime;
@property (weak, nonatomic) IBOutlet UILabel *mLblToTime;
@property (weak, nonatomic) IBOutlet UIButton *mBtnChooseTo;

@property (weak, nonatomic) IBOutlet UIView *mViewChooseWeek;
@property (weak, nonatomic) IBOutlet CustomView *mViewMo;
@property (weak, nonatomic) IBOutlet UIButton *mBtnChooseMo;


@property (weak, nonatomic) IBOutlet CustomView *mViewTu;
@property (weak, nonatomic) IBOutlet UIButton *mBtnChooseTu;



@property (weak, nonatomic) IBOutlet CustomView *mViewWe;
@property (weak, nonatomic) IBOutlet UIButton *mBtnChooseWe;


@property (weak, nonatomic) IBOutlet CustomView *mViewTh;
@property (weak, nonatomic) IBOutlet UIButton *mBtnChooseTh;


@property (weak, nonatomic) IBOutlet CustomView *mViewFr;
@property (weak, nonatomic) IBOutlet UIButton *mBtnChooseFr;

@property (weak, nonatomic) IBOutlet CustomView *mViewSa;
@property (weak, nonatomic) IBOutlet UIButton *mBtnChooseSa;

@property (weak, nonatomic) IBOutlet CustomView *mViewSu;
@property (weak, nonatomic) IBOutlet UIButton *mBtnChooseSu;


@property (weak, nonatomic) IBOutlet UIDatePicker *mTimePicker;

@end
