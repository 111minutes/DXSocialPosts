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
    return [[DXDALDataProviderHTTP alloc] initWithBaseURL:[NSURL URLWithString:ServicesURL.facebookURL]];
}

- (Class)getDefaultRequestClass {
    return [DXDALRequestHTTP class];
}

- (DXDALRequest *)getFacebookFeedPostsForUserID:(long long)aUserID responseFormat:(NSString *)aResponseFormat
{
    return [self buildRequestWithConfigBlock:^(DXDALRequestHTTP *request) {
        
        NSAssert(![aResponseFormat isEqualToString:ResponseFormats.xml], @"XML reponse format currently not supported");
        NSAssert([aResponseFormat isEqualToString:ResponseFormats.json], @"Invalid response format, use json");
        
        request.httpMethod = HTTPMethods.GET;
        request.httpPath = @"/feeds/page.php";
    
        request.parser = [DXSocialPostsParser new];
        request.mapper = [DXFacebookPostsMapper new];
        
        [request addParam:[NSNumber numberWithLongLong:aUserID] withName:@"id"];
        [request addParam:aResponseFormat withName:@"format"];
    }];
}

@end
