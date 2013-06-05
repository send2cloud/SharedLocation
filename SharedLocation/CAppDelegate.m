//
//  CAppDelegate.m
//  SharedLocation
//
//  Created by every2003 on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CAppDelegate.h"

@implementation CAppDelegate

@synthesize window = _window;
@synthesize location;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    location.x = 0.0f;
    location.y = 0.0f;
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_4_2)
{
    NSLog(@"Notified URL: %@", [url query]);
    NSString* strQuery = [url query];
    NSRange latDec = [strQuery rangeOfString:@","];
    NSString* strLat = [strQuery substringWithRange:NSMakeRange(2, latDec.location - 2)];
    NSString* strLon = [strQuery substringFromIndex:latDec.location + latDec.length];
    location.x = [strLat floatValue];
    location.y = [strLon floatValue];

    return YES;
}

@end
