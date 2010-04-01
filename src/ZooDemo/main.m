//
//  main.m
//  ZooDemo
//
//  Created by Zhou Shuyan on 10-4-1.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
	NSAutoreleasePool *pool = [NSAutoreleasePool new];
	int retVal = UIApplicationMain(argc, argv, nil, @"ZooDemoAppDelegate");
	[pool release];
	return retVal;
}
