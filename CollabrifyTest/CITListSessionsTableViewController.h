//
//  CITListSessionsTableViewController.h
//  CollabrifyTest
//
//  Created by Brandon Knope on 11/26/13.
//  Copyright (c) 2013 Collabrify.it. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CollabrifySession;
@class CollabrifyClient;
@class CITListSessionsTableViewController;
@protocol CITListSessionsTableViewControllerDelegate <NSObject>

- (void)listSessionsTVC:(CITListSessionsTableViewController *)listSessionsTVC selectedSession:(CollabrifySession *)session;

@end

@interface CITListSessionsTableViewController : UITableViewController

@property (weak, nonatomic) CollabrifyClient *client;
@property (copy, nonatomic) NSString *password;
@property (strong, nonatomic) NSArray *tags;

@property (weak, nonatomic) id<CITListSessionsTableViewControllerDelegate> delegate;

@end
