//
//  LoginScence.h
//  zoo
//
//  Created by Gu Lei on 10-6-9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Connect.h"

@interface LoginScence : CCLayer <SessionDelegate, RequestDelegate>
{
}

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;

@end
