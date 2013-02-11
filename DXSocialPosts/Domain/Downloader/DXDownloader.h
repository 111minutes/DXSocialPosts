//
//  DXDownloader.h
//  DXSocialPosts
//
//  Created by TheSooth on 2/11/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXDownloader : NSObject

+ (void)downloadObjectAtURLPath:(NSString *)aURLPath finishCallbackBlock:(void(^)(id aObject))aFinishCallbackBlock;

@end
