//
//  FacebookPost.h
//  DXSocialPosts
//
//  Created by TheSooth on 2/10/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FacebookPost : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *sharedLink;

@property (nonatomic, strong) NSString *postText;

@property (nonatomic, strong) NSString *imageLink;

@property (nonatomic, strong) NSString *relativeDateString;

@end
