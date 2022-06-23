//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by Andrea Gonzalez on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"

#import "TweetCell.h"
#import "Tweet.h"
#import "User.h"
#import "DateTools.h"
@interface TweetDetailsViewController ()

@end

@implementation TweetDetailsViewController

- (IBAction)tapDetailFavoriteButton:(id)sender {
    // TODO: Update the local tweet model
    
    // Check the previous status of favorited
    if(self.detailDict.favorited == YES) {
        // State to undo favorite
        self.detailDict.favorited = NO;
        self.detailDict.favoriteCount -= 1;
        
        // TODO: Update cell UI
        
        [self refreshFavoriteValues];
        
        // TODO: Send a POST request to the POST favorites/destroy endpoint
        [[APIManager shared] unFavorite:self.detailDict completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
             } else {
                 NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
             }
         }];
        
    } else {
        // State to favorite the tweet
        self.detailDict.favorited = YES;
        self.detailDict.favoriteCount += 1;
        
        // TODO: Update cell UI
        
        [self refreshFavoriteValues];
        
        // TODO: Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] favorite:self.detailDict completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             } else {
                 NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
             }
         }];
    }
}

- (IBAction)tapDetailRetweetButton:(id)sender {
    // TODO: Update the local tweet model

    // Check the previous status of retweeted
    if(self.detailDict.retweeted == YES) {
        // State to undo retweet
        self.detailDict.retweeted = NO;
        self.detailDict.retweetCount -= 1;
        
        // TODO: Update cell UI

        [self refreshRetweetValues];
        
        // TODO: Send a POST request to the POST statuses/unretweet/:id endpoint
        [[APIManager shared] unRetweet:self.detailDict completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
             } else {
                 NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
             }
         }];
        
    } else {
        // State to conduct a retweet
        self.detailDict.retweeted = YES;
        self.detailDict.retweetCount += 1;
        
        // TODO: Update cell UI

        [self refreshRetweetValues];
        
        // TODO: Send a POST request to the POST statuses/retweet/:id endpoint
        [[APIManager shared] retweet:self.detailDict completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
             } else {
                 NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
             }
         }];
    }
}

// Refresh data method in the cell that sets the retweet labels and buttons to their respective text, images, etc.
- (void)refreshRetweetValues {
    // Update the number of retweets
    self.detailRetweetNumberLabel.text = [NSString stringWithFormat:@"%d", self.detailDict.retweetCount];
    
    // Change retweet icon to green version if set to YES
    if(self.detailDict.retweeted == YES) {
        [self.detailRetweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    } else {
        // Tweet is not retweeted (NO), uses normal icon
        [self.detailRetweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }
}

// Refresh data method in the cell that sets the favorite labels and buttons to their respective text, images, etc.
- (void)refreshFavoriteValues {
    // Update the number of favorites
    self.detailFavoriteNumberLabel.text = [NSString stringWithFormat:@"%d", self.detailDict.favoriteCount];
    
    // Change favorite icon to red version if set to YES
    if(self.detailDict.favorited == YES) {
        [self.detailFavoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    } else {
        // Tweet is not favorited (NO), uses normal icon
        [self.detailFavoriteButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Get timeline

    // Set up all text labels (Full name, tweet text, username)
    self.detailTweetTextLabel.text = self.detailDict.text;
    self.detailFullNameLabel.text = self.detailDict.user.name;
    self.detailUserNameLabel.text = self.detailDict.user.screenName;

    // Generate URL and URL data for profile image
    NSString *URLString = self.detailDict.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];

    // Assign URL data to profile image
    self.detailProfileImage.image = nil;
    self.detailProfileImage.image = [UIImage imageWithData:urlData];
    
    // Update color of favorite buttons based on state
    if(self.detailDict.favorited == YES) {
        [self.detailFavoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    } else {
        [self.detailFavoriteButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    }
    
    // Update color of retweet buttons based on state
    if(self.detailDict.retweeted == YES) {
        [self.detailRetweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    } else {
        [self.detailRetweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }
    
    // Set up date text label
    self.detailTweetDateLabel.text = self.detailDict.createdAtString;
    
    // Assign number of retweets and favorites to labels
    self.detailRetweetNumberLabel.text = [NSString stringWithFormat:@"%d", self.detailDict.retweetCount];
    self.detailFavoriteNumberLabel.text = [NSString stringWithFormat:@"%d", self.detailDict.favoriteCount];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (IBAction)detailRetweetButton:(id)sender {
//}
@end
