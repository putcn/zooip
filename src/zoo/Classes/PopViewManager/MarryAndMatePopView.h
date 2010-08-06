//
//  MarryAndMatePopView.h
//  zoo
//
//  Created by AlexLiu on 8/6/10.
//  Copyright 2010 Alex Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "popViewManager.h"
#import "Common.h"


@interface MarryAndMatePopView : NSObject {
	
	popViewManager*		myPopView;
	int					tabFlag;
	NSString            *currentTagFlag;
	NSString            *tabFlagType;
	NSString            *managementType;
	
}


- (id) init;

- (void) btnShopButtonHandler;
- (void) resultCallback:(NSObject *)value;
- (void) faultCallback:(NSObject *)value;

@end
