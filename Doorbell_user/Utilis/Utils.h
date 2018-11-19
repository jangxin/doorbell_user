//
//  Utils.h
//  Doorbell_user
//
//  Created by My Star on 4/15/17.
//  Copyright © 2017 Doorbell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"
#import "AdminModel.h"
#import "UserModel.h"
#import "CompanyModel.h"
#import "SharedRef.h"
@interface Utils : NSObject
+ (void)saveUserModel:(NSDictionary *)userModel;
+ (Utils*) instance;
+ (void)saveAdminObject:(AdminModel *)object key:(NSString *)key;
+ (AdminModel *)loadAdminObjectWithKey:(NSString *)key;
+ (void)resetDefaults;
+ (NSDictionary *)convertModeltoDic:(AdminModel *)adminModel;
@end
