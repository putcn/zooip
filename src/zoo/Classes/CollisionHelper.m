//
//  CollisionHelper.m
//  zoo
//
//  Created by Niu Darcy on 5/24/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "CollisionHelper.h"

static const UInt32* collisionMap;
static int width;
static int height;

@implementation CollisionHelper

+(void)initCollisionMap
{
//	UIImage *collisionImage = [UIImage imageNamed:@"collision_map.png"];
	
//	width = (int)collisionImage.size.width;
//	height = (int)collisionImage.size.height;
	width = 1024;
	height = 768;
	//	
	//unsigned char *collisionMap = (unsigned char *)malloc(width * height);
	//memset( collisionMap, 0, width * height );
	
	//CFDataRef imageData = CGDataProviderCopyData(CGImageGetDataProvider(collisionImage.CGImage));
	//NSData *data = [NSData dataWithData:(NSData *)imageData];
	NSFileHandle *file;// = [NSFileHandle fileHandleForUpdatingAtPath:@"/Users/Rainbow/Desktop/data.txt"];
	//	[file writeData:data];
	//	[file closeFile];	
	NSString *fileName = @"collosion.txt";
	NSString *strPath = [[NSBundle mainBundle] pathForResource:[fileName lowercaseString] ofType:nil];
	file = [NSFileHandle fileHandleForReadingAtPath:strPath];
	NSData *newData = [file readDataToEndOfFile];
	[file closeFile];
	collisionMap = (const UInt32 *)CFDataGetBytePtr((CFDataRef)newData);

}

+(int)getMapType:(CGPoint)point isByte:(BOOL)isByte
{
 	int x = (int)point.x;
	int y = height - (int)point.y;
	UInt32 pixel =collisionMap[(y*width)+x];
	

	if (isByte == YES)
	{
		if ((pixel & 0xff000000) == 0) return 0x0000; // Limited ..
		if (pixel & 0x00ff0000) return 0x0001; // Sky ..
		if (pixel & 0x0000ff00) return 0x0010; // Water ..
		if (pixel & 0x000000ff) return 0x0100; // Land ..
		
		return 0x0000;
	}
	else
	{
		if ((pixel & 0xff000000) == 0) return -1; // Limited ..
		if (pixel & 0x00ff0000) return 0; // Sky ..
		if (pixel & 0x0000ff00) return 1; // Water ..
		if (pixel & 0x000000ff) return 2; // Land ..
		
		return -1;
	}
}

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	
	
	[super dealloc];
}



@end
