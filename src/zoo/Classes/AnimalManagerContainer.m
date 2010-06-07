//
//  AnimalManagerContainer.m
//  zoo
//
//  Created by Alex Liu on 6/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AnimalManagerContainer.h"
#import "Button.h"
#import "StoButtonContainer.h"
#import "AnimalManageButtonContainer.h"
#import "FeedbackDialog.h"

@implementation AnimalManagerContainer

@synthesize title,managementType;

-(id)initWithName:(NSString *)manageType
{
	
	if (  (self = [super init] ) ) {
		
		managementType = manageType;
		
		tabDic = [[NSMutableDictionary alloc] initWithCapacity:0];
		tabContentDic = [[NSMutableDictionary alloc] initWithCapacity:0];
		//tabDisable = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"TabButton1.png" ofType:nil] ] ];
		CCTexture2D *bg = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"ManageContainer.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture:bg];
		[self setTextureRect: rect];
		self.position = ccp(240,160);
		self.scale = 300.0f/1024.0f;
		if ([manageType isEqualToString:@"animalMarry"]) {
			self.title = @"动物结婚";
			
			NSArray *eggNameArray = [ [NSArray alloc] initWithObjects:@"animal",@"animals",nil];
			
			for (int i = 0; i< eggNameArray.count; i++) {
				NSString *tab = [eggNameArray objectAtIndex:i];
				AnimalManageButtonContainer *buttonContainer = [[AnimalManageButtonContainer alloc]initWithTab:tab setTarget:self];
				//StoButtonContainer *buttonContainer = [[StoButtonContainer alloc] initWithTab:tab setTarget:self];
				if (i == 0) {
					buttonContainer.position = ccp(self.contentSize.width/2, self.contentSize.height/2 - 50);
				}
				else {
					buttonContainer.position = ccp(2000, self.contentSize.height/2 - 50);
				}
				
				[self addChild:buttonContainer z:7];
				[tabContentDic setObject:buttonContainer forKey:[NSString stringWithFormat:@"tabContent_%d",i]];
			}
		}
		else {
			self.title = @"婚姻管理";
			
			NSArray *eggNameArray = [ [NSArray alloc] initWithObjects:@"animal",@"animals",nil];
			for (int i = 0; i< eggNameArray.count; i++) {
				NSArray *eggNameArray = [ [NSArray alloc] initWithObjects:@"animal",@"animals",nil];
				
				NSString *tab = [eggNameArray objectAtIndex:i];
				AnimalManagementMateOrDisList *buttonContainer = [[AnimalManagementMateOrDisList alloc]initWithTab:tab setTarget:self];
				if (i == 0) {
					buttonContainer.position = ccp(self.contentSize.width/2, self.contentSize.height/2 - 50);
				}
				else {
					buttonContainer.position = ccp(2000, self.contentSize.height/2 - 50);
				}
				
				[self addChild:buttonContainer z:7];
				[tabContentDic setObject:buttonContainer forKey:[NSString stringWithFormat:@"tabContent_%d",i]];
			}
			
		}

		[self addTitle];
	}	
	return self;
}


-(void)addTitle
{
	NSLog(@"%@",title);
	CCLabel *titleLbl = [CCLabel labelWithString:title fontName:@"Arial" fontSize:40];
	[titleLbl setColor:ccc3(255, 255, 255)];
	titleLbl.position = ccp(self.contentSize.width/2, self.contentSize.height - titleLbl.contentSize.height/2);
	[self addChild:titleLbl z:10];
}

-(void) itemInfoHandler:(AnimalManagementButtonItem *) itemButton
{
	if(managementType == @"animalMarry")
	{
		BOOL ret = NO;
		NSMutableArray *animalIDs = (NSMutableArray *)[DataEnvironment sharedDataEnvironment].animalIDs;
		NSString *aniID;
		DataModelAnimal *serverAnimalDataOne = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:itemButton.animalID];
		
		for (int i = 0; i < [[DataEnvironment sharedDataEnvironment].animalIDs count]; i ++) {
			aniID = [animalIDs objectAtIndex:i];
			DataModelAnimal *serverAnimalList = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:aniID];
			//if(serverAnimalDataOne.animalType == serverAnimalList.animalType && serverAnimalList.gender != serverAnimalDataOne.gender && aniID != leftAnimalID && aniID != rightAnimalID)
			if(serverAnimalDataOne.animalType == serverAnimalList.animalType && serverAnimalList.gender != serverAnimalDataOne.gender)
			{
				ret = YES;
				break;
			}
		}
		if(!ret) //没有可以结婚的,弹出窗口
		{
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"没有可以结婚的动物!"];
		}
		else 
		{
			//判断是否首次加载
			if (animalToMateInfoPanel == nil) {
				animalToMateInfoPanel = [[AnimalManageToMateInfoPanel alloc] initWithItem:itemButton.itemId type:itemButton.itemType animalID:itemButton.animalID setTarget:self];
				animalToMateInfoPanel.position = ccp(self.contentSize.width/2, animalToMateInfoPanel.contentSize.height/2);
				[self addChild:animalToMateInfoPanel z:20];
			}
			else {//TODO: 第二次加载需要完善		
				//***[animalToMateInfoPanel updateInfo:itemButton.itemId type:itemButton.itemType setTarget:self];
				//***animalToMateInfoPanel.position = ccp(self.contentSize.width/2, animalToMateInfoPanel.contentSize.height/2);
			}
		}
	}
	else {
		if (animalToMateOrDisapart == nil) {
			animalToMateOrDisapart = [[AniamalManagementMateOrDisapart alloc] initWithItem:itemButton.itemId type:itemButton.itemType animalID:itemButton.animalID setTarget:self];
			animalToMateOrDisapart.position = ccp(self.contentSize.width/2, animalToMateOrDisapart.contentSize.height/2);
			[self addChild:animalToMateOrDisapart z:20];
		}
		else {	//TODO: 第二次加载需要完善	
			//***[animalToMateInfoPanel updateInfo:itemButton.itemId type:itemButton.itemType setTarget:self];
			//***animalToMateInfoPanel.position = ccp(self.contentSize.width/2, animalToMateInfoPanel.contentSize.height/2);
		}
	}
}

-(void) buyItem:(Button *)button
{
}

-(void) cancel:(Button *)button
{
	animalToMateInfoPanel.position = ccp(2000, animalToMateInfoPanel.contentSize.height/2);
	NSLog(@"取消");
}


-(void) resultCallback:(NSObject *)value
{
	NSLog(@"出售成功");
}

-(void) faultCallback:(NSObject *)value
{
	NSLog(@"Server Connection Fail");
}

@end
