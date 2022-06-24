//
//  TweetCell.m
//  twitter
//
//  Created by Andrea Gonzalez on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"

#import "AppDelegate.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"
#import "TimelineViewController.h"
#import "Tweet.h"
#import "User.h"
#import "DateTools.h"

@implementation TweetCell

//- (IBAction)didTapProfileImage:(id)sender {
//    
//}



- (IBAction)didTapRetweet:(id)sender {
    
    // TODO: Update the local tweet model
    
    // Check the previous status of retweeted
    if(self.tweet.retweeted == YES) {
        // State to undo retweet
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        
        // TODO: Update cell UI

        [self refreshRetweetValues];
        
        // TODO: Send a POST request to the POST statuses/unretweet/:id endpoint
        [[APIManager shared] unRetweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
             } else {
                 NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
             }
         }];
        
    } else {
        // State to conduct a retweet
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        
        // TODO: Update cell UI

        [self refreshRetweetValues];
        
        // TODO: Send a POST request to the POST statuses/retweet/:id endpoint
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
             } else {
                 NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
             }
         }];
    }
}

- (IBAction)didTapFavorite:(id)sender {
    // TODO: Update the local tweet model
    
    // Check the previous status of favorited
    if(self.tweet.favorited == YES) {
        // State to undo favorite
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        
        // TODO: Update cell UI
        
        [self refreshFavoriteValues];
        
        // TODO: Send a POST request to the POST favorites/destroy endpoint
        [[APIManager shared] unFavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
             } else {
                 NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
             }
         }];
        
    } else {
        // State to favorite the tweet
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        
        // TODO: Update cell UI
        
        [self refreshFavoriteValues];
        
        // TODO: Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             } else {
                 NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
             }
         }];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
//    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapProfileImage:)];
//    
//    [self.profileImageView addGestureRecognizer:profileTapGestureRecognizer];
//    [self.profileImageView setUserInteractionEnabled:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// Refresh data method in the cell that sets the retweet labels and buttons to their respective text, images, etc.
- (void)refreshRetweetValues {
    // Update the number of retweets
    self.retweetNumberLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    
    // Change retweet icon to green version if set to YES
    if(self.tweet.retweeted == YES) {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    } else {
        // Tweet is not retweeted (NO), uses normal icon
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }
}

// Refresh data method in the cell that sets the favorite labels and buttons to their respective text, images, etc.
- (void)refreshFavoriteValues {
    // Update the number of favorites
    self.likeNumberLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    
    // Change favorite icon to red version if set to YES
    if(self.tweet.favorited == YES) {
        [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    } else {
        // Tweet is not favorited (NO), uses normal icon
        [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    }
}

@end
