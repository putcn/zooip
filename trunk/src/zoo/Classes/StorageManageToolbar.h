//
//  StorageManageToolbar.h
//  Zoo
//
//  Created by Gu Lei on 10-4-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Button.h"
#import "ManageContainer.h"
#import "StorageContainer.h"

#import "ShopPopView.h"
#import "SaleEggsView.h"

@interface StorageManageToolbar : CCSprite
{
	ManageContainer *manageContainer;
	StorageContainer *storageContainer;
	
	ShopPopView*		shopPopView;
	
	SaleEggsView* saleEggsView;
}

-(void) addButton;
-(void) generatePage;
-(void) resultCallback:(NSObject *)value;
-(void) faultCallback:(NSObject *)value;

@end
