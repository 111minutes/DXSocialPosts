//
//  DXSocialPostsParser.m
//  DXSocialPosts
//
//  Created by TheSooth on 2/10/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "DXSocialPostsParser.h"
#import <JSONKit.h>

@implementation DXSocialPostsParser

- (id) parseString:(NSString *)aString
{
    NSString *replacedApostropheString = [aString stringByReplacingOccurrencesOfString:@"&#039;" withString:@"'"];
    
    id object = [replacedApostropheString objectFromJSONStringWithParseOptions:JKParseOptionComments];
    
    return object;
}

@end
