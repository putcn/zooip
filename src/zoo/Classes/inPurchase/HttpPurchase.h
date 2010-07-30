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
	BOOL				connectOver;
	NSMutableDictionary*callBacks;
}

@property(nonatomic, readwrite)int clientProtocol;
@property(nonatomic, readwrite)BOOL connectOver;
@property(nonatomic, retain) NSDictionary* callBacks;

+ (HttpPurchase *)sharedPurchase;

- (void) RequestParams:(NSDictionary*)params;
- (void) getStoreList;
- (void) storeChk;

@end
