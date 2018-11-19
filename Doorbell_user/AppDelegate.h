//
//  AppDelegate.h
//  Doorbell_user
//
//  Created by My Star on 4/12/17.
//  Copyright © 2017 Doorbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ApiManager.h"
#import "SharedRef.h"
#import "UserModel.h"
#import "Utils.h"
#import "SignInVC.h"
#import "PreProfileVC.h"
#import "ProfileVC.h"
#import "AdminModel.h"
#import "MainVC.h"
#import <CoreLocation/CoreLocation.h>
#import "SharedRef.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "IQKeyboardManager.h"
@import Firebase;

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>
@property CLLocationManager *locationManager;
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

