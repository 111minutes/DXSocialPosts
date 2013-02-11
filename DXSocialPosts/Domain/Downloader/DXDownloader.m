//
//  DXDownloader.m
//  DXSocialPosts
//
//  Created by TheSooth on 2/11/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "DXDownloader.h"

#import <AFNetworking.h>

@implementation DXDownloader

+ (void)downloadObjectAtURLPath:(NSString *)aURLPath finishCallbackBlock:(void(^)(id aObject))aFinishCallbackBlock
{
    NSURL *url = [NSURL URLWithString:aURLPath];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc ] initWithURL:url];
    
    AFHTTPRequestOperation *downloadOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [downloadOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (aFinishCallbackBlock) {
            aFinishCallbackBlock(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (aFinishCallbackBlock) {
            aFinishCallbackBlock(error);
        }
    }];
    
    [downloadOperation start];
}

@end
