//
//  tableListViewController.m
//  tableList
//
//  Created by shen lancy on 10-7-21.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "tableListViewController.h"
#import "PurchaseInterface.h"
#import "DataEnvironment.h"

@implementation tableListViewController

@synthesize purchaseId, purchaseMsg;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
//	[self.view setFrame:CGRectMake(0.f, 0.f, 480.f, 320.f)];
	httpPurchaseIn = [HttpPurchase sharedPurchase];
	
/*	purchaseId = [[NSArray alloc] initWithObjects:
				   @"mj13_online_igb_01",
				   @"mj13_online_igb_02",
				   @"mj13_online_igb_03",
				   nil];
	
	purchaseMsg = [[NSArray alloc] initWithObjects:
				   @"价格0.99$ 蚂蚁50",
				   @"价格1.99$ 蚂蚁120",
				   @"价格2.99$ 蚂蚁180",
				   nil];
*/
	
	purchaseId = nil;
	purchaseMsg = nil;
	
//	disableView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 480.f, 320.f)];
//	disableView.backgroundColor = [UIColor blackColor];
	disableView.hidden = YES;
	myActivity.hidden = YES;
}




// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [purchaseMsg release];
	[purchaseId release];
	[purchaseTableView release];
	[disableView release];
	[myActivity release];
	
	[super dealloc];
}

#pragma mark -
#pragma mark UITableViewDelegate

//UITableView处理点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	Purchase* purchaseIn = [Purchase sharedManager];
	[purchaseIn initPurchase];
	NSString* getId = [[NSString alloc] initWithString:[purchaseId objectAtIndex:[indexPath row]]];
	[purchaseIn setStr_id:getId];

	[getId release];
	getId = nil;

	[purchaseIn requestProductData];
	
//	storeTimer = [CCTimer timerWithTarget:self selector:@selector(isPurchaseOver:) interval:0.2];
	storeTimer = [[NSTimer timerWithTimeInterval:0.2 target:self selector:@selector(isPurchaseOver:) userInfo:nil repeats:NO] retain];
	[[NSRunLoop currentRunLoop] addTimer:storeTimer forMode:NSDefaultRunLoopMode];

	disableView.hidden = NO;
	myActivity.hidden = NO;
	[self.view setUserInteractionEnabled:NO];
}

#pragma mark -
#pragma mark UITableViewDataSource

// 定义tabel长度
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	
	if([purchaseMsg count] > 0)
		return [purchaseMsg count];
	else
		return 0;
}

// table cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{	
	
    ListTableCell *listCell = (ListTableCell *)[tableView dequeueReusableCellWithIdentifier:@"ListCellIdentifier"];
	
	listCell = [[[ListTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListCellIdentifier"] autorelease];
	listCell.accessoryType = UITableViewCellAccessoryNone;
	listCell.selectionStyle = UITableViewCellSelectionStyleNone;	
    
	[self configureCell:listCell atIndexPath:indexPath];
	
	return listCell;	
}

//列表显示格式
- (void)configureCell:(ListTableCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	
	[cell creatList:[purchaseMsg objectAtIndex:[indexPath row]]];
}

- (IBAction)closePurchase:(id)sender{

	[self.view removeFromSuperview];
}

- (void)isPurchaseOver:(id)sender{
	
	Purchase* purchaseIn = [Purchase sharedManager];

	if ([purchaseIn checkIsOver]) {
		
		if ([purchaseIn getResult]) {
	
			//http协议
			NSString *uid = [DataEnvironment sharedDataEnvironment].playerUid;
			NSString *pid = [DataEnvironment sharedDataEnvironment].pid;
			
			NSString *receipt = [purchaseIn BackInformation];
			
			HttpPurchase* myPurchase = [HttpPurchase sharedPurchase];
			NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
									uid,				@"uid",
									@"completeTransaction",@"method",
									pid,				@"pid",
									receipt,			@"receipt",
									nil];
			[myPurchase RequestParams:params];
			[myPurchase setConnectOver:NO];
			[myPurchase setClientProtocol:Server_Chk];
			
			[self.view removeFromSuperview];
		}else {
			[purchaseIn removePurchase];
		}
		disableView.hidden = YES;
		myActivity.hidden = YES;
		[self.view setUserInteractionEnabled:YES];
	}else {
//		storeTimer = [CCTimer timerWithTarget:self selector:@selector(isPurchaseOver:) interval:0.2];
		if(storeTimer){
			[storeTimer invalidate];
			[storeTimer release];
			storeTimer = nil;
		}
		storeTimer = [[NSTimer timerWithTimeInterval:0.2 target:self selector:@selector(isPurchaseOver:) userInfo:nil repeats:NO] retain];
		[[NSRunLoop currentRunLoop] addTimer:storeTimer forMode:NSDefaultRunLoopMode];
	}
}

- (void)isConnectOver:(id)sender{
	
	if ([httpPurchaseIn connectOver]) {
		
		switch ([httpPurchaseIn clientProtocol]) {
			case MJBank_Store_Protocol:{
				
				NSDictionary* dic = [httpPurchaseIn callBacks];
				if(purchaseId == nil)
				{
					purchaseId = [[NSMutableArray alloc] init];
					NSArray * dic1 = [dic objectForKey:@"iphoneGoodsId"];
					for(unsigned int i =0;i<[dic1 count];i++)
					{
						[purchaseId addObject:[dic1 objectAtIndex:i]];
					}
					
				}
				
				if(purchaseMsg == nil)
				{
					purchaseMsg = [[NSMutableArray alloc] init];
					
					NSArray * dic2 = [dic objectForKey:@"description"];
					for(unsigned int i =0;i<[dic2 count];i++)
					{
						[purchaseMsg addObject:[dic2 objectAtIndex:i]];
					}
				}
				
				[purchaseTableView reloadData];
			}
				break;
			
			case Server_Chk:
				
				break;
				
			default:
				break;
		}
	}
	else {
		if(listTimer){
			[listTimer invalidate];
			[listTimer release];
			listTimer = nil;
		}
		listTimer = [[NSTimer timerWithTimeInterval:0.2 target:self selector:@selector(isConnectOver:) userInfo:nil repeats:NO] retain];
		[[NSRunLoop currentRunLoop] addTimer:listTimer forMode:NSDefaultRunLoopMode];
	}

}

- (void)openConnect{

	listTimer = [[NSTimer timerWithTimeInterval:0.2 target:self selector:@selector(isConnectOver:) userInfo:nil repeats:NO] retain];
	[[NSRunLoop currentRunLoop] addTimer:listTimer forMode:NSDefaultRunLoopMode];
	
}

@end
