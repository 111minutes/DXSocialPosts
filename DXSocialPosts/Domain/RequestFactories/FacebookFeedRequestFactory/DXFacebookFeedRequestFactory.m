//
//  DXFacebookFeedRequestFactory.m
//  DXSocialPosts
//
//  Created by TheSooth on 1/30/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "DXFacebookFeedRequestFactory.h"
#import "DXFacebookPostsMapper.h"
#import "DXSocialPostsParser.h"


@implementation DXFacebookFeedRequestFactory

- (id <DXDALDataProvider>)getDataProvider
{
    return [[DXDALDataProviderHTTPCached alloc] initWithBaseURL:[NSURL URLWithString:ServicesURL.facebookURL]];
}

- (Class)getDefaultRequestClass {
    return [DXSPRequest class];
}

- (DXSPRequest *)getFacebookFeedPostsForUserID:(long long)aUserID responseFormat:(NSString *)aResponseFormat
{    
        NSAssert(![aResponseFormat isEqualToString:ResponseFormats.xml], @"XML reponse format currently not supported");
        NSAssert([aResponseFormat isEqualToString:ResponseFormats.json], @"Invalid response format, use json");
    
        DXSPRequest *request = [[DXSPRequest alloc] initWithDataProvider:[self getDataProvider]];
        
        request.httpMethod = @"get";
        request.httpPath = @"/feeds/page.php";
    
        request.parser = [DXSocialPostsParser new];
        request.spMapper = [[DXFacebookPostsMapper alloc] initWithFacebookUserID:aUserID];
        
        [request addParam:[NSNumber numberWithLongLong:aUserID] withName:@"id"];
        [request addParam:aResponseFormat withName:@"format"];
    
    return request;
}

@end
