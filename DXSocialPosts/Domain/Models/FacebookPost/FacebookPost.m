//
//  FacebookPost.m
//  DXSocialPosts
//
//  Created by TheSooth on 2/10/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "FacebookPost.h"

@implementation FacebookPost

- (NSString *)description
{
    return [NSString stringWithFormat:@"title: %@\nsharedLink: %@\npostText: %@\nimageLink: %@\nlocalImagePath: %@",
            self.title, self.sharedLink, self.postText, self.imageLink, self.localImagePath];
}

@end
