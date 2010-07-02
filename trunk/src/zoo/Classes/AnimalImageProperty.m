//
//  AnimalImageProperty.m
//  PLIST
//
//  Created by Hunk on 10-7-1.
//  Copyright 2010 Vanceinfo. All rights reserved.
//

#import "AnimalImageProperty.h"
#import "ImgInitUtil.h"


@implementation AnimalImageProperty

// Get animation table
-(NSMutableDictionary*)animationTable:(NSString*)imageName plistName:(NSString*)plistName
{
	// Init animation table
	NSMutableDictionary* aniTable = [[NSMutableDictionary alloc]init];
	
	// Get Range Flag
	NSRange rangeFlag = [plistName rangeOfString:@"."];
	
	// Get Left NSString
	NSRange pathForResourceRange;
	pathForResourceRange.location = 0;
	pathForResourceRange.length = rangeFlag.location;
	NSString* strBaseKey = [plistName substringWithRange:pathForResourceRange];
	
	// path of .plist
	NSString *strPath = [[NSBundle mainBundle] pathForResource:[plistName lowercaseString] ofType:nil];
	
	// Base dictionary
	NSDictionary* baseDictionary = [NSDictionary dictionaryWithContentsOfFile:strPath];
	
	
	// strBaseKey
//	NSRange baseKeyFlag = [strBaseKey rangeOfString:@"_"];
	NSRange pathForBaseKey;
	pathForBaseKey.location = 1;
	pathForBaseKey.length = [strBaseKey length] - 1;
	NSString* newBaseKey = [[strBaseKey substringWithRange:pathForBaseKey] lowercaseString];
	
	

	
	// Get all keys
	NSDictionary* allKeysDictionary = [baseDictionary objectForKey:newBaseKey];
	
	// Get max items
	NSString* strMaxItems = [allKeysDictionary objectForKey:@"maxItems"];
	NSInteger nMaxItems = [strMaxItems intValue];
	
	
	for(NSString* key in allKeysDictionary)
	{
		if(NO == [key isEqualToString:@"maxItems"])
		{
			// Action dictionary
			NSDictionary* actionDictionary = [allKeysDictionary objectForKey:key];
			
			// Get number
			NSString* strNum = [actionDictionary objectForKey:@"number"];
			// Change number to int value
			NSInteger nNumber = [strNum intValue];
			
			// Get originX
			NSString* strOriginX = [actionDictionary objectForKey:@"originX"];
			NSInteger nOriginX = [strOriginX intValue];
			
			// Get originY
			NSString* strOriginY = [actionDictionary objectForKey:@"originY"];
			NSInteger nOriginY = [strOriginY intValue];
			
			// Get width
			NSString* strWidth = [actionDictionary objectForKey:@"width"];
			NSInteger nWidth = [strWidth intValue];
			
			// Get originY
			NSString* strHeight = [actionDictionary objectForKey:@"height"];
			NSInteger nHeight = [strHeight intValue];
			
			if (nNumber == 1) {
				CCSprite* sprite = [[ImgInitUtil sharedImgInitUtil] getSprite:[imageName lowercaseString] setOriginX:nOriginX setOriginY:nOriginY setWidth:nWidth setHeight:nHeight setNumber:nNumber];
				[aniTable setObject:sprite forKey:key];
			}
			else if(nNumber > 1)
			{
				CCAnimation* animation = [[ImgInitUtil sharedImgInitUtil] getAnimate:[imageName lowercaseString] setOriginX:nOriginX setOriginY:nOriginY setWidth:nWidth setHeight:nHeight setNumber:nNumber setMaxOneline:nMaxItems];
				
				// Put animation into table
				[aniTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation]] forKey:key];						
			}
		}
	}
	return aniTable;
}



-(void)dealloc
{
	[super dealloc];
}

@end
