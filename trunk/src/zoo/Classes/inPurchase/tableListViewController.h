//
//  tableListViewController.h
//  tableList
//
//  Created by shen lancy on 10-7-21.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "cocos2d.h" 
#import "ListTableCell.h"
#import "HttpPurchase.h"

@interface tableListViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource> {

	NSMutableArray*				purchaseId;
	NSMutableArray*				purchaseMsg;
	IBOutlet UITableView*		purchaseTableView;
	IBOutlet UIButton*			closeButton;
	IBOutlet UIView*			disableView;
	IBOutlet UIActivityIndicatorView* myActivity;
	
	NSTimer*					storeTimer;
	NSTimer*					listTimer;
	
	HttpPurchase*				httpPurchaseIn;
//	NSDictionary*				dic;
}

@property(nonatomic, retain) NSMutableArray* purchaseId;
@property(nonatomic, retain) NSMutableArray* purchaseMsg;

- (void)configureCell:(ListTableCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (IBAction)closePurchase:(id)sender;

- (void)isPurchaseOver:(id)sender;
- (void)isConnectOver:(id)sender;

- (void)openConnect;

@end

