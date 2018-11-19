//
//  SharedRef.h
//  Doorbell_user
//
//  Created by My Star on 4/15/17.
//  Copyright © 2017 Doorbell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdminModel.h"
#import <UIKit/UIKit.h>
#import "UserModel.h"
@interface SharedRef : NSObject
@property NSMutableArray *arrUsers;
@property NSMutableArray *arrCompanies;
@property NSString *strLat;
@property NSString *strLong;
@property NSString *devicetoken;
@property AdminModel *shareAdminModel;
@property UserModel  *shareUserModel;
@property NSDictionary *dictCountryCodes;
@property NSString *strCountryCode;
@property NSString *strISOCode;
@property UIImage *mFlag;
+ (SharedRef *) instance;
@end
