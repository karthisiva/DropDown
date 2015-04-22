//
//  EmployeeViewController.m
//  TimeOff Mobile
//
//  Created by Subramani B R on 4/17/15.
//  Copyright (c) 2015 Subramani B R. All rights reserved.
//

#import "EmployeeViewController.h"
#import <MessageUI/MessageUI.h>
@interface EmployeeViewController ()

@end

@implementation EmployeeViewController
@synthesize databasePath,strLate;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Employee Report";

    documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDir = [documentPaths objectAtIndex:0];
    databasePath=[documentsDir stringByAppendingPathComponent:@"EmployeeReport.sqlite"];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    

    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
           
            char *errMsg;

            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS EMPLOYEE (name TEXT, Department TEXT, location TEXT ,reason TEXT ,timelate INTEGER ,late TEXT ,datelate DATETIME ,remarks TEXT)";
            
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) == SQLITE_OK)
            {
            NSLog(@"Employee table created successfully");
            }
            else
            {
                NSLog(@"Failed to create table");
            }

            sqlite3_close(database);
            
        } else {
            NSLog(@"Failed to open/create database");
        }
    }
    else
    {
        NSLog(@"Database already Exists");
    }
    NSDateFormatter *dateformat=[[NSDateFormatter alloc]init];
    NSDate *today=[NSDate dateWithTimeIntervalSinceNow:0];
    [dateformat setDateFormat:@"dd/MM/yyyy"];
    NSString *tmep=[dateformat stringFromDate:today];
    self.txtDate.text=tmep;
    
   // [IHKeyboardAvoiding setAvoidingView:self.view withTriggerView:self.containerView];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.txtName resignFirstResponder];
    [self.txtDate resignFirstResponder];
    [self.txtRemarks resignFirstResponder];


    return YES;
}
-(void)Insertdata:(NSString*)query{
    
       if(sqlite3_open([databasePath UTF8String],&database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"%@",query];
        
        char *errmsg=nil;
        
        if(sqlite3_exec(database, [querySQL UTF8String], NULL, NULL, &errmsg)==SQLITE_OK)
        {
            NSLog(@".. Row Added ..");
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Employee Report Has been Saved Successfully !" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
    }
    sqlite3_close(database);
}
- (IBAction)actionSave:(id)sender
{
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO employee (name, Department, location, reason, timelate, late,datelate,remarks) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@')",self.txtName.text,[self.btnDept currentTitle],[self.btnLocation currentTitle],[self.btnreason currentTitle],[self.btnIWillBe currentTitle],strLate,self.txtDate.text,self.txtRemarks.text];
    NSLog(@"%@",sql);
    [self Insertdata:sql];
    
//    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
//    //[self openDB];
//    
//    
//    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
//    {
//        NSString *sql =[NSString stringWithFormat:@"SELECT * FROM EMPLOYEE"];
//        sqlite3_stmt *statement;
//        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK)
//        {
//            while (sqlite3_step(statement)== SQLITE_ROW)
//            {
//                
//                
//                
//                NSString * str = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
//                
//                
//                [tempArray addObject:str];
//            }
//            NSLog(@"fetched row----->%@",tempArray);
//        }
//        
//    }
//

}
- (IBAction)actionReason:(id)sender
{
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"Traffic", @"Sick", @"Emergency", @"Personal", @"Official",nil];
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :@"down"];
        
        dropDown.delegate = self;
        [self.imgReason setImage:[UIImage imageNamed:@"upone.png"]];

    }
    else
    {
        [dropDown hideDropDown:sender];
      [self.imgReason setImage:[UIImage imageNamed:@"down.png"]];

        dropDown=nil;

    }

}

- (IBAction)actionIWillBe:(id)sender
{
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"1", @"5", @"10", @"15", @"30",nil];
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :@"down"];
        dropDown.delegate = self;
        [self.imgIWillBe setImage:[UIImage imageNamed:@"upone.png"]];

    }
    else
    {
        [dropDown hideDropDown:sender];
        dropDown=nil;
        [self.imgIWillBe setImage:[UIImage imageNamed:@"down.png"]];


    }

}

