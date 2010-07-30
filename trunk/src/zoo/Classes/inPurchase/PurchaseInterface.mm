//
//  PurchaseInterface.m
//  tableList
//
//  Created by shen lancy on 10-7-22.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PurchaseInterface.h"

@interface MyStoreObserver (SubviewFrames)
+ (NSString*) encode:(const uint8_t*) input length:(NSInteger) length;
- (void) VerifyPay:(SKPaymentTransaction *)transaction;
- (void) provideContent:(NSString*) productIdentifier;
- (void) showAlertView;
@end

@implementation MyStoreObserver

@synthesize m_bObserverResult, m_bfail;

//购买提交是否完成
- (void) paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
	
	// 商品进入购买流程
	for (SKPaymentTransaction* transaction in transactions)  {  
		switch (transaction.transactionState)  { 
			case SKPaymentTransactionStatePurchasing:
				NSLog(@"the transaction is begining:");
				break;
			case SKPaymentTransactionStatePurchased: 
				NSLog(@"the transaction is end!");
				[self completeTransaction:transaction];  
				break;  
			case SKPaymentTransactionStateFailed: 
				NSLog(@"the transaction is failed!");
				[self failedTransaction:transaction];  
				break;  
			case SKPaymentTransactionStateRestored: 
				NSLog(@"the transaction is restored!");
				[self restoreTransaction:transaction];
				break;  
			default:  
				break;  
		}  
	} 
}

//购买接到信息
- (NSString*) PurchasedTransaction{
	
	return m_NSPurchse;
}

