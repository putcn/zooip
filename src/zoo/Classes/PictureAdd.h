//
//  PictureAdd.h
//  zoo
//
//  Created by jiang ziwei on 10-8-2.
//  Copyright 2010 shandongligong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDigest.h"
static inline NSString *md5Encode( NSString *str ) {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    NSString *string = [NSString stringWithFormat:
						@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
						result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
						result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
						];
    return [string lowercaseString];
}

@interface PictureAdd : NSObject {
	UIImageView *imgView;
	NSString *imageURL;
	NSOperationQueue *requestDataQueue;
}
- (id)initWithPicUrl:(NSString *)aImageURL;
- (NSString *) cachedUrlImage:(NSString*)url;
- (void)setImage:(UIImage *)img;
- (void) cacheUrlImage:(NSString *)url image:(UIImage*)image;
@end



@interface PictureAddDataOperation : NSOperation {
	PictureAdd *cell;
}
- (id)initWithCell:(PictureAdd *)cell;
@end