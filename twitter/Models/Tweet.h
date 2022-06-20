//
//  Tweet.h
//  twitter
//
//  Created by Andrea Gonzalez on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tweet : NSObject

// TODO: Add Properties

@property (nonatomic, strong) NSString *idStr; // For favoriting, retweeting & replying
@property (nonatomic, strong) NSString *text; // Text content of tweet
@property (nonatomic) int favoriteCount; // Update favorite count label
@property (nonatomic) BOOL favorited; // Configure favorite button
@property (nonatomic) int retweetCount; // Update favorite count label
@property (nonatomic) BOOL retweeted; // Configure retweet button
@property (nonatomic, strong) User *user; // Contains Tweet author's name, screenname, etc.
@property (nonatomic, strong) NSString *createdAtString; // Display date

// For User's Retweets
@property (nonatomic, strong) User *retweetedByUser;  // If the tweet is a retweet, this will be the user who retweeted

// MARK: Methods

// Initializer that can set all the Tweet properties based on the dictionary.
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

// Returns Tweets when initialized with an array of Tweet dictionaries.
+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries;

@end

NS_ASSUME_NONNULL_END
