//
//  AppDelegate.m
//  RSSchool.ios-stage-task-login
//
//  Created by JohnO on 04.07.2021.
//

#import "AppDelegate.h"
#import "Controllers/LoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	UIWindow *window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
	
	LoginViewController *rootVC = [[LoginViewController alloc] init];
	[window setRootViewController:rootVC];
	
	self.window = window;
	[self.window makeKeyAndVisible];
	
	return YES;
}


@end
