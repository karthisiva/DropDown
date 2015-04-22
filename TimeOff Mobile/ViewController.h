//
//  ViewController.h
//  TimeOff Mobile
//
//  Created by Subramani B R on 4/17/15.
//  Copyright (c) 2015 Subramani B R. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>


@interface ViewController : UIViewController<UITextFieldDelegate>
{
    sqlite3 *database;
    NSArray *documentPaths;
    NSString *documentsDir;
    NSString *databasePath;
}
@property (strong, nonatomic) IBOutlet UITextField *txtUsername;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
- (IBAction)actionLogin:(id)sender;


@end

