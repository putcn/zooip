//
//  AddAnimalsPopView.h
//  zoo
//
//  Created by AlexLiu on 8/5/10.
//  Copyright 2010 Alex Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "popViewManager.h"
#import "Common.h"


@interface AddAnimalsPopView : NSObject {

	popViewManager*		myPopView;
	int					tabFlag;
	NSString            *currentTagFlag;
	
}


- (id) init;

- (void) btnShopButtonHandler;
- (void) resultCallback:(NSObject *)value;
- (void) faultCallback:(NSObject *)value;
- (void)initWithBtn:(NSArray *)arrayBtn Title:(NSArray*)arrayTitle;
- (void) topBtnSelected:(id)sender;

@end
