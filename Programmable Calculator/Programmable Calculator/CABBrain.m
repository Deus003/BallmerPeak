//
//  CABBrain.m
//  Programmable Calc
//
//  Created by Craig Butrick on 12/11/12.
//  Copyright (c) 2012 Craig Butrick. All rights reserved.
//

#import "CABBrain.h"

//Private Declarations
@interface CABBrain ()
@property (nonatomic, strong) NSMutableArray *programStack;
@end

@implementation CABBrain

//Setters and Getters
@synthesize programStack = _programStack;


- (NSMutableArray * )programStack
{
    if (!_programStack) {
        _programStack = [[NSMutableArray alloc]init];
    }
    
    return _programStack;
}

+(double)runProgram:(id)program
{
    NSMutableArray *stack;
    if([program isKindOfClass:[NSArray class]])
    {
        stack = [program mutableCopy];
    }
    return [self popOperandOffOfProgramStack:stack];
}

-(void)clear
{
    [self.programStack removeAllObjects];
}

-(id)program
{
    return [self.programStack copy];
}

+ (NSString *)descriptionOfProgram:(id)program
{
    return @"2";
}


-(void)pushOperand:(double)operand
{
    [self.programStack addObject: [NSNumber numberWithDouble:operand]];
    
}

-(double)performOperation:(NSString *)operation
{
    [self.programStack addObject:operation];
    return[[self class] runProgram:self.program];
}

+(double)popOperandOffOfProgramStack: (NSMutableArray *)stack
{
    double result = 0;
    id topOfStack = [stack lastObject];
    if(topOfStack)
    {
        [stack removeLastObject];
    }
    
    if ([topOfStack isKindOfClass:[NSNumber class]])
    {
        result = [topOfStack doubleValue];
    }
    else if([topOfStack isKindOfClass:[NSString class]])
    {
        NSString *operation = topOfStack;
        if ([operation isEqualToString:@"+"])
        {
            result = [self popOperandOffOfProgramStack:stack] + [self popOperandOffOfProgramStack:stack];
            
        }
        else if ([operation isEqualToString:@"-"])
        {
            double subtract = [self popOperandOffOfProgramStack:stack];
            result = [self popOperandOffOfProgramStack:stack] - subtract;
        }
        
        
        else if ([operation isEqualToString:@"/"])
        {
            double divisor = [self popOperandOffOfProgramStack:stack];
            if (divisor !=0)
            {
                result = [self popOperandOffOfProgramStack:stack] / divisor;
            }
            else
            {
                result = 0;
            }
        }
        
        else if ([operation isEqualToString:@"*"])
        {
            result = [self popOperandOffOfProgramStack:stack] * [self popOperandOffOfProgramStack:stack];
        }
        
        else if([operation isEqualToString:@"sin"])
        {
            result = sin([self popOperandOffOfProgramStack:stack] );
        }
        
        else if ([operation isEqualToString:@"cos"])
        {
            result = cos([self popOperandOffOfProgramStack:stack]);
        }
        
        else if ([operation isEqualToString:@"sqrt"])
        {
            result = sqrt([self popOperandOffOfProgramStack:stack]);
        }
        
        else if ([operation isEqualToString:@"Pi"])
        {
            result = M_PI;
        }
        
        else if ([operation isEqualToString:@"+/-"])
        {
            result = -[self popOperandOffOfProgramStack:stack];
        }
    }
        return result;

    
}



@end