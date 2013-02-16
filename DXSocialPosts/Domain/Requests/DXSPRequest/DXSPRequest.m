//
//  DXSPRequest.m
//  DXSocialPosts
//
//  Created by TheSooth on 2/15/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "DXSPRequest.h"



@implementation DXSPRequest

- (void)didFinishWithResponseString:(NSString *)responseString
                      responseObject:(id)responseObject
                  responseStatusCode:(NSInteger)responseStatusCode {
    
    if (responseString != nil) {
        
        if (self.parser) {
            
            id parsedObject = [self.parser parseString:responseString];
                [self.spMapper mapFromInputData:parsedObject entityClass:self.entityClass finishCallbackBlock:^(id aObject) {
                    [self didFinishWithResponse:aObject];
                }];
        }
    }
}

@end
