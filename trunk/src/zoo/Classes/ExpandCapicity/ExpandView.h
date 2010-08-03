//
//  ExpandView.h
//  ExpandView
//
//  Created by Hunk on 10-8-2.
//  Copyright 2010 Vanceinfo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ExpandView : UIViewController 
{
	IBOutlet UILabel* m_labelCurCapacity;
	
	IBOutlet UILabel* m_labelCurLevel;
	
	IBOutlet UILabel* m_labelCurGoldenEggs;
	
	IBOutlet UILabel* m_labelExpandNeedLevel;
	
	IBOutlet UILabel* m_labelExpandNeedGoldenEggs;
	
	IBOutlet UIButton* m_buttonSure;
	IBOutlet UIButton* m_buttonCancel;
}
@property(nonatomic, retain)UILabel* m_labelCurCapacity;
@property(nonatomic, retain)UILabel* m_labelCurLevel;
@property(nonatomic, retain)UILabel* m_labelCurGoldenEggs;
@property(nonatomic, retain)UILabel* m_labelExpandNeedLevel;
@property(nonatomic, retain)UILabel* m_labelExpandNeedGoldenEggs;

-(IBAction)buttonSure:(id)sender;

-(IBAction)buttonCancel:(id)sender;

@end
