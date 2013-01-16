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
    
    //Limit size of secondary display
    NSLog(@"Secondary Display %u",[self.secondaryDisplay.text length]);
    if ([self.secondaryDisplay.text length]>30)
    {
        self.secondaryDisplay.text = [self.secondaryDisplay.text substringFromIndex:16];
       
    }
    
    self.display.text = [NSString stringWithFormat:@""];
    
}

//Sends operator to "brain"  
- (IBAction)operationrPressed:(UIButton *)sender
{
    if (userIsInTheMiddleOfEnteringANumber)
    {
        [self enterPressed];
    }
    
    NSString *operation = [sender currentTitle];
    NSLog(@"%@",operation);
    
    //Sends data to secondary display.
    self.secondaryDisplay.text = [self.secondaryDisplay.text stringByAppendingString:operation];
    self.secondaryDisplay.text = [self.secondaryDisplay.text stringByAppendingString:@" "];
    
    [self.brain addOperationToStack:operation];
}

- (IBAction)equal:(UIButton *)sender
{
    double result = 0;
    self.secondaryDisplay.text = [self.secondaryDisplay.text stringByAppendingString:@"="];
    self.secondaryDisplay.text = [self.secondaryDisplay.text stringByAppendingString:@" "];
    result = [self.brain equalPressed];
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

- (IBAction)backspace:(UIButton *)sender
{
    if ([self.display.text length] >1)
    {
        self.display.text = [self.display.text substringToIndex:[self.display.text length]-1];
    }
    else
    {
        self.display.text = @"";
    }
}

//Add Variable to Program
- (IBAction)variable:(UIButton *)sender
{
    NSString *variable = [sender currentTitle];
    //Adds variable to display
    if (userIsInTheMiddleOfEnteringANumber)
    {
        self.display.text = [self.display.text stringByAppendingString:variable];
    }
    else
    {
        //Places first digit in display and replaces 0
        self.display.text = variable;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }

    [self enterPressed];
}

//Runs Programs With Variable's Values Sent
- (IBAction)testCases:(UIButton *)sender
{
    //create dictionary based on test case
    //call testCase from self.brain.
    //Also create method to handle display...
}


@end
