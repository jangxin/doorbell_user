//
//  ApiManager.h
//  Doorbell_user
//
//  Created by My Star on 4/14/17.
//  Copyright © 2017 Doorbell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdminModel.h"
#import "CompanyModel.h"
#import "Header.h"

@interface ApiManager : NSObject
+ (void)onPostApi:(NSString *)endPoint withDic:(NSDictionary *)body withCompletion:(void (^)(NSDictionary *dic))completion failure:(void (^)(NSError *error))failure;
@end
