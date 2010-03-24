//
//  main.m
//  zoo
//
//  Created by Niu Darcy on 3/24/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
	NSAutoreleasePool *pool = [NSAutoreleasePool new];
	int retVal = UIApplicationMain(argc, argv, nil, @"zooAppDelegate");
	[pool release];
	return retVal;
}
