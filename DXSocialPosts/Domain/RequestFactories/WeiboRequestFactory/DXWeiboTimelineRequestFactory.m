//
//  DXWeiboTimelineRequestFactory.m
//  DXSocialPosts
//
//  Created by TheSooth on 1/30/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "DXWeiboTimelineRequestFactory.h"
#import "DXWeiboTweetMapper.h"

#import "WeiboTweet.h"

@implementation DXWeiboTimelineRequestFactory

- (id <DXDALDataProvider>)getDataProvider
{
    return [[DXDALDataProviderHTTPCached alloc] initWithBaseURL:[NSURL URLWithString:ServicesURL.weiboApiURL]];
}

- (Class)getDefaultRequestClass {
    return [DXDALRequestHTTP class];
}

- (DXDALRequest *)getTimelineForUserID:(long long)aUserID tweetsCount:(NSInteger)aTweetsCount responseFormat:(NSString *)aResponseFormat appKey:(NSUInteger)aAppKey
{
    return [self buildRequestWithConfigBlock:^(DXDALRequestHTTP *request) {
        
        NSAssert(![aResponseFormat isEqualToString:ResponseFormats.xml], @"XML reponse format currently not supported");
        NSAssert([aResponseFormat isEqualToString:ResponseFormats.json], @"Invalid response format, use json");
        
        NSString *httpPath =[NSString stringWithFormat:@"statuses/user_timeline/%lld.%@", aUserID, aResponseFormat];
        
        request.httpMethod = HTTPMethods.GET;
        request.httpPath = httpPath;
        
        request.parser = [DXDALParserJSON new];
        request.mapper = [DXWeiboTweetMapper new];
        request.entityClass = [WeiboTweet class];
        
        [request addParam:@(aAppKey) withName:@"source"];
        [request addParam:@(aTweetsCount) withName:@"count"];
    }];
}

@end
