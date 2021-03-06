//
//  DXFacebookFeedRequestFactory.h
//  DXSocialPosts
//
//  Created by TheSooth on 1/30/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "DXSPRequest.h"

@interface DXFacebookFeedRequestFactory : DXDALRequestFactory <DXSingleton>

- (DXSPRequest *)getFacebookFeedPostsForUserID:(long long)aUserID responseFormat:(NSString *)aResponseFormat;

@end
