//
//  NSString+RegularExpression.m
//  DXSocialPosts
//
//  Created by TheSooth on 2/10/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "NSString+RegularExpression.h"

@implementation NSString (RegularExpression)

- (NSString *)stringByMatchingRegularExpressionPattern:(NSString *)aRegularExpressionPatterh
{
    NSRange range = [self rangeOfString:aRegularExpressionPatterh options:NSRegularExpressionSearch];
    NSString *stringWithRegular = nil;
    
    if (range.location != NSNotFound) {
        stringWithRegular = [self substringWithRange:range];
    }
    
    return stringWithRegular;
}

@end
