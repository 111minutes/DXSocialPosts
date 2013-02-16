//
//  DXSPParser.h
//  DXSocialPosts
//
//  Created by TheSooth on 2/16/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DXSPMapper <NSObject>

- (void)mapFromInputData:(id)aData entityClass:(Class)aEntityClass finishCallbackBlock:(void(^)(id aObject))aFinishCallbackBlock;

@end
