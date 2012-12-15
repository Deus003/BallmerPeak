//
//  CABBrain.m
//  Programmable Calc
//
//  Created by Craig Butrick on 12/11/12.
//  Copyright (c) 2012 Craig Butrick. All rights reserved.
//

#import "CABBrain.h"
#include <math.h>
//Private Declarations
@interface CABBrain ()

@property (nonatomic, strong) NSMutableArray *operandStack;


@end

@implementation CABBrain


//Setters and Getters
@synthesize operandStack = _operandStack;


- (NSMutableArray * )operandStack
{
    
    if (!_operandStack) {
        _operandStack = [[NSMutableArray alloc]init];
    }
    
    return _operandStack;
}





//Stack Work
-(void)pushOperand:(double)operand
{
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
    
}

-(double)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    
    return [operandObject doubleValue];
}


//Clear Stack
-(void)clear
{
    [self.operandStack removeAllObjects];
}

//Performing the Maths
-(double)performOperation:(NSString *)operation
{
    double result = 0;
    
    
    //Maths go here
    if ([operation isEqualToString:@"+"])
    {
        result = [self popOperand] + [self popOperand];
        
    }
    else if ([operation isEqualToString:@"-"])
    {
        double subtract = [self popOperand];
        result = [self popOperand] - subtract;
    }
    
    
    else if ([operation isEqualToString:@"/"])
    {
        double divisor = [self popOperand];
        if (divisor !=0)
        {
          result = [self popOperand] / divisor;  
        }
        else
        {
         result = 0;
        }
    }
    
    else if ([operation isEqualToString:@"*"])
    {
        result = [self popOperand] * [self popOperand];
    }
    
    else if([operation isEqualToString:@"sin"])
    {
       
        result = sin([self popOperand] );
    }
    
    else if ([operation isEqualToString:@"cos"])
    {
        result = cos([self popOperand]);
    }
    
    else if ([operation isEqualToString:@"sqrt"])
    {
        
        result = sqrt([self popOperand]);
    }
    
    else if ([operation isEqualToString:@"Pi"])
    {
    
        result = M_PI;
    }
    
    return result;
    
}

@end
