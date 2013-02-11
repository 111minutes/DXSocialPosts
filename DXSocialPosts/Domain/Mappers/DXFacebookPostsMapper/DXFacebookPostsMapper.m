//
//  DXFacebookPostsMapper.m
//  DXSocialPosts
//
//  Created by TheSooth on 2/10/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "DXFacebookPostsMapper.h"

#import "FacebookPost.h"

#import "NSString+RegularExpression.h"

@implementation DXFacebookPostsMapper

- (id)mapFromInputData:(id)inputData withClass:(Class)mappingClass
{
    NSMutableArray *facebookPostsArray = [NSMutableArray new];
    
    NSArray *entries = [inputData objectForKey:@"entries"];
    
    for (NSDictionary *postDictionary in entries) {
        
        NSString *content = [postDictionary valueForKey:@"content"];
        
        FacebookPost *post = [FacebookPost new];
        
        post.title = [self titleFromContent:content];
        post.sharedLink = [self sharedLinkFromContent:content];
        post.postText = [self postTextFromContent:content];
        post.imageLink = [self imageURLStringFromContent:content];
        
        [facebookPostsArray addObject:post];
    }
    
    return facebookPostsArray;
}

- (NSString *)titleFromContent:(NSString *)aContent
{
    #warning Need to make a "right" regular pattern
    NSString *title = [aContent stringByMatchingRegularExpressionPattern:@">+[^<>]+"];
    
    return [title stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
}

- (NSString *)sharedLinkFromContent:(NSString *)aContent
{
    NSString *encodedURLLink = [aContent stringByMatchingRegularExpressionPattern:@"http%[\\S]+?[^&\\s]+"];
    
    NSString *decodedURLLink = [encodedURLLink stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return decodedURLLink;
}

- (NSString *)postTextFromContent:(NSString *)aContent
{
    NSString *contentText = [aContent stringByMatchingRegularExpressionPattern:@"[^</>]+$"];
    
    return contentText;
}

- (NSString *)imageURLStringFromContent:(NSString *)aContent
{
    #warning Need to make a "right" regular pattern
    NSString *imageURLEncodedLink = [aContent stringByMatchingRegularExpressionPattern:@"(?:url=)+http[^\\s\"]+"];
    NSString *imageURLDecodedLink = [imageURLEncodedLink stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *imageURLString = [imageURLDecodedLink stringByReplacingCharactersInRange:NSMakeRange(0, 4) withString:@""];
    
    return imageURLString;
}

@end
