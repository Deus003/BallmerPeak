//
//  CABViewController.m
//  Programmable Calc
//
//  Created by Craig Butrick on 12/11/12.
//  Copyright (c) 2012 Craig Butrick. All rights reserved.
//

#import "CABViewController.h"
#import "CABBrain.h"


//Private API
@interface CABViewController ()

@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property   (nonatomic,strong) CABBrain *brain;

@end

@implementation CABViewController
//Getters and Setters
@synthesize display;
@synthesize secondaryDisplay;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

-(CABBrain *) brain
{
    if (!_brain) _brain = [[CABBrain alloc]init];
    return _brain;
}


//Controller Actions
- (IBAction)digitPressed:(UIButton *)sender
{
    //Adds current digit to display
    NSString *digit = [sender currentTitle];
    if (userIsInTheMiddleOfEnteringANumber) {
    
    
    self.display.text = [self.display.text stringByAppendingString:digit];
        
    }
    else
    {
        //Places first digit in display and replaces 0
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

//Adds Decimal to display, iff there isn't one there
- (IBAction)decimalPressed:(UIButton *)sender
{
    
    if (!userIsInTheMiddleOfEnteringANumber)
    {
        self.display.text = [NSString stringWithFormat:@""];
    }
    NSRange decimalTest  = [self.display.text rangeOfString:@"."];
    
    if (decimalTest.length < 1)
    {
        self.display.text = [self.display.text stringByAppendingString:@"."];
        self.userIsInTheMiddleOfEnteringANumber=YES;
    }
    
    
    
}



//Enter pressed pushes displays value to stack
- (IBAction)enterPressed
{
    NSLog(@"%@", self.display.text);
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.secondaryDisplay.text = [self.secondaryDisplay.text stringByAppendingString:self.display.text];
    self.secondaryDisplay.text = [self.secondaryDisplay.text stringByAppendingString:@" "];
    self.display.text = [NSString stringWithFormat:@""];
}

//Sends operator to "brain"  Yes, Carroll, I know there is a typo.
- (IBAction)operationrPressed:(UIButton *)sender
{
    if (userIsInTheMiddleOfEnteringANumber)
    {
        [self enterPressed];
    }
    
    NSString *operation = [sender currentTitle];
    NSLog(@"%@",operation);
    self.secondaryDisplay.text = [self.secondaryDisplay.text stringByAppendingString:operation];
    self.secondaryDisplay.text = [self.secondaryDisplay.text stringByAppendingString:@" "];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    [self.brain pushOperand:[self.display.text doubleValue]];
}


//Clears the stack, primary, and secondary displays
- (IBAction)clr:(UIButton *)sender
{
    self.display.text = @"";
    self.secondaryDisplay.text = @"";
    [self.brain clear];
}





@end
