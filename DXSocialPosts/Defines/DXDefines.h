//
//  DXDefines.h
//  DXSocialPosts
//
//  Created by TheSooth on 1/30/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const struct ServicesURL
{
    __unsafe_unretained NSString *facebookURL;
    __unsafe_unretained NSString *twitterApiURL;
    __unsafe_unretained NSString *weiboApiURL;
} ServicesURL;

extern const struct ResponseFormats
{
    __unsafe_unretained NSString *json;
    __unsafe_unretained NSString *xml;
} ResponseFormats;

extern const struct HTTPMethods
{
    __unsafe_unretained NSString *POST;
    __unsafe_unretained NSString *GET;
} HTTPMethods;

const struct AppKeys
{
    NSUInteger weiboAppKey;
} AppKeys;