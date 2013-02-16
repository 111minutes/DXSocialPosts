//
//  DXFacebookPostsMapper.h
//  DXSocialPosts
//
//  Created by TheSooth on 2/10/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DXSPMapper.h"

@interface DXFacebookPostsMapper : NSObject <DXSPMapper>

- (id)initWithFacebookUserID:(long long)aFacebookUserID;

@end
