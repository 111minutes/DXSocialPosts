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
    NSRegularExpression *regularExpression = [[NSRegularExpression alloc] initWithPattern:aRegularExpressionPatterh options:0 error:nil];
    NSRange range = [regularExpression rangeOfFirstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    
    NSString *stringWithRegular = [self substringWithRange:range];
    
    return stringWithRegular;
}

@end
