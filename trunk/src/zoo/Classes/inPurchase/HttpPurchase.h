//
//  HttpPurchase.h
//  zoo
//
//  Created by shen lancy on 10-7-27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


enum ClientProtocol{
	
	MJBank_Store_Protocol = 0,
	Server_Chk
};

@interface HttpPurchase : NSObject<UIAlertViewDelegate> {

	NSURLConnection*	connection;
	NSMutableData*		receivedData;
	int					clientProtocol;
}

@property(nonatomic, readwrite)int clientProtocol;

- (void) getStoreList;
- (void) storeChk;

@end
