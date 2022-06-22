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

@implementation TweetCell

- (IBAction)didTapRetweet:(id)sender {
    
    // TODO: Update the local tweet model
    self.tweet.retweeted = YES;
    self.tweet.retweetCount += 1;
    
    // TODO: Update cell UI
    // Need to create a refreshData() method in the cell that updates all views, i.e. sets the labels to their respective text, etc.

    [self refreshRetweetValues];
    
    // TODO: Send a POST request to the POST favorites/create endpoint
    [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
         if(error){
              NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
         }
         else{
             NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
         }
     }];
}

- (IBAction)didTapFavorite:(id)sender {
    // TODO: Update the local tweet model
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    
    // TODO: Update cell UI
    
    [self refreshFavoriteValues];
    
    // TODO: Send a POST request to the POST favorites/create endpoint
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
         if(error){
              NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
         }
         else{
             NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
         }
     }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// Refresh data method in the cell that sets the retweet labels and buttons to their respective text, images, etc.
- (void)refreshRetweetValues {
    self.retweetNumberLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
}

// Refresh data method in the cell that sets the favorite labels and buttons to their respective text, images, etc.
- (void)refreshFavoriteValues {
    self.likeNumberLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
}

@end
