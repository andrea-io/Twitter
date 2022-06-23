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
    
}

- (IBAction)tapDetailRetweetButton:(id)sender {
    
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
