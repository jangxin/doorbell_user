//
//  AppDelegate.m
//  Doorbell_user
//
//  Created by My Star on 4/12/17.
//  Copyright © 2017 Doorbell. All rights reserved.
//

#import "AppDelegate.h"
#import <OneSignal/OneSignal.h>


@interface AppDelegate ()
{
    Boolean isGetLocation;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [FIRApp configure];
    
    /////FireBase Notification
    UIUserNotificationType allNotificationTypes =
    (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
    
    UIUserNotificationSettings *settings =
    [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tokenRefreshNotification:) name:kFIRInstanceIDScopeFirebaseMessaging  object:nil];
    [self getUsers];
//    [self gotoView];
    isGetLocation = false;
    [self initLocationManager];
    [Fabric with:@[[Crashlytics class]]];
    [IQKeyboardManager sharedManager].enable = true;
    
    [OneSignal setLogLevel:ONE_S_LL_VERBOSE visualLevel:ONE_S_LL_WARN];
    
    // (Optional) - Create block the will fire when a notification is recieved while the app is in focus.
    id notificationRecievedBlock = ^(OSNotification *notification) {
        NSLog(@"Received Notification - %@", notification.payload.notificationID);
    };
    
    // (Optional) - Create block that will fire when a notification is tapped on.
    id notificationOpenedBlock = ^(OSNotificationOpenedResult *result) {
        OSNotificationPayload* payload = result.notification.payload;
        
        NSString* messageTitle = @"OneSignal Example";
        NSString* fullMessage = [payload.body copy];
        
        if (payload.additionalData) {
            
            if (payload.title)
                messageTitle = payload.title;
            
            if (result.action.actionID)
                fullMessage = [fullMessage stringByAppendingString:[NSString stringWithFormat:@"\nPressed ButtonId:%@", result.action.actionID]];
        }
        
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:messageTitle
                                                            message:fullMessage
                                                           delegate:self
                                                  cancelButtonTitle:@"Close"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    };
    
    // (Optional) - Configuration options for OneSignal settings.
    id oneSignalSetting = @{kOSSettingsKeyInFocusDisplayOption : @(OSNotificationDisplayTypeNotification), kOSSettingsKeyAutoPrompt : @YES};
    
    
    