//交易成功
- (void) completeTransaction: (SKPaymentTransaction *)transaction{
	
	[self VerifyPay:transaction];
	[self provideContent: transaction.originalTransaction.payment.productIdentifier];
	[[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

//交易失败
- (void) failedTransaction: (SKPaymentTransaction *)transaction{
	
	if (transaction.error.code != SKErrorPaymentCancelled)
		[self showAlertView];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

//存储交易
- (void) restoreTransaction: (SKPaymentTransaction *)transaction{
	
	[self VerifyPay:transaction];
    [self provideContent: transaction.originalTransaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

//批量购买成功
- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue{

}

//批量购买失败
- (void) paymentQueue:(SKPaymentQueue *) paymentQueue restoreCompletedTransactionsFailedWithError:(NSError *)error{
	
}

-(void)VerifyPay:(SKPaymentTransaction *)transaction{
		
	m_NSPurchse = [MyStoreObserver encode: (uint8_t*)[[transaction transactionReceipt] bytes]  length: [[transaction transactionReceipt] length]];
	
	m_NSPurchse = [m_NSPurchse stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	[m_NSPurchse retain];
	NSLog(@"%@",m_NSPurchse);
	NSLog(@"*****************************************");
}

+ (NSString*) encode:(const uint8_t*) input length:(NSInteger) length
{
	static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
	
	NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
	uint8_t* output = (uint8_t*)data.mutableBytes;
	
	for (NSInteger i = 0; i < length; i += 3) {
		NSInteger value = 0;
		for (NSInteger j = i; j < (i + 3); j++) {
			value <<= 8;
			
			if (j < length) {
				value |= (0xFF & input[j]);
			}
		}
		
		NSInteger index = (i / 3) * 4;
		output[index + 0] =table[(value >> 18) & 0x3F];
		output[index + 1] =table[(value >> 12) & 0x3F];
		output[index + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
		output[index + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
	}
	
	return [[[NSString alloc] initWithData:data
								  encoding:NSASCIIStringEncoding] autorelease];
}

- (void) provideContent:(NSString*) productIdentifier{
	
}

-(void)showAlertView
{
	UIAlertView *m_Alert = [[UIAlertView alloc] initWithTitle:@"Purchase Fail" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
	[m_Alert show];
	[m_Alert release];
	
}

-(void) alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSLog(@"user pressed button %d\n",buttonIndex+1);
	
}
@end




@implementation Purchase

@synthesize str_id;

//static NSString * prouductIdOne = @"test.doudizhu.joymaster.one";
static Purchase * p_shareSelf = nil;//指向自己的指针

+ (Purchase*)sharedManager
{
	@synchronized(self) {
		
        if (p_shareSelf == nil) {
		
			p_shareSelf = [[self alloc] init];// assignment not done here
        }
    }
    return p_shareSelf;
}



-(void)initPurchase{

	[self OpenStore];
	b_result_open_store = true;
}

-(void)removePurchase{

	[[SKPaymentQueue defaultQueue] removeTransactionObserver:observer];
}

-(BOOL)getResult
{
	b_Purchase_result = [observer m_bObserverResult];
	
	if(b_result_open_store == false)
	{
		b_Purchase_result = false;
	}
	
	return b_Purchase_result;
}

//-(id)initWithFrame:(CGRect)frame
//{
//	
//	//productIdArray = [NSMutableArray array];
//	if(self = [super initWithFrame:frame])
//	{
//		//[self requestProductData];
//	}
//	return self;
//}

- (id)copyWithZone:(NSZone *)zone
{
    return self;	
}

- (id)retain
{	
    return self;	
}

- (unsigned)retainCount
{
    return UINT_MAX;  //denotes an object that cannot be released
}

- (void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;	
}

-(void)dealloc
{
	[observer release];
	
	[payment release];
	
	[mutPayment release];
		
	[super dealloc];
}

//向服务器发送请求
-(void) requestProductData
{	
//	if(![self connectedToNetWork])
//	{
//		[self showAlertView];
//		return;
//	}
	
	//	NSLog(@"about to retrieve products...");
	if (nil != str_id) {
		NSArray* myProductIdArray = [NSArray arrayWithObjects:str_id,nil];
		kMyFeatureIdentifier = [NSSet setWithArray:myProductIdArray];
		
		SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers:kMyFeatureIdentifier];
		request.delegate = self;
		[request start];
	}else {
		UIAlertView *m_Alert = [[UIAlertView alloc] initWithTitle:@"交易失败" message:@"此商品不存在" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
		[m_Alert show];
		[m_Alert release];
		b_Purchase_over = true;
		b_Purchase_result = false;
	}

	
	//[request release];
}
/*
//检测网络链接状态
- (BOOL) connectedToNetWork{
	
	//建立空网址
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
	
	//
	SCNetworkReachabilityRef defaultRouteReachability = 
	SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr*)&zeroAddress);
	SCNetworkReachabilityFlags flags;
	
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);
	
	if(!didRetrieveFlags){
		printf("Error.Could not recover network reachability flags\n");
		return 0;
	}
	
	BOOL isReachable = flags & kSCNetworkFlagsReachable;
	BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
	
	return (isReachable && !needsConnection) ? YES : NO;
	
}
*/


//检测是否有购买权限
-(void)CheckSendPayments
{
	if ([SKPaymentQueue canMakePayments])
	{
		//		NSLog(@"show store to user!");
		//[self addMutPayment:prouductIdOne buyCount:1];
		//[self addMutPayment:selectProductId buyCount:buy_num];
		[self	showStore];
	}
	else
	{
		// Warn the user that purchases are disabled.
		//		NSLog(@"the user's purchase is disabled");
		
		b_result_open_store = false;
		
		[self showAlertView];
	}
}

-(void)BeginBuyProduct
{
	[self addMutPayment:str_id buyCount:1];
}

//加入新的交易业务
-(void) addMutPayment:(NSString*)productId buyCount:(int)add_index
{
	//	NSLog(@"add one new Mutpayment!");
	//NSSet* selectProductId = [NSSet setWithObject:productId];
	mutPayment = [SKMutablePayment paymentWithProductIdentifier:productId];
	mutPayment.quantity = add_index;
	[[SKPaymentQueue defaultQueue] addPayment:mutPayment];
}

//开始业务监控
-(void) OpenStore
{
	//	NSLog(@"begin observer the transaction:");
	observer = [[MyStoreObserver alloc] init];
	[[SKPaymentQueue defaultQueue] addTransactionObserver:observer];
}


//应用程序请求服务器返回结果
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
	//返回的产品信息
	//	NSLog(@"获得返回信息!");
    NSArray* myProduct = [NSArray arrayWithArray: response.products];
	for(SKProduct * aProduct in myProduct)
	{
		NSLog(@"Name: %@ - Price: %f",[aProduct localizedTitle],[[aProduct price] doubleValue]);
		NSLog(@"Product identifier: %@", [aProduct productIdentifier]);
		displayTitle = aProduct.localizedTitle;
		displayDesc = aProduct.localizedDescription;
		displayPrice = aProduct.price;
		NSLog(@"%@",displayDesc);
	}
    //检测用户是否有权限 显示populate UI
	//加入新的购买业务,开始监控交易
	[self CheckSendPayments];
	
    [request autorelease];
}

-(BOOL)checkIsOver
{
	b_Purchase_over = [observer m_bObserverResult];
	
	if(b_result_open_store == false)
	{
		b_Purchase_over = true;
	}
	
	return b_Purchase_over;
}

-(void)PurchaseOver:(BOOL) b_is_ok
{
	b_Purchase_over = b_is_ok;
}

-(void)showStore
{
	b_dis_one = true;
	UIAlertView* m_StoreDisplay = [[UIAlertView alloc] initWithTitle:displayTitle message:displayDesc delegate:self cancelButtonTitle:nil otherButtonTitles:@"NO",@"YES", nil];
	
	[m_StoreDisplay show];
	[m_StoreDisplay release];
}

-(void)showNetworkFailStore
{
	b_dis_one = false;
	UIAlertView* m_Alert = [[UIAlertView alloc] initWithTitle:@"交易失败" message:@"请确认网络状态" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[m_Alert show];
	[m_Alert release];
}

-(void)showAlertView
{
	NSString *message = @"the store open fail!";
	UIAlertView* m_Alert = [[UIAlertView alloc] initWithTitle:@"Purchase Fail" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[m_Alert show];
	[m_Alert release];
	
}

-(void)showCompleteView
{
	NSString * message = @"the purchase is complete,Thank you!";
	UIAlertView* m_Alert = [[UIAlertView alloc] initWithTitle:@"Purchase over!" message:message delegate:self cancelButtonTitle:@"YES" otherButtonTitles:nil];
	[m_Alert show];
	[m_Alert release];
}


-(void) alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSLog(@"user pressed button %d\n",buttonIndex+1);
	if(buttonIndex == 0&&b_dis_one == true)//不购买商品
	{
		b_result_open_store = false;
		
		b_dis_one = false;
	}
	else if(buttonIndex == 0 && b_dis_one == false)
	{
		b_result_open_store = false;
		
		b_dis_one = false;
	}
	else if(buttonIndex == 1&&b_dis_one == true)//购买此商品
	{
		
		b_result_open_store = true;
		[self BeginBuyProduct];//添加购买
		b_dis_one = false;
		
	}
}

-(NSString*)BackInformation
{
	m_BackInfor = [NSString stringWithString:[observer PurchasedTransaction]];
	return m_BackInfor;
}
@end