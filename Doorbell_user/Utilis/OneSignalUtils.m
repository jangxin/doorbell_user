//
//  OneSignalUtils.m
//  Doorbell_user
//
//  Created by SilverStar on 1/31/18.
//  Copyright © 2018 Doorbell. All rights reserved.
//

#import "OneSignalUtils.h"
#import <OneSignal/OneSignal.h>
@implementation OneSignalUtils
-(id)init
{
    self =[super init];
    return self;
}
+(OneSignalUtils *) instance
{
    static OneSignalUtils *instance =nil;
    if(instance ==nil){
        instance =[[OneSignalUtils alloc]init];
    }
    return instance;
}
+ (void)sendOneSignalNotification:(NSString *)oneSignalID withMessage:(NSString *)message{
    NSDate *strDate = [NSDate date];
    NSDictionary *msgBody = @{
                               @"contents" : @{@"en": message},
                               @"include_player_ids": @[oneSignalID],
                               @"ios_badgeType" : @"Increase",
                               @"ios_badgeCount" : @1,
                               @"send_after" : strDate
                               };
    [OneSignal postNotification:msgBody onSuccess:^(NSDictionary *result) {
        NSLog(@"OneSignal Push Notification Success -- > %@",result);
    } onFailure:^(NSError *error) {
        NSLog(@"OneSignal Push Notification Error --> %@", error.localizedDescription);
    }];
}
@end
