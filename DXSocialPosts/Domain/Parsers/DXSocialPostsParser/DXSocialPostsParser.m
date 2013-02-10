//
//  DXSocialPostsParser.m
//  DXSocialPosts
//
//  Created by TheSooth on 2/10/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "DXSocialPostsParser.h"

@implementation DXSocialPostsParser

- (id) parseString:(NSString *)aString
{
    NSString *decodedString = [aString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *replacedApostropheString = [decodedString stringByReplacingOccurrencesOfString:@"&#039;" withString:@"'"];
    
    return [super parseString:replacedApostropheString];
}

@end
