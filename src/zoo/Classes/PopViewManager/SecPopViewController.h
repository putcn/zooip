//
//  SecPopViewController.h
//  zoo
//
//  Created by shen lancy on 10-8-2.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SecPopViewController : UIViewController {

	int					m_npopViewType;
	int					m_ntabFlag;
	int					itemId;
	NSString*			labelString;
	IBOutlet UILabel*	myLabel;
	IBOutlet UIImageView*showImage;
	NSString*			curr_itemType;
}

@property(nonatomic, readwrite) int m_npopViewType;
@property(nonatomic, readwrite) int m_ntabFlag;
@property(nonatomic, readwrite) int itemId;
@property(nonatomic, retain) NSString* labelString;

- (IBAction) OKSelected:(id)sender;
- (IBAction) CancelSelected:(id)sender;

- (void) setShowImageName:(NSString*)fileName;
- (void) resultCallback:(NSObject *)value;
- (void) faultCallback:(NSObject *)value;

@end
