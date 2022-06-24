//
//  ReplyViewController.m
//  twitter
//
//  Created by Andrea Gonzalez on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ReplyViewController.h"
#import "APIManager.h"
#import "ComposeViewController.h"

@interface ReplyViewController ()

@end

@implementation ReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)replyAction:(id)sender {
//    [[APIManager shared]replyStatusWithText:self.composeTextView.text completion:^(Tweet *tweet, NSError *error) {
//        if(error){
//            NSLog(@"Error replying to Tweet: %@", error.localizedDescription);
//        }
//        else{
//            //[self.delegate didTweet:tweet];
//            NSLog(@"Reply Tweet Success!");
//        }
//    }];
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