    // (REQUIRED) - Initializes OneSignal
    [OneSignal initWithLaunchOptions:launchOptions
                               appId:@"95660c2c-a151-4cc5-9675-86cc29ba5924"
          handleNotificationReceived:notificationRecievedBlock
            handleNotificationAction:notificationOpenedBlock
                            settings:oneSignalSetting];
    OneSignal.inFocusDisplayType = OSNotificationDisplayTypeNotification;
    [OneSignal promptForPushNotificationsWithUserResponse:^(BOOL accepted) {
        NSLog(@"Accepted Notifications?: %d", accepted);
    }];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [Utils saveAdminObject:[SharedRef instance].shareAdminModel key:ADMIN_MODEL];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [Utils saveAdminObject:[SharedRef instance].shareAdminModel key:ADMIN_MODEL];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [Utils saveAdminObject:[SharedRef instance].shareAdminModel key:ADMIN_MODEL];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [self saveContext];
}
#pragma mark FireBase Pushnotification
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    [application registerForRemoteNotifications];
}
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString * token = [NSString stringWithFormat:@"%@", deviceToken];
    //Format token as you need:
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    OSPermissionSubscriptionState* status = [OneSignal getPermissionSubscriptionState];
    [SharedRef instance].devicetoken = status.subscriptionStatus.userId;
    NSLog(@"deviceToken: %@", token);
    [[FIRInstanceID instanceID] setAPNSToken:deviceToken type:FIRInstanceIDAPNSTokenTypeSandbox];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"Received Notifications = %@", userInfo);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSLog(@"Received Notifications = %@", userInfo);
    
    UILocalNotification *localnotification = [[UILocalNotification alloc] init];
    localnotification.userInfo = userInfo;
    localnotification.soundName = UILocalNotificationDefaultSoundName;
    #if TARGET_OS_SIMULATOR
        localnotification.alertBody = userInfo[@"aps"];
    #else
        localnotification.alertBody = userInfo[@"alert"];
    #endif
    localnotification.fireDate  = [NSDate  date];
    [[UIApplication sharedApplication] scheduleLocalNotification:localnotification];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[UIApplication sharedApplication].applicationIconBadgeNumber + 1];
    completionHandler(UIApplicationBackgroundFetchIntervalNever);
 
}
- (void)tokenRefreshNotification:(NSNotification *)notification {
    // Note that this callback will be fired everytime a new token is generated, including the first
    // time. So if you need to retrieve the token as soon as it is available this is where that
    // should be done.
    NSString *refreshedToken = [[FIRInstanceID instanceID] token];
    NSLog(@"InstanceID token: %@", refreshedToken);
    
    // Connect to FCM since connection may have failed when attempted before having a token.
    [self connectToFcm];
    
    // TODO: If necessary send token to appliation server.
}
- (void)connectToFcm {
//    [[FIRMessaging messaging] connectWithCompletion:^(NSError * _Nullable error) {
//        if (error != nil) {
//            NSLog(@"Unable to connect to FCM. %@", error);
//        } else {
//            NSLog(@"Connected to FCM.");
//        }
//    }];
}
- (void)initLocationManager{
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [_locationManager startUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations lastObject];
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    if (!isGetLocation){
        
        [clGeoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (error){
                NSLog(@"Errors %@",error);
            }else{
                NSLog(@"PlaceMarks %@",placemarks);
                CLPlacemark *clPlaceMark = [placemarks objectAtIndex:0];
                NSString *isoCode = clPlaceMark.ISOcountryCode;
                if ([[SharedRef instance].dictCountryCodes objectForKey:isoCode]) {
                    [SharedRef instance].mFlag =  [UIImage imageNamed: [NSString stringWithFormat:@"CountryPicker.bundle/%@",isoCode]];
                    [SharedRef instance].strCountryCode = [NSString stringWithFormat:@"+%@",[[SharedRef instance].dictCountryCodes objectForKey:isoCode][1]];
                    _locationManager.delegate = self;
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeCountry" object:nil];
                    isGetLocation = true;
                }
                NSString *countryName = clPlaceMark.country;
                NSLog(@"%@ %@",isoCode,countryName);
            }
            
            
            
        }];
    }
    [SharedRef instance].strLat = [NSString stringWithFormat:@"%2f",location.coordinate.latitude];
    [SharedRef instance].strLong = [NSString stringWithFormat:@"%2f",location.coordinate.longitude];
}

- (void)getUsers{
    [ApiManager onPostApi:getusers withDic:nil withCompletion:^(NSDictionary *dic) {
        for (NSDictionary *tmpdic in dic[@"data"])
        {
            [[SharedRef instance].arrUsers addObject:[[UserModel alloc] initWithDictionary:tmpdic error:nil]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self gotoView];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}
- (void)gotoView{
    AdminModel *adminModel = [[AdminModel alloc] init];
    adminModel =[Utils loadAdminObjectWithKey:ADMIN_MODEL] ;
    if (adminModel != nil) {
        [SharedRef instance].shareAdminModel = adminModel;
//        if ([adminModel.admin_status isEqualToString:@"Inactive"])
//        {
//            [self gotoPreProfileView];
//        }else{
//            [self gotoProfileView];
//        }
        [self gotoPreProfileView];
    }else{
        [self gotoSignView];
    }
}
- (void)gotoPreProfileView{
    PreProfileVC *preProfileVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PreProfileVC"]; //or the homeController
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:preProfileVC];
    self.window.rootViewController = navController;
}
- (void)gotoProfileView{
    ProfileVC *profileController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProfileVC"]; //or the homeController
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:profileController];
    self.window.rootViewController = navController;
}
- (void)gotoSignView{
    MainVC *mainVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainVC"]; //or the homeController
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:mainVC];
    self.window.rootViewController = navController;
}
#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "app.Doorbell_user" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Doorbell_user" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Doorbell_user.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
