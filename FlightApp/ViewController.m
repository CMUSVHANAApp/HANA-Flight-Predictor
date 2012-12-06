//
//  ViewController.m
//  FlightApp
//
//  Created by Edward Akoto on 12/2/12.
//  Copyright (c) 2012 Edward Akoto. All rights reserved.
//



#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize formTableView, displayTableView, submitButton;


-(IBAction)buttonPressed:(id)sender{
    
    NSString *alertViewText = [[NSString alloc] initWithFormat:@"Process JSON object"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Title" message:alertViewText delegate:(nil) cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    

    
    
    
                          [alert show];
                         
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(tableView == self.formTableView){
    
    return 5;
    }else{
        return 15;
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    
    
    // Configure the cell...
    if(tableView == self.formTableView){
        
        
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        if ([indexPath section] == 0) {
            UITextField *playerTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 20, 250, 30)];
            playerTextField.adjustsFontSizeToFitWidth = NO;
            playerTextField.textColor = [UIColor blackColor];
            
            if([indexPath row] == 0){
                playerTextField.placeholder = @"Airline";
                playerTextField.keyboardType = UIKeyboardTypeDefault;
                playerTextField.returnKeyType = UIReturnKeyNext;
            }
            else if([indexPath row] == 1){
                playerTextField.placeholder = @"Flight Number";
                playerTextField.keyboardType = UIKeyboardTypeDefault;
                playerTextField.returnKeyType = UIReturnKeyNext;
            }
            else if ([indexPath row] == 2) {
                playerTextField.placeholder = @"Departure Date";
                playerTextField.keyboardType = UIKeyboardTypeDefault;
                playerTextField.returnKeyType = UIReturnKeyNext;
            }
            else if([indexPath row] == 3){
                playerTextField.placeholder = @"Departure Airport";
                playerTextField.keyboardType = UIKeyboardTypeDefault;
                playerTextField.returnKeyType = UIReturnKeyDone;
                
                
            }else if([indexPath row] == 4){
                playerTextField.placeholder = @"Destination Airport";
                playerTextField.keyboardType = UIKeyboardTypeDefault;
                playerTextField.returnKeyType = UIReturnKeyDone;
                
            }
            playerTextField.backgroundColor = [UIColor clearColor];
            playerTextField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
            playerTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
            
            
            playerTextField.tag = 0;
            //playerTextField.delegate = self;
            
            playerTextField.clearButtonMode = UITextFieldViewModeNever; // no clear 'x' button to the right
            [playerTextField setEnabled: YES];
            
            [cell addSubview:playerTextField];
            
        }
        
        
        
        
    }

    
    if(tableView == self.displayTableView){
        
        
        
            cell.accessoryType = UITableViewCellAccessoryNone;
        
            if ([indexPath section] == 0) {
                UITextField *playerTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 20, 250, 30)];
                playerTextField.adjustsFontSizeToFitWidth = NO;
                playerTextField.textColor = [UIColor blackColor];
                
                if([indexPath row] == 0){
                    playerTextField.placeholder = @"Airline";
                    playerTextField.keyboardType = UIKeyboardTypeDefault;
                    playerTextField.returnKeyType = UIReturnKeyNext;
                }
                else if([indexPath row] == 1){
                    playerTextField.placeholder = @"Flight Number";
                    playerTextField.keyboardType = UIKeyboardTypeDefault;
                    playerTextField.returnKeyType = UIReturnKeyNext;
                }
                else if ([indexPath row] == 2) {
                    playerTextField.placeholder = @"Departure Date";
                    playerTextField.keyboardType = UIKeyboardTypeDefault;
                    playerTextField.returnKeyType = UIReturnKeyNext;
                                     }
                else if([indexPath row] == 3){
                    playerTextField.placeholder = @"Departure Airport";
                    playerTextField.keyboardType = UIKeyboardTypeDefault;
                    playerTextField.returnKeyType = UIReturnKeyDone;
                                       
                   
                }else if([indexPath row] == 4){
                    playerTextField.placeholder = @"Destination Airport";
                    playerTextField.keyboardType = UIKeyboardTypeDefault;
                    playerTextField.returnKeyType = UIReturnKeyDone;

                }
                playerTextField.backgroundColor = [UIColor clearColor];
                playerTextField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
                playerTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
             
              
                playerTextField.tag = 0;
                //playerTextField.delegate = self;
                
                playerTextField.clearButtonMode = UITextFieldViewModeNever; // no clear 'x' button to the right
                [playerTextField setEnabled: YES];
                
               
                
            }
        
        
        
            
    }
   
    
    return cell;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.formTableView.backgroundColor = [UIColor clearColor];
    self.formTableView.opaque = NO;
    self.formTableView.backgroundView = nil;
    
    

  
    
   

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
