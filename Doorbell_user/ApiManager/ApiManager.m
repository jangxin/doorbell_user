//
//  ApiManager.m
//  Doorbell_user
//
//  Created by My Star on 4/14/17.
//  Copyright © 2017 Doorbell. All rights reserved.
//

#import "ApiManager.h"

@implementation ApiManager
+ (void)onGetCurrencyRate:(NSString *)baseCur withCompletion:(void (^)(NSDictionary *dic))completion failure:(void (^)(NSError *error))failure
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:nil delegateQueue: [NSOperationQueue mainQueue]];
    NSString *strURL = [NSString stringWithFormat:@"%@=%@",@"http://api.fixer.io/latest?base",baseCur];
    NSURL * url = [NSURL URLWithString:strURL];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    NSData *postData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:&error];
//    [request setHTTPBody:postData];
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary* json = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  options:kNilOptions
                                  error:&error];
            
            NSLog(@"%@", json[@"rates"]);
            
            completion(json[@"rates"]);
        }else{
            failure(error);
        }
        
    } ];
    
    
    [dataTask resume];
}
+ (void)onPostApi:(NSString *)endPoint withDic:(NSDictionary *)body withCompletion:(void (^)(NSDictionary *))completion failure:(void (^)(NSError *))failure
{
    NSDictionary *headers = @{ @"content-type": @"application/json"};
    NSData *postData;
    if (body == nil) {
        postData = nil;
    }else {
        postData = [NSJSONSerialization dataWithJSONObject:body options:0 error:nil];
    }
     NSString *strURL = [NSString stringWithFormat:@"%@%@",baseURL,endPoint];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strURL]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                        NSLog(@"%@", data);
                                                        failure(error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        NSLog(@"%@", data);
                                                        NSDictionary* json = [NSJSONSerialization
                                                                              JSONObjectWithData:data
                                                                              options:kNilOptions
                                                                              error:&error];
                                                        completion(json);
                                                        NSLog(@"Result json  %@", json);
                                                    }
                                                }];
    [dataTask resume];
 
}
@end
