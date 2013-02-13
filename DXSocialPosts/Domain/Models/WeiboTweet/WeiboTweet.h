//
//  WeiboTweet.h
//  DXSocialPosts
//
//  Created by TheSooth on 2/13/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "TwitterTweet.h"

@interface WeiboTweet : TwitterTweet

@property (nonatomic, strong) NSString *tweetThumbnailPicURL;
@property (nonatomic, strong) NSString *tweetOriginalPicURL;
@property (nonatomic, strong) NSString *tweetMiddlePicURL;

@end
