//
//  NSString+RegularExpression.m
//  DXSocialPosts
//
//  Created by TheSooth on 2/10/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "NSString+RegularExpression.h"

@implementation NSString (RegularExpression)

- (void)stringByMatchingRegularExpressionPattern:(NSString *)aRegularExpressionPatterh finishBlock:(void(^)(NSString *string))aFinishBlock
{
    NSRegularExpression *regularExpression = [[NSRegularExpression alloc] initWithPattern:aRegularExpressionPatterh options:0 error:nil];
    
    [regularExpression enumerateMatchesInString:self
                                        options:0
                                          range:NSMakeRange(0, [self length])
                                     usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                         NSRange resultRange = [result range];
                                         
                                         NSString *stringWithRegular = nil;
                                         
                                         if (resultRange.location != NSNotFound) {
                                             stringWithRegular = [self substringWithRange:resultRange];
                                             
                                             if (aFinishBlock) {
                                                 aFinishBlock(stringWithRegular);
                                             }
                                         } else {
                                             aFinishBlock(nil);
                                         }
                                     }];
}

@end
