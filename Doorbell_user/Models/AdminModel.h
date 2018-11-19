//
//  AdminModel.h
//  Doorbell_user
//
//  Created by My Star on 4/14/17.
//  Copyright © 2017 Doorbell. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface AdminModel : JSONModel
@property NSString<Optional> * __v;
@property NSString<Optional> * _id;
@property NSString<Optional> * admin_company_id;
@property NSString<Optional> * admin_company_name;
@property NSString<Optional> * admin_email;
@property NSString<Optional> * admin_logo;
@property NSString<Optional> * admin_name;
@property NSString<Optional> * admin_phone;
@property NSString<Optional> * admin_status;
@property NSString<Optional> * user_id;
@property NSString<Optional> * passcode;
@property NSString<Optional> * distance;
@property NSString<Optional> *email_noti_set;
@property NSString<Optional> *sms_noti_set;
@property NSString<Optional> *officetime_from;
@property NSString<Optional> *officetime_to;
@property NSString<Optional> *strweekavailable;
@end
