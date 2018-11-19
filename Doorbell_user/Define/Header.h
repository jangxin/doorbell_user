//
//  Header.h
//  Doorbell_user
//
//  Created by My Star on 4/12/17.
//  Copyright © 2017 Doorbell. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define mainStorageRef [[FIRStorage storage] referenceForURL:@"gs://doorbell-1cf1b.appspot.com"]

#define customgraycolor [UIColor colorWithRed:78.0f/255.0f green:86.0f/255.0f blue:85.0f/255.0f alpha:1.0f]

#define main_color          @"#1aa094"
#define main_back_color     @"#4e5655"
#define baseURL             @"http://139.59.189.226:3000/admin/"
#define baseImgURL             @"http://139.59.189.226:3000"
//#define baseURL             @"http://192.168.1.79:3000/admin/"
//#define baseImgURL             @"http://192.168.1.79:3000"


#define  update_admin_devicetoken @"update_admin_devicetoken"
#define loginEndPoint       @"get_single_admin_name"
#define getusers            @"get_users"
#define getcompanies        @"get_company_backend"
#define get_single_company  @"get_single_company"
#define signupEndPoint      @"post_adminfromphone"
#define forgotpass          @"forgotpassword_admin"
#define updateEndPoint      @"update_admin"
#define USER_TABLE          @"USER_TABLE"
#define ADMIN_MODEL         @"ADMIN_MODEL"
#define USER_MODEL          @"USER_MODEL"


#define network_error_msg    @"Can't connect server!"

#define Admin_company_id    @"admin_company_id"
#define Admin_company_name  @"admin_company_name"
#define Admin_email         @"admin_email"
#define Admin_logo          @"admin_logo"
#define Admin_name          @"admin_name"
#define Admin_phone         @"admin_phone"
#define Admin_status        @"admin_status"
#define Passcode            @"passcode"

#define Email_noti_set      @"email_noti_set"
#define Sms_noti_set        @"sms_noti_set"

#define Officetime_from     @"officetime_from"
#define Officetime_to       @"officetime_to"
#define Strweekavailable    @"strweekavailable"
#define User_id             @"user_id"
#define __V                 @"__v"
#define _Id                 @"_id"

#define Lat                 @"latitude"
#define Llong               @"longitude"

#define Address             @"address"

#define Company_name        @"company_name"
#define Company_email       @"company_email"
#define Company_logo        @"company_logo"
#define Company_statu       @"company_statu"

#define Admin_ID            @"admin_id"

#endif /* Header_h */
