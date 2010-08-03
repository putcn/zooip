//
//  PictureAdd.m
//  zoo
//
//  Created by jiang ziwei on 10-8-2.
//  Copyright 2010 shandongligong. All rights reserved.
//

#import "PictureAdd.h"


@implementation PictureAdd
- (id)initWithPicUrl:(NSString *)aImageURL setPointX:(int )x setPointY:(int )y 
{
	imageURL = aImageURL;
	
//	imageURL = @"http://fmn.xnimg.cn/fmn031/pic001/20090404/03/00/large_HxuW_3017i206109.jpg";
	
	imgView = [[UIImageView alloc] initWithFrame:CGRectMake(x,y,40,40)];
	imgView.transform = CGAffineTransformMakeRotation(M_PI * (90.0 / 180.0));
	[[[UIApplication sharedApplication]keyWindow]addSubview:imgView];
	imgView.tag = 999;
	[imgView release];
	
	NSString *original = [self cachedUrlImage:imageURL];
	
	if (nil == original) {
		UIImage *stubImage = [UIImage imageNamed:@"LOGO.png"];
		imgView.image = stubImage;
		if (requestDataQueue) {
			[requestDataQueue release];
		}
		requestDataQueue = [[NSOperationQueue alloc] init];
		PictureAddDataOperation *operation = [[PictureAddDataOperation alloc] initWithCell:self];
		[requestDataQueue addOperation:operation];
		[operation release];
		
	}
	else {
		UIImage *tempImage = [[UIImage alloc]initWithContentsOfFile:original];//@"/Users/magenius/Library/Application Support/iPhone Simulator/4.0/Applications/77152432-7523-4A8F-B178-E6DD11091346/Library/Caches/f04284e85e6158b5515d05e2eb59fdb8.jpg"];
		imgView.image = tempImage;//[UIImage imageWithContentsOfFile:@"/Users/magenius/Library/Application Support/iPhone Simulator/4.0/Applications/77152432-7523-4A8F-B178-E6DD11091346/Library/Caches/7b05b345a006f4a3e259c112e6a39313.jpg"];//[UIImage imageNamed:@"1.jpg"];//tempImage;
		[tempImage release];
	}
	return self;
}

- (void)setImagePoint:(int )x setPointY:(int )y
{
	imgView.frame = CGRectMake(x,  y, 40, 40);
//	imgView.image = nil;
}

- (void)setImage:(UIImage *)img{
	if(img == nil){
		return;
	}
	[self cacheUrlImage:imageURL image:img];
	imgView.image = img; //[UIImage imageNamed:@"1.jpg"];//
	
}
- (NSString *) cachedUrlImage:(NSString*)url
{
	if(!url)
		return nil;
	NSString * name = [NSString stringWithFormat:@"%@.jpg", md5Encode(url)];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *cachesDirectory = [paths objectAtIndex:0];
	NSString *ImageCache = [cachesDirectory stringByAppendingString:@"/ImageCache"];
	NSString* fullPathToFile = [ImageCache stringByAppendingPathComponent:name];
	
	if ([fileManager fileExistsAtPath:fullPathToFile] == YES){
		return fullPathToFile;
	}
	return nil;
}
- (void) cacheUrlImage:(NSString *)url image:(UIImage*)image{
	if(!url)return;
	
	NSString * name = [NSString stringWithFormat:@"%@.jpg", md5Encode(url)];
	
	//[[appDelegate.setupData objectForKey:@"imageBuffer"] setObject:url forKey:url];
	//[appDelegate.dataBase insertDataToBuffer:name value:UIImagePNGRepresentation(image)];
	
	
	NSData* imageData = UIImageJPEGRepresentation(image, 1.0);
	NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString* cachesDirectory = [paths objectAtIndex:0];
	NSString *ImageCache = [cachesDirectory stringByAppendingString:@"/ImageCache"];
	NSString* fullPathToFile = [ImageCache stringByAppendingPathComponent:name];
	[imageData writeToFile:fullPathToFile atomically:NO];
}

- (NSString *)getImageUrl{
	return imageURL;	
}

- (void)dealloc {

	[super dealloc];
}
@end




@implementation PictureAddDataOperation                                                                                            

- (id)initWithCell:(PictureAdd*) cellObj{
	if (self = [super init])
	{
		cell = [cellObj retain];
	}
	return self;
}

- (void)main {
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	//UIImage *img = [ImageUtil getImageWithURL:@"LOGO.png"];
	UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[cell getImageUrl]]]];
	[cell performSelectorOnMainThread:@selector(setImage:)
						   withObject:img
						waitUntilDone:YES];
	[img release];
	[pool release];
	
}
- (void)dealloc {
	//[img release];
	[cell release];
	[super dealloc];
}

@end