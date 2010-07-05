//
//  zooAppDelegate.h
//  zoo
//
//  Created by Niu Darcy on 3/24/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface zooAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow *window;
}

@property (nonatomic, retain) UIWindow *window;

- (BOOL)checkNetwork;

@end
