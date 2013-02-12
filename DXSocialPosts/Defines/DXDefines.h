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
    __unsafe_unretained NSString *facebookApiURL;
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

const struct FacebookAvatarTypes
{
    __unsafe_unretained NSString *large;
    __unsafe_unretained NSString *normal;
    __unsafe_unretained NSString *small;
    __unsafe_unretained NSString *square;
} FacebookAvatarTypes;

const struct Paths
{
    __unsafe_unretained NSString *facebookImagesDir;
    __unsafe_unretained NSString *twitterUserAvatarsDir;
} Paths;