- (IBAction)actionLocation:(id)sender
{
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"Tambaram", @"Velacheri", @"Guindy", @"Thiruvanmiyur", @"Native",nil];
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :@"down"];
        dropDown.delegate = self;
        [self.imgLocation setImage:[UIImage imageNamed:@"upone.png"]];

    }
    else
    {
        [dropDown hideDropDown:sender];
        dropDown=nil;
        [self.imgLocation setImage:[UIImage imageNamed:@"down.png"]];


    }

}

- (IBAction)actionSeg:(id)sender
{
    switch (self.segmentedControl.selectedSegmentIndex)
    {
        case 0:
           strLate = @"Days";
            break;
        case 1:
            strLate = @"Hours";
            break;
        case 2:
            strLate = @"Days";

        default:
            break; 
    }
}
-(void)openDB{
    if (sqlite3_open([[self filePath] UTF8String], &database)!=SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert(0, @"Database failed to open");
        
    }else{
        NSLog(@"database opened");
    }
}
-(NSString *) filePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"EmployeeReport.sqlite"];
    NSLog(@"%@",path);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:@"EmployeeReport.sqlite"];
    
}
- (IBAction)actionDept:(id)sender
{
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"HR", @"IT", @"Sales", @"Bpo", @"Consultancy",nil];
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :@"down"];
        dropDown.delegate = self;
        [self.imgDept setImage:[UIImage imageNamed:@"upone"]];

    }
    else
    {
        [dropDown hideDropDown:sender];
        dropDown=nil;
        [self.imgDept setImage:[UIImage imageNamed:@"down.png"]];


    }
          //Retrieve the values of database
}


- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel{
    //    [dropDown release];
    dropDown = nil;
}

- (IBAction)actionMail:(id)sender
{
  
    NSArray *toRecipents = [NSArray arrayWithObjects:@"angutpc@gmail.com",@"s.suryakarthi@gmail.com", nil];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"EmployeeReport" ofType:@"html"];
    NSString *htmlPage = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    htmlPage = [htmlPage stringByReplacingOccurrencesOfString:@"<--Employee Name-->" withString:self.txtName.text];
    htmlPage = [htmlPage stringByReplacingOccurrencesOfString:@"<--Department-->" withString:[self.btnDept titleForState:UIControlStateNormal]];
    htmlPage = [htmlPage stringByReplacingOccurrencesOfString:@"<--Location-->" withString:[self.btnLocation titleForState:UIControlStateNormal]];
    htmlPage = [htmlPage stringByReplacingOccurrencesOfString:@"<--Reason-->" withString:[self.btnreason titleForState:UIControlStateNormal]];
    htmlPage = [htmlPage stringByReplacingOccurrencesOfString:@"<--Timelate-->" withString:[self.btnIWillBe titleForState:UIControlStateNormal]];
    htmlPage = [htmlPage stringByReplacingOccurrencesOfString:@"<--Late-->" withString:strLate];
    htmlPage = [htmlPage stringByReplacingOccurrencesOfString:@"<--Datelate-->" withString:self.txtDate.text];
    htmlPage = [htmlPage stringByReplacingOccurrencesOfString:@"<--Remarks-->" withString:self.txtRemarks.text];
MFMailComposeViewController   * mailComposer = [[MFMailComposeViewController alloc]init];
    mailComposer.mailComposeDelegate = self;
    [mailComposer setSubject:@"Employee Report"];
    [mailComposer setToRecipients:toRecipents];
    [mailComposer setMessageBody:htmlPage isHTML:YES];
    [self presentViewController:mailComposer animated:YES completion:nil];
}
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
        {
            NSLog(@"Mail sent");
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Report Has been Sent Successfully !" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            break;
        }
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    

   
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    if ([self.txtDate isFirstResponder]||[self.txtRemarks isFirstResponder]) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect f = self.view.frame;
            f.origin.y = -keyboardSize.height;
            self.view.frame = f;
        }];

    }
    }

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
