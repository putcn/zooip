//
//  PurchaseToolbar.h
//  zoo
//
//  Created by shen lancy on 10-7-23.
//  Copyright 2010 __Lancy__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Button.h"
#import "MessageDialog.h"
#import "tableListViewController.h"
#import "HttpPurchase.h"

@interface PurchaseToolbar : CCSprite{
	
	tableListViewController *purchaseTable;
	NSString *localMark;
	
}

@end
