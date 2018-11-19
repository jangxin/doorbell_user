//
//  UserModel.h
//  Doorbell_user
//
//  Created by My Star on 4/15/17.
//  Copyright © 2017 Doorbell. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface UserModel : JSONModel
@property NSString<Optional> * _id;
@property NSString<Optional> *username;
@property NSString<Optional> *password;
@property NSString<Optional> *realname;
@property NSString<Optional> *phone;
@property NSString<Optional> *status;
@property NSString<Optional> *__v;
@end
