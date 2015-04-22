//
//  ViewController.m
//  TimeOff Mobile
//
//  Created by Subramani B R on 4/17/15.
//  Copyright (c) 2015 Subramani B R. All rights reserved.
//

#import "ViewController.h"
#import "EmployeeViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.title=@"Login";
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionLogin:(id)sender
{
    if ([self.txtPassword.text isEqualToString:@"user"] && [self.txtPassword.text isEqualToString:@"user"] ) {
        EmployeeViewController *employee = [self.storyboard instantiateViewControllerWithIdentifier:@"EmployeeViewController"];
        [self.navigationController pushViewController:employee animated:YES];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"sorry!!!" message:@"please enter valid username and password" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
    }
    
  
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.txtPassword resignFirstResponder];
    [self.txtUsername resignFirstResponder];
    return YES;
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
    if ([self.txtPassword isFirstResponder]||[self.txtUsername isFirstResponder]) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect f = self.view.frame;
            f.origin.y = -keyboardSize.height+150;
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

