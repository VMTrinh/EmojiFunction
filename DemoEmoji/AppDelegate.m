//
//  AppDelegate.m
//  DemoEmoji
//
//  Created by Mai Trinh on 10/12/15.
//  Copyright © 2015 EBIZWORLD. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreData+MagicalRecord.h>
#import "Emoji.h"
#import "CategoryEmoji.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
{
    NSMutableArray *myCategory;
    NSMutableArray *myEmoji;
    NSMutableArray *myEmoji1;
    NSMutableArray *myEmoji2;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /*
     Init Core Data
     */
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"DemoEmoji"];
    
    [CategoryEmoji MR_truncateAll];
    [Emoji MR_truncateAll];
    
    //Init Category
    myCategory = [[NSMutableArray alloc] init];
    [myCategory addObject:@"emoji_1.png"];
    [myCategory addObject:@"emoji_3.png"];
    [myCategory addObject:@"emoji_5.png"];
    for (int i = 0; i < myCategory.count; i++) {
        CategoryEmoji *category = [CategoryEmoji MR_createEntity];
        category.nameCategory = [myCategory objectAtIndex:i];
        [MagicalRecord saveUsingCurrentThreadContextWithBlockAndWait:nil];
    }
    //Init Emoji
    myEmoji = [[NSMutableArray alloc] init];
    [myEmoji addObject:@"emoji_1.png"];
    [myEmoji addObject:@"emoji_2.png"];
    for (int i = 0; i < myEmoji.count; i++) {
        Emoji *emoji = [Emoji MR_createEntity];
        emoji.name_emoji = [myEmoji objectAtIndex:i];
        emoji.category = [myCategory objectAtIndex:0];
        [MagicalRecord saveUsingCurrentThreadContextWithBlockAndWait:nil];
    }
    
    //Init Emoji 1
    myEmoji1 = [[NSMutableArray alloc] init];
    [myEmoji1 addObject:@"emoji_3.png"];
    [myEmoji1 addObject:@"emoji_4.png"];
    for (int i = 0; i < myEmoji1.count; i++) {
        Emoji *emoji = [Emoji MR_createEntity];
        emoji.name_emoji = [myEmoji1 objectAtIndex:i];
        emoji.category = [myCategory objectAtIndex:1];
        [MagicalRecord saveUsingCurrentThreadContextWithBlockAndWait:nil];
    }
    
    //Init Emoji 2
    myEmoji2 = [[NSMutableArray alloc] init];
    [myEmoji2 addObject:@"emoji_5.png"];
    [myEmoji2 addObject:@"emoji_6.png"];
    for (int i = 0; i < myEmoji2.count; i++) {
        Emoji *emoji = [Emoji MR_createEntity];
        emoji.name_emoji = [myEmoji2 objectAtIndex:i];
        emoji.category = [myCategory objectAtIndex:2];
        [MagicalRecord saveUsingCurrentThreadContextWithBlockAndWait:nil];
    }
    
    return YES;
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
