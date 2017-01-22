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

static NSInteger friendsInRequest = 20;

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
    [[ServerManager sharedManager] getFriendsWithOffset:[self.friendsArray count] count:friendsInRequest
                                              onSuccess:^(NSArray *friends) {
                                                  
                                                  [self.friendsArray addObjectsFromArray:friends];
                                                  
                                                  NSMutableArray *newPaths = [NSMutableArray array];
                                                  for (int i = (int)[self.friendsArray count] - (int)[friends count]; i <  [self.friendsArray count]; i++) {
                                                      [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                                                  }
                                                  
                                                  [self.tableView beginUpdates];
                                                  [self.tableView insertRowsAtIndexPaths:newPaths
                                                                        withRowAnimation:UITableViewRowAnimationTop];
                                                  
                                                  [self.tableView endUpdates];
    }
                                              onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"Error: %@, Status Code: %ld",[error localizedDescription], statusCode);
    }];
}


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"friendCell";
    static NSString *loadID = @"⬇️ LOAD MORE ⬇️";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
    }
    
    if (indexPath.row == [self.friendsArray count]) {
        cell.textLabel.text = loadID;
        // TODO: must fix bug with incorrect textAlligment in friends list
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.imageView.image = nil;
        
    } else {
    
        NSDictionary *friendsDict = [self.friendsArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",
                               [friendsDict objectForKey:@"first_name"],
                               [friendsDict objectForKey:@"last_name"]];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.friendsArray count] + 1;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [self.friendsArray count]) {
        [self getFriendsFromServer];
    }
}




















@end

