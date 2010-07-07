//
//  LoadView.h
//  zoo
//
//  Created by jiang ziwei on 10-6-10.
//  Copyright 2010 shandongligong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface LoadView : CCSprite {

	CCLabel *numberLbl;
	CCSprite *load;
}


-(void) MyLoadingView;
-(void) SetLabelString:(NSString*) nStep;
-(void) RemoveView;
@end
