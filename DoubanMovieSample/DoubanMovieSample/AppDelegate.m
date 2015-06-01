//
//  AppDelegate.m
//  DoubanMovieSample
//
//  Created by lzhr on 15/3/13.
//  Copyright (c) 2015年 lzhr. All rights reserved.
//

#import "AppDelegate.h"
#import "MovieMainViewController.h"
#import "BaseNavigationViewController.h"
#import "FavoriteMoviesViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor redColor];
    [self.window makeKeyAndVisible];
    
    [_window release];
    
    
    NSLog(@"%@", [@"http://api.douban.com/movie/subject/3993588/photos?alt=json&apikey=0df993c66c0c636e29ecbb5344252a4a&app_name=doubanmovie&client=e%3AiPhone6%2C2%7Cy%3AiPhone%20OS_8.2%7Cs%3Amobile%7Cf%3Adoubanmovie_2%7Cv%3A3.6.3%7Cm%3A豆瓣电影%7Cudid%3Ad18a6cc8ac440a9d31f32fa5fe3ccfd675579c07&udid=d18a6cc8ac440a9d31f32fa5fe3ccfd675579c07&version=2" stringByRemovingPercentEncoding]);
    
    
    
    MovieMainViewController *movieMainVC = [[MovieMainViewController alloc] init];
    BaseNavigationViewController *movieNaviVC = [[BaseNavigationViewController alloc] initWithRootViewController:movieMainVC];
    
    FavoriteMoviesViewController *favorMoVC = [[FavoriteMoviesViewController alloc] initWithStyle:UITableViewStylePlain];
    
    BaseNavigationViewController *favorNaviVC = [[BaseNavigationViewController alloc] initWithRootViewController:favorMoVC];
    
    
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    tabBarVC.viewControllers = @[movieNaviVC, favorNaviVC];
    
    
    self.window.rootViewController = tabBarVC;
    
    [tabBarVC release];
    [movieNaviVC release];
    [movieMainVC release];
    [favorMoVC release];
    [favorNaviVC release];
    
    
    NSDictionary *dic = @{@"key":@"汉字", @"key2":@"测试"};
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    
    NSLog(@"%@", [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil] objectForKey:@"key"]);
    
    
    
    
    return YES;
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
