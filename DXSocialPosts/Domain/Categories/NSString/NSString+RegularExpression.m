//
//  NSString+RegularExpression.m
//  DXSocialPosts
//
//  Created by TheSooth on 2/10/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "NSString+RegularExpression.h"

@implementation NSString (RegularExpression)

- (NSString *)stringByMatchingRegularExpressionPattern:(NSString *)aRegularExpressionPattern
{
    NSRegularExpression *regularExpression = [[NSRegularExpression alloc] initWithPattern:aRegularExpressionPattern options:0 error:nil];
    
        __block NSString *resultString = nil;
        
        [regularExpression enumerateMatchesInString:self
                                            options:0
                                              range:NSMakeRange(0, [self length])
                                         usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                             NSRange resultRange = [result range];
                                             
                                             if (resultRange.location != NSNotFound) {
                                                 resultString = [self substringWithRange:resultRange];
                                             }
                                             
                                         }];
    
    return resultString;
}

@end
