//
//  ViewController.m
//  APITest
//
//  Created by Stepan Paholyk on 1/21/17.
//  Copyright © 2017 Stepan Paholyk. All rights reserved.
//

#import "ViewController.h"
#import "ServerManager.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *friendsArray;

@end

@implementation ViewController

static NSInteger friendsInRequest = 5;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.friendsArray = [NSMutableArray array];
    [self getFriendsFromServer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API

- (void) getFriendsFromServer {
    [[ServerManager sharedManager] getFriendsWithOffset:[self.friendsArray count]
                                                  count:friendsInRequest
                                              onSuccess:^(NSArray *friends) {
                                                  [self.friendsArray addObjectsFromArray:friends];
                                                  
                                                  [self.tableView reloadData];
                                                  NSMutableArray *newPaths = [NSMutableArray array];
                                                  for (int i = (int)[self.friendsArray count] - (int)[friends count]; i < (int)[self.friendsArray count]; i++) {
                                                      [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                                                  }
                                                  
                                                  [self.tableView beginUpdates];
                                                  [self.tableView insertRowsAtIndexPaths:newPaths
                                                                        withRowAnimation:UITableViewRowAnimationTop];
                                                  
    }
                                              onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"Error: %@, Status Code: %ld",[error localizedDescription], statusCode);
    }];
}

@end














