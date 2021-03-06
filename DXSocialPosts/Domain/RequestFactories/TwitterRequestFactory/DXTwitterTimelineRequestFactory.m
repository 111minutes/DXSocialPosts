//
//  DXTwitterTimelineRequestFactory.m
//  DXSocialPosts
//
//  Created by TheSooth on 1/30/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "DXTwitterTimelineRequestFactory.h"
#import "DXTwitterTweetMapper.h"

#import "TwitterTweet.h"

@implementation DXTwitterTimelineRequestFactory

- (id <DXDALDataProvider>)getDataProvider
{
    return [[DXDALDataProviderHTTPCached alloc] initWithBaseURL:[NSURL URLWithString:ServicesURL.twitterApiURL]];
}

- (Class)getDefaultRequestClass {
    return [DXDALRequestHTTP class];
}

- (DXDALRequest *)getTimelineForUser:(NSString *)aUser withRetweets:(BOOL)aWithRetweets tweetsCount:(NSInteger)aTweetsCount responseFormat:(NSString *)aResponseFormat
{
    return [self buildRequestWithConfigBlock:^(DXDALRequestHTTP *request) {
        
        NSAssert(![aResponseFormat isEqualToString:ResponseFormats.xml], @"XML reponse format currently not supported");
        NSAssert([aResponseFormat isEqualToString:ResponseFormats.json], @"Invalid response format, use json");
        
        request.httpMethod = HTTPMethods.GET;
        request.httpPath = @"1/statuses/user_timeline.json";
        
        request.parser = [DXDALParserJSON new];
        request.mapper = [DXTwitterTweetMapper new];
        request.entityClass = [TwitterTweet class];
        
        [request addParam:aUser withName:@"screen_name"];
        [request addParam:[NSNumber numberWithBool:aWithRetweets] withName:@"include_rts"];
        [request addParam:[NSNumber numberWithInteger:aTweetsCount] withName:@"count"];
    }];
}

@end
