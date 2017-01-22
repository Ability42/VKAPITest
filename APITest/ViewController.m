//
//  ViewController.m
//  APITest
//
//  Created by Stepan Paholyk on 1/21/17.
//  Copyright © 2017 Stepan Paholyk. All rights reserved.
//

#import "ViewController.h"
#import "ServerManager.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *friendsArray;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ViewController

static NSInteger friendsInRequest = 5;

#pragma mark - VC lifecycle

- (void)loadView {
    [super loadView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
}

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


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"friendCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2
                                      reuseIdentifier:identifier];
    }
    
    NSDictionary *friendsDict = [self.friendsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"@% @%", [friendsDict objectForKey:@"first_name"], [friendsDict objectForKey:@"last_name"]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.friendsArray count];
}
@end














