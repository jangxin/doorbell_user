//
//  Utils.m
//  Doorbell_user
//
//  Created by My Star on 4/15/17.
//  Copyright © 2017 Doorbell. All rights reserved.
//

#import "Utils.h"

@implementation Utils
-(id)init
{
    self =[super init];
    return self;
}
+(Utils*) instance
{
    static Utils *instance =nil;
    if(instance ==nil){
        instance =[[Utils alloc]init];
    }
    return instance;
}
#pragma mark Save and Read a Usermodel
+ (void)saveUserModel:(NSDictionary *)userModel
{
    [[NSUserDefaults standardUserDefaults] setObject:userModel forKey:USER_MODEL];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (void)saveAdminObject:(AdminModel *)object key:(NSString *)key {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
    [defaults synchronize];
    
}

+ (AdminModel *)loadAdminObjectWithKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    AdminModel *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}
+ (void)resetDefaults {
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
}
+ (NSDictionary *)convertModeltoDic:(AdminModel *)adminModel
{
    NSDictionary *body = [NSDictionary dictionaryWithObjectsAndKeys:
                          adminModel.passcode , Passcode
                          ,adminModel.admin_phone ,Admin_phone
                          ,adminModel.admin_email ,Admin_email
                          ,adminModel.admin_name  ,Admin_name
                          ,adminModel.user_id,         User_id
                          ,adminModel.admin_company_id      ,Admin_company_id
                          ,adminModel.admin_company_name , Admin_company_name
                          ,adminModel.admin_logo,Admin_logo
                          ,adminModel.admin_status,Admin_status,
                          adminModel._id,Admin_ID,
                          adminModel.email_noti_set ,Email_noti_set,
                          adminModel.sms_noti_set, Sms_noti_set,
                          adminModel.officetime_from , Officetime_from,
                          adminModel.officetime_to,Officetime_to,
                          adminModel.strweekavailable,Strweekavailable,
                          [SharedRef instance].strLat ,Lat ,
                          [SharedRef instance].strLong , Llong,
                          
                          nil];
    NSLog(@"Update Body %@",body);
    return body;
}
@end
