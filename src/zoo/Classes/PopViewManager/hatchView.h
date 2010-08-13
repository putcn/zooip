//
//  hatchView.h
//  zoo
//
//  Created by Hunk on 10-8-11.
//  Copyright 2010 Vanceinfo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface hatchView : UIViewController 
{
	IBOutlet UILabel* labelMsg;
	
	IBOutlet UIButton* goldenEggBtn;
	
	IBOutlet UIButton* antsBtn;
	
	IBOutlet UIButton* cancelBtn;
	
	int m_nGoldenEggs;
	
	int m_nAnts;
	
	NSString* m_strFarmerID;
	NSString* m_strFarmID;
	NSString* m_strStorageZyID;
	
	NSString* m_strPayType;
	NSString* m_strInfoStr;
}
@property int m_nGoldenEggs;

@property int m_nAnts;

@property(nonatomic, retain) NSString* m_strFarmerID;
@property(nonatomic, retain) NSString* m_strFarmID;
@property(nonatomic, retain) NSString* m_strStorageZyID;

-(IBAction)goldenEggBtn:(id)sender;

-(IBAction)antsBtn:(id)sender;

-(IBAction)cancelBtn:(id)sender;

-(void)selectResultInfo:(NSInteger) code  setPayType:(NSString *) payType;

@end
