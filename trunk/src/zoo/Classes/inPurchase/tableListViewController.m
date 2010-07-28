//
//  tableListViewController.m
//  tableList
//
//  Created by shen lancy on 10-7-21.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "tableListViewController.h"
#import "PurchaseInterface.h"

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
	
	[self.view setFrame:CGRectMake(0.f, 0.f, 480.f, 320.f)];
	
	purchaseId = [[NSArray alloc] initWithObjects:
				   @"com.abc.lingeo.123",
				   @"com.abc.lingeo.1234",
				   @"com.abc.lingeo.12345",
				   nil];
	
	purchaseMsg = [[NSArray alloc] initWithObjects:
				   @"价格0.99$ 蚂蚁50",
				   @"价格1.99$ 蚂蚁120",
				   @"价格2.99$ 蚂蚁180",
				   nil];
	
	disableView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 480.f, 320.f)];
	disableView.backgroundColor = [UIColor blackColor];
	disableView.alpha = 0.7;
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
	
	storeTimer = [CCTimer timerWithTarget:self selector:@selector(isPurchaseOver) interval:0.2];

	[self.view addSubview:disableView];
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

- (void)isPurchaseOver{
	
	Purchase* purchaseIn = [Purchase sharedManager];

	if ([purchaseIn checkIsOver]) {
		
		if ([purchaseIn getResult]) {
	
			//http协议
		}else {
			[purchaseIn removePurchase];
		}
		[disableView removeFromSuperview];
		[self.view setUserInteractionEnabled:YES];
	}else {
		storeTimer = [CCTimer timerWithTarget:self selector:@selector(isPurchaseOver) interval:0.2];
	}

}

@end
