//
//  MMSearchViewController.m
//  FlickerAPI
//
//  Created by James Donner on 2/22/13.
//  Copyright (c) 2013 jdsv650. All rights reserved.
//

#import "MMSearchViewController.h"
#import "MMTableViewController.h"

@interface MMSearchViewController ()
{
    
    NSString *searchTerm;
    __weak IBOutlet UITextField *inputTextField;
}
- (IBAction)displayTable:(id)sender;

@end

@implementation MMSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MMTableViewController *tvc = [segue destinationViewController];
    tvc.searchTerm = searchTerm;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)displayTable:(id)sender {
    NSString *readInString;
    
    readInString = [inputTextField text];
    searchTerm = [readInString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
}
@end
