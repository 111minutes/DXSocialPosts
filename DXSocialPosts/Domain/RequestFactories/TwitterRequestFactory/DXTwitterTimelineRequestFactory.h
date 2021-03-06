//
//  DXTwitterTimelineRequestFactory.h
//  DXSocialPosts
//
//  Created by TheSooth on 1/30/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "DXDALRequestFactory.h"

@interface DXTwitterTimelineRequestFactory : DXDALRequestFactory <DXSingleton>

- (DXDALRequest *)getTimelineForUser:(NSString *)aUser withRetweets:(BOOL)aWithRetweets tweetsCount:(NSInteger)aTweetsCount responseFormat:(NSString *)aResponseFormat;

@end
