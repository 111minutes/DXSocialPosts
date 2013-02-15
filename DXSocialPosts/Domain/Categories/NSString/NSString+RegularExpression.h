//
//  NSString+RegularExpression.h
//  DXSocialPosts
//
//  Created by TheSooth on 2/10/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RegularExpression)

- (void)stringByMatchingRegularExpressionPattern:(NSString *)aRegularExpressionPatterh finishBlock:(void(^)(NSString *string))aFinishBlock;

@end
