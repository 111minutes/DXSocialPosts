//
//  DXDefines.m
//  DXSocialPosts
//
//  Created by TheSooth on 1/30/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "DXDefines.h"

const struct ServicesURL ServicesURL =
{
    .facebookURL = @"https://www.facebook.com",
    .facebookApiURL = @"http://graph.facebook.com",
    .twitterApiURL = @"http://api.twitter.com",
    .weiboApiURL = @"http://api.t.sina.com.cn"
};

const struct ResponseFormats ResponseFormats =
{
    .json = @"json",
    .xml = @"xml"
};

const struct HTTPMethods HTTPMethods =
{
    .POST = @"POST",
    .GET = @"GET"
};

const struct AppKeys AppKeys =
{
    .weiboAppKey = 31024382
};