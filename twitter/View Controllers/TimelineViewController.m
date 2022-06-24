//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"
#import "TweetDetailsViewController.h"
#import "ReplyViewController.h"
#import "ProfileViewController.h"

#import "TweetCell.h"
#import "Tweet.h"
#import "User.h"
#import "DateTools.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)didTapLogout:(id)sender;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Table View Set Up
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Initialize a UIRefreshControl
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
    
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.arrayOfTweets = [[NSMutableArray alloc] init];
            for (Tweet *tweet in tweets) {
                //NSLog(@"%@", tweetText);
                [self.arrayOfTweets addObject:tweet];
            }
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.tableView reloadData];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *navigationController = [segue destinationViewController];
    
    if([segue.identifier isEqualToString:@"TweetSegue"]) {
        TweetCell *cell = sender;
        NSIndexPath *myIndexPath = [self.tableView indexPathForCell:cell];
        
        Tweet *dataToPass = self.arrayOfTweets[myIndexPath.row];
        TweetDetailsViewController *detailVC = [segue destinationViewController];
        detailVC.detailDict = dataToPass;
        
    } else if([segue.identifier isEqualToString:@"ComposeSegue"]) {
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
    } else if([segue.identifier isEqualToString:@"ReplySegue"]) {
        TweetCell *cell = sender;
        NSIndexPath *myIndexPath = [self.tableView indexPathForCell:cell];
    
        Tweet *dataToPass = self.arrayOfTweets[myIndexPath.row];
        ReplyViewController *replyVC = [segue destinationViewController];
        replyVC.detailDict = dataToPass;
    } else if([segue.identifier isEqualToString:@"ProfileImageSegue"]) {
        TweetCell *cell = sender;
        NSIndexPath *myIndexPath = [self.tableView indexPathForCell:cell];
        
        User *dataToPass = self.arrayOfTweets[myIndexPath.row];
        ProfileViewController *profileVC = [segue destinationViewController];
        profileVC.detailDict = dataToPass;
    }
    
    [self.tableView reloadData];
}

- (IBAction)didTapLogout:(id)sender {
    // Access the instance of the application delegate
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    // Clear out the access tokens
    [[APIManager shared] logout];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
    Tweet *tweet = self.arrayOfTweets[indexPath.row];
    
    cell.tweet = tweet;

    // Populating data for profile picture
    // Generate URL and URL data for profile image
    NSString *URLString = tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    // Assign URL data to profile image
    
    //cell.profileImageView.image = nil;
    
    [cell.profileImageView setImage:[UIImage imageWithData:urlData] forState:UIControlStateNormal];
    
    // Assign number of retweets and favorites to labels
    // Updates both retweet and favorite button icon's color
    [self refreshRetweetValues:cell];
    [self refreshFavoriteValues:cell];

    // Set up all text labels (Full name, tweet text, username)
    cell.fullNameLabel.text = tweet.user.name;
    cell.userNameLabel.text = [@"@" stringByAppendingString:tweet.user.screenName];
    cell.tweetTextLabel.text = tweet.text;
    
    // Set up date text label
    cell.tweetDateLabel.text = tweet.createdAtString;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfTweets.count;
}

// Makes a network request to get updated data
// Updates the tableView with the new data
// Hides the RefreshControl
- (void)beginRefresh:(UIRefreshControl *)refreshControl {
       // Create NSURL and NSURLRequest
        [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.arrayOfTweets = [[NSMutableArray alloc] init];
            for (Tweet *tweet in tweets) {
                //NSLog(@"%@", tweetText);
                [self.arrayOfTweets addObject:tweet];
            }
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
            
        [self.tableView reloadData];
            
        // Tell the refreshControl to stop spinning
        [refreshControl endRefreshing];
    }];
}

// Add the new tweet to the tweets array
- (void)didTweet:(nonnull Tweet *)tweet {
    [self.arrayOfTweets insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}

// Refresh data method in the cell that sets the retweet labels and buttons to their respective text, images, etc.
- (void)refreshRetweetValues:(TweetCell *)cell {
    // Update the number of retweets
    cell.retweetNumberLabel.text = [NSString stringWithFormat:@"%d", cell.tweet.retweetCount];
    
    // Change retweet icon to green version if set to YES
    if(cell.tweet.retweeted == YES) {
        [cell.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    } else {
        // Tweet is not retweeted (NO), uses normal icon
        [cell.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }
}

// Refresh data method in the cell that sets the favorite labels and buttons to their respective text, images, etc.
- (void)refreshFavoriteValues:(TweetCell *)cell {
    // Update the number of favorites
    cell.likeNumberLabel.text = [NSString stringWithFormat:@"%d", cell.tweet.favoriteCount];
    
    // Change favorite icon to red version if set to YES
    if(cell.tweet.favorited == YES) {
        [cell.favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    } else {
        // Tweet is not favorited (NO), uses normal icon
        [cell.favoriteButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    }
}


@end
