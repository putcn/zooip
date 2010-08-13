    //
//  hatchView.m
//  zoo
//
//  Created by Hunk on 10-8-11.
//  Copyright 2010 Vanceinfo. All rights reserved.
//

#import "hatchView.h"
#import "FeedbackDialog.h"
#import "ServiceHelper.h"

@implementation hatchView
@synthesize m_nGoldenEggs, m_nAnts;
@synthesize m_strFarmerID, m_strFarmID, m_strStorageZyID;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor clearColor];
	[self.view setFrame:CGRectMake(0, 0, 480, 320)];
//	CGAffineTransform rotation = CGAffineTransformMakeRotation(M_PI/2);
//	[self.view setTransform:rotation];
	
	labelMsg.text = [NSString stringWithFormat:@"孵化需要%d个金蛋,或者%d个蚂蚁币.您确定要孵化吗?", m_nGoldenEggs, m_nAnts];
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

-(IBAction)goldenEggBtn:(id)sender
{
	NSString *pay = [NSString stringWithFormat:@"goldenEgg"];	
	m_strPayType = @"goldenEgg";	
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:m_strFarmerID,@"farmerId",m_strFarmID,@"farmId",m_strStorageZyID,@"zygoteStorageId",pay,@"payment",nil];	
	
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoIncubatingEgg WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
}

-(IBAction)antsBtn:(id)sender
{
	NSString *pay = [NSString stringWithFormat:@"ant"];
	m_strPayType = @"ant";
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:m_strFarmerID,@"farmerId",m_strFarmID,@"farmId",m_strStorageZyID,@"zygoteStorageId",pay,@"payment",nil];
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoIncubatingEgg WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultAntHatchCallback:" AndFailedSel:@"faultCallback:"];	
}

-(IBAction)cancelBtn:(id)sender
{
	[self.view removeFromSuperview];
}

-(void)resultCallback:(NSObject *)value
{
	NSDictionary *result = (NSDictionary *)value;
	
	NSInteger code = [[result objectForKey:@"code"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[result objectForKey:@"code"] intValue];	
	
	[self selectResultInfo:code setPayType:m_strPayType ];		
}


-(void)resultAntHatchCallback:(NSObject *)value
{	
	NSDictionary *result = (NSDictionary *)value;
	
	NSInteger code = [[result objectForKey:@"code"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[result objectForKey:@"code"] intValue];
	
	[self selectResultInfo:code setPayType:m_strPayType];
}

-(void)selectResultInfo:(NSInteger) code  setPayType:(NSString *)  payType
{
	switch (code) {
		case 0:
			m_strInfoStr = [NSString stringWithFormat:@"没有受精卵或受精卵已经孵出"];
			break;
		case 1:
			m_strInfoStr = [NSString stringWithFormat:@"孵化成功"];
			break;	
			
		case 2:
			m_strInfoStr = [NSString stringWithFormat:@"受精卵在拍卖"];
			
			break;
		case 3:
			m_strInfoStr = [NSString stringWithFormat:@"孵化不成功"];
			break;
			
		case 4:
			m_strInfoStr = [NSString stringWithFormat:@"农场容量不够"];
			break;
			
		case 5:
			m_strInfoStr = [NSString stringWithFormat:@"没有可以用来孵化的母鸡"];
			break;
			
		case 6:
			if (m_strPayType == @"goldenEgg") {
				m_strInfoStr = [NSString stringWithFormat:@"没有足够的金币"];
			}else {
				m_strInfoStr = [NSString stringWithFormat:@"没有足够的蚂蚁"];
			}
			break;			
		case 7:
			m_strInfoStr = [NSString stringWithFormat:@"已喂过"];
			break;			
		case 8:
			m_strInfoStr = [NSString stringWithFormat:@"公动物不能喂食物"];
			break;
		default:
			break;
	}
	
	[[FeedbackDialog sharedFeedbackDialog] addMessage:m_strInfoStr];
}

-(void) faultCallback:(NSObject *)value
{
	NSLog(@"Server Connection Fail");
}

- (void)dealloc 
{
    [super dealloc];
}


@end
