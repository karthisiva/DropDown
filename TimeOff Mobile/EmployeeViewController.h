//
//  EmployeeViewController.h
//  TimeOff Mobile
//
//  Created by Subramani B R on 4/17/15.
//  Copyright (c) 2015 Subramani B R. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "NIDropDown.h"
#import <MessageUI/MessageUI.h>
#import "IHKeyboardAvoiding.h"
@interface EmployeeViewController : UIViewController<UITextFieldDelegate,MFMailComposeViewControllerDelegate,NIDropDownDelegate>
{
    sqlite3 *database;
    NSArray *documentPaths;
    NSString *documentsDir;
    NSString *databasePath;
    NIDropDown * dropDown;

}
- (IBAction)actionSave:(id)sender;

@property (nonatomic, strong) NSString *strLate;
@property (strong, nonatomic) IBOutlet UIView *containerView;
- (IBAction)actionMail:(id)sender;
@property (nonatomic, strong) NSString *databasePath;
@property (strong, nonatomic) IBOutlet UITextField *txtName;
- (IBAction)actionReason:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imgLocation;
@property (strong, nonatomic) IBOutlet UIImageView *imgDept;
@property (strong, nonatomic) IBOutlet UITextField *txtRemarks;
@property (strong, nonatomic) IBOutlet UIButton *btnLocation;
@property (strong, nonatomic) IBOutlet UIImageView *imgReason;
- (IBAction)actionIWillBe:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnDept;
@property (strong, nonatomic) IBOutlet UIImageView *imgIWillBe;
@property (strong, nonatomic) IBOutlet UIButton *btnIWillBe;
@property (strong, nonatomic) IBOutlet UITextField *txtDate;
@property (strong, nonatomic) IBOutlet UIButton *btnreason;
@property (strong, nonatomic) IBOutlet UISegmentedControl *SegLate;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
- (IBAction)actionLocation:(id)sender;
- (IBAction)actionSeg:(id)sender;

- (IBAction)actionDept:(id)sender;

@end
