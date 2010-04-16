//
//  serviceHelper.m
//  zoo
//
//  Created by Darcy on 3/30/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "serviceHelper.h"
#import "ASIFormDataRequest.h"
#import "CJSONDeserializer.h"
#import "DataEnvironment.h"


@implementation ServiceHelper
static ServiceHelper *sharedInst = nil;
static NSString *serviceBaseURL = @"http://zoo.hotpod.jp/fplatform/farmv4/mixi/php/remoteService.php";
static NSString *testingFarmerId = @"A6215BF61A3AF50A8F72F043A1A6A85C";
static NSString *testingFarmId = @"163D7A78682082B36872659C7A9DA8F9";

+ (id)sharedService{
    @synchronized( self ) {
        if ( sharedInst == nil ) {
            /* sharedInst set up in init */
            [[self alloc] init];
        }
    }
	
    return sharedInst;
}

- (id)init{
    if ( sharedInst != nil ) {
		
	} else if ( (self = [super init]) ) {
		sharedInst = self;
		[self restore];
		
	}
	return sharedInst;
}


- (NSUInteger)retainCount{
	return NSUIntegerMax;
}

- (oneway void)release{
}

- (id)retain{
	return sharedInst;
}

- (id)autorelease{
	return sharedInst;
}

- (void) restore{
	
}

-(void)requestDone:(ASIFormDataRequest *)request{
	
	NSData *jsonData = [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
	NSDictionary *result = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:nil];
	if (!result) {
		[self feedBackWithBadFormat:[request responseString]];
		return;
	}
	
	NSLog(@"%@",result);
	
	if ([result objectForKey:@"error_code"]) {
		[self operationError:[result objectForKey:@"error_code"]];
		 return;
	}
	
	ZooNetworkRequestType type = request.requestFlagMark;
	DataEnvironment *dataEnv = [DataEnvironment sharedDataEnvironment];
	NSDictionary *farmer = nil;
	NSDictionary *tempDic = nil;
	
	switch (type) {
		case ZooNetworkRequestgetFarmerInfo:
			farmer = (NSDictionary *)[result objectForKey:@"farmer"];
			dataEnv.antsCurrency = [(NSNumber *)[farmer objectForKey:@"antsCurrency"] intValue];
			dataEnv.farmerId = (NSString *)[farmer objectForKey:@"farmerId"];
			dataEnv.snsUserId = [(NSNumber *)[farmer objectForKey:@"snsUserId"] intValue];
			dataEnv.userName = [farmer objectForKey:@"userName"];
			dataEnv.userImg = [farmer objectForKey:@"userImg"];
			dataEnv.farmPref = [(NSNumber *)[farmer objectForKey:@"farmPref"] intValue];
			dataEnv.fighter = [(NSNumber *)[farmer objectForKey:@"fighter"] intValue];
			dataEnv.isNewUser = [(NSNumber *)[farmer objectForKey:@"newUser"] boolValue];
			dataEnv.haveNewMessage = [(NSNumber *)[farmer objectForKey:@"newMessage"] boolValue];
			dataEnv.goldenEgg = [(NSNumber *)[farmer objectForKey:@"goldenEgg"] intValue];
			dataEnv.haveTurtle = [(NSNumber *)[farmer objectForKey:@"turtle"] boolValue];
			break;
			
			
		case ZooNetworkRequestgetFarmInfo:
			tempDic = (NSDictionary *)[result objectForKey:@"farm"];
			dataEnv.farmId = (NSString *)[tempDic objectForKey:@"farmId"];
			dataEnv.farm_level = [(NSNumber *)[tempDic objectForKey:@"level"] intValue];
			dataEnv.farm_currentExp = [(NSNumber *)[tempDic objectForKey:@"currentExp"] intValue];
			dataEnv.farm_expGainPerDay = [(NSNumber *)[tempDic objectForKey:@"expGainPerDay"] intValue];
			dataEnv.farm_expGainTime = [(NSNumber *)[tempDic objectForKey:@"expGainTime"] intValue];
			dataEnv.farm_experience = [(NSNumber *)[tempDic objectForKey:@"experience"] intValue];
			dataEnv.farm_foodEndTime = [(NSNumber *)[tempDic objectForKey:@"foodEndTime"] intValue];
			dataEnv.farm_maxNumOfBirds = [(NSNumber *)[tempDic objectForKey:@"maxNumOfBirds"] intValue];
			dataEnv.farm_nextLevelExp = [(NSNumber *)[tempDic objectForKey:@"nextLevelExp"] intValue];
			dataEnv.farm_remain = [(NSNumber *)[tempDic objectForKey:@"remain"] intValue];
			dataEnv.farm_topMaxNumOfBirds = [(NSNumber *)[tempDic objectForKey:@"topMaxNumOfBirds"] intValue];
			break;
			
		case ZooNetworkRequestgetAllBirdFarmAnimalInfo:
			dataEnv.animals = [[NSMutableArray alloc] init];
			[dataEnv.animals setArray:(NSArray *)[result objectForKey:@"animals"]];
			break;


		default:
			break;
	}
}

