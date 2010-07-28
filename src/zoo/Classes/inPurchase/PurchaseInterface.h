//
//  PurchaseInterface.h
//  tableList
//
//  Created by shen lancy on 10-7-22.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import <StoreKit/SKPaymentTransaction.h>
#import <UIKit/UIKit.h>

@interface MyStoreObserver : NSObject <UIAlertViewDelegate, SKPaymentTransactionObserver> {

	id				resultIdentifier;
	NSSet*			kMyfeatureIdentifier;
	BOOL			m_bObserverResult;
	void*			p_call_user;
	
	BOOL			m_bfirst_fail;
	BOOL			m_bfail;
	
	NSString*		m_NSPurchse;
}

@property(nonatomic, readwrite)BOOL m_bObserverResult;
@property(nonatomic, readwrite)BOOL m_bfail;

//购买接到信息
- (NSString*) PurchasedTransaction;
//交易成功
- (void) completeTransaction: (SKPaymentTransaction *)transaction;
//交易失败
- (void) failedTransaction: (SKPaymentTransaction *)transaction;
//存储交易
- (void) restoreTransaction: (SKPaymentTransaction *)transaction;

@end



@interface Purchase : UIView <SKProductsRequestDelegate> {
@private	
	//MyStoreObserver * observer;
	NSSet *  kMyFeatureIdentifier;
//	NSSet *  selectProductId;
	//NSString * productId;
	bool b_result_open_store;
	
	NSString * m_BackInfor;
	/////////////////
	id displayTitle;
	id displayDesc;
	id displayPrice;
	////////////////
	BOOL b_Purchase_over;//判断此次交易是否完成
	BOOL b_Purchase_result;
	MyStoreObserver * observer;
	SKPayment *payment;
	SKMutablePayment * mutPayment;

	//是否显示内置用户窗口
//	BOOL b_display_userWin;
	bool b_dis_one;//显示第一次判断窗口
		
	NSString * str_id;//id
}

@property(nonatomic, retain) NSString* str_id;

-(void)showAlertView;
+ (Purchase*)sharedManager;
-(void)initPurchase;
-(void)removePurchase;

-(void)requestProductData;
-(void)CheckSendPayments;
-(void)showStore;
-(void)OpenStore;
//-(void)SetProuductID:(NSString *)prouductId;
-(void)BeginBuyProduct;

//调用添加交易业务函数,productId:为选择的产品Id,buy_count:购买的数量
-(void) addMutPayment:(NSString*)productId buyCount:(int)add_index;

-(BOOL)getResult;
-(BOOL)checkIsOver;
//-(void)PurchaseOver;

//-(BOOL) connectedToNetWork;

-(NSString*)BackInformation;

//-(void)VerifyPay:(SKPaymentTransaction *)transaction;

@end