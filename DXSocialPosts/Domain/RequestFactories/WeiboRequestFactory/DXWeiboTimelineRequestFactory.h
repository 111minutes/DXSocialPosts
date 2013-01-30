//
//  DXWeiboTimelineRequestFactory.h
//  DXSocialPosts
//
//  Created by TheSooth on 1/30/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "DXDALRequestFactory.h"

@interface DXWeiboTimelineRequestFactory : DXDALRequestFactory <DXSingleton>

- (DXDALRequest *)getTimelineForUserID:(long long)aUserID responseFormat:(NSString *)aResponseFormat appKey:(NSUInteger)aAppKey;

@end