-(void)nativeNetworkError:(ASIFormDataRequest *)request{ //http error, TBD
	NSLog(@"http request error");
}

-(void)feedBackWithBadFormat:(NSString *)callBackString{
	NSLog(@"bad orgnized feedback : %@",callBackString);
}

-(void)operationError:(NSString *)reason{
	NSLog(@"operation Error, with reason : %@",reason);
}


	

-(ASIFormDataRequest *)buildRequestWithType:(ZooNetworkRequestType)type{
	NSURL *url = [NSURL URLWithString:serviceBaseURL];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	request.requestFlagMark = type;
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(requestDone:)];
	[request setDidFailSelector:@selector(requestWentWrong:)];
	
	//set testing uid and pid
	[request setPostValue:@"25313321" forKey:@"uid"];
	[request setPostValue:@"11" forKey:@"pid"];
	
	return request;
}

-(void)getFarmerInfo{
	ASIFormDataRequest *request = [self buildRequestWithType:ZooNetworkRequestgetFarmerInfo];
	[request setPostValue:@"getFarmerInfo" forKey:@"method"];
	[request startAsynchronous];
}

-(void)getFarmInfoWithFarmerId:(NSString *)farmerId AndIsGuarded:(BOOL)isGuarded{
	NSString *strIsGuarded = @"0";
	if (isGuarded) {
		strIsGuarded = @"1";
	}
	
	if (!farmerId) {
		farmerId = [DataEnvironment sharedDataEnvironment].farmerId;
	}
	
	ASIFormDataRequest *request = [self buildRequestWithType:ZooNetworkRequestgetFarmInfo];
	[request setPostValue:@"getFarmInfo" forKey:@"method"];
	[request setPostValue:farmerId forKey:@"farmerId"];
	[request setPostValue:strIsGuarded forKey:@"bodyguard"];
	[request startAsynchronous];
}

-(void)getAllBirdFarmAnimalInfoWithFarmId:(NSString *)farmId AndFarmerId:(NSString *)farmerId{
	
	if (!farmerId) {
		farmerId = [DataEnvironment sharedDataEnvironment].farmerId;
	}
	
	if (!farmId) {
		farmId = [DataEnvironment sharedDataEnvironment].farmId;
	}
	
	ASIFormDataRequest *request = [self buildRequestWithType:ZooNetworkRequestgetAllBirdFarmAnimalInfo];
	[request setPostValue:@"getAllBirdFarmAnimalInfo" forKey:@"method"];
	[request setPostValue:farmerId forKey:@"farmerId"];
	[request setPostValue:farmId forKey:@"farmId"];
	[request startAsynchronous];
}


@end
