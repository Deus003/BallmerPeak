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
@property (nonatomic, strong) NSSet *operations;
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



@synthesize operations= _operations;
-(NSSet *)operations
{
    if(!_operations)
    {
        NSString *plus = @"+";
        NSString *minus = @"-";
        NSString *mult = @"*";
        NSString *neg = @"+/-";
        NSString *sin = @"sin";
        NSString *cos = @"cos";
        NSString *pi = @"Pi";
        NSString *sqrt = @"sqrt";
        _operations = [[NSSet alloc]initWithObjects:plus, minus, mult, neg, sin, cos, pi, sqrt, nil];
    }
    return _operations;
}

//Run Program runs Program loaded in program stack through recursion
//Returns Double that is result
+(double)runProgram:(id)program
{
    NSMutableArray *stack;
    
    if([program isKindOfClass:[NSArray class]])
    {
        stack = [program mutableCopy];
    }
    return [self popOperandOffOfProgramStack:stack];
}

//Run Program with Variables selected by user.  Loads Program, replaces
//variables with values, runs program.

+(double)runProgram:(id)program
usingVariablesAsValues:(NSDictionary *)variableValues
{
    if (![program isKindOfClass:[NSArray class]])
    {
        return 0;
    }
    
    NSMutableArray *programWithoutVariables;
    
    for (int i = 0; i < [program count]; i++)
    {
        id topOfStack = [program objectAtIndex:i];
        if ([topOfStack isKindOfClass:[NSNumber class]])
        {
            [programWithoutVariables addObject:topOfStack];
        }
        if ([topOfStack isKindOfClass:[NSString class]])
        {
            if ([topOfStack isEqual:@"a"] ||
                [topOfStack isEqual:@"b"] ||
                [topOfStack isEqual:@"c"] ||
                [topOfStack isEqual:@"d"])
            {
                topOfStack = [variableValues objectForKey: topOfStack];
                [programWithoutVariables addObject:topOfStack];
            }
            else
            {
                [programWithoutVariables addObject:topOfStack];
            }
        }
    }
    
    
    return [self runProgram:programWithoutVariables];
}

//Clears program stack
-(void)clear
{
    [self.programStack removeAllObjects];
}

//Copies program stack and returns
-(id)program
{
    return [self.programStack copy];
}

//Copies Program Stack and removes all non variables
//Returns NSSet of Variables used
+ (NSSet *) variablesUsedInProgram:(id)program
{
    
    NSMutableSet *variables = nil;
    if (![program isKindOfClass:[NSArray class]])
    {
        return nil;
    }
    
    NSMutableArray *test = [program mutableCopy];
    id topOfTest = [test lastObject];
    if (topOfTest)
    {
        [test removeLastObject];
        
        if ([topOfTest isKindOfClass:[NSNumber class]])
        {
            [self variablesUsedInProgram:test];
        }
             
        if ([topOfTest isKindOfClass:[NSString class]])
        {
            if ([topOfTest isEqualToString:@"+"])
            {
                [self variablesUsedInProgram:test];
            }
            else if ([topOfTest isEqualToString:@"-"])
            {
                [self variablesUsedInProgram:test];
            }
            else if ([topOfTest isEqualToString:@"/"])
            {
                [self variablesUsedInProgram:test];
            }
            else if ([topOfTest isEqualToString:@"*"])
            {
                [self variablesUsedInProgram:test];
            }
            else if([topOfTest isEqualToString:@"sin"])
            {
                [self variablesUsedInProgram:test];
            }
            else if ([topOfTest isEqualToString:@"cos"])
            {
                [self variablesUsedInProgram:test];
            }
            else if ([topOfTest isEqualToString:@"sqrt"])
            {
                [self variablesUsedInProgram:test];
            }
            else if ([topOfTest isEqualToString:@"Pi"])
            {
               [self variablesUsedInProgram:test];
            }
            else if ([topOfTest isEqualToString:@"+/-"])
            {
                [self variablesUsedInProgram:test];
            }
            else{
               [variables addObject:topOfTest]; 
            }

        NSSet *variableList = [variables copy];
        return variableList;
        }
    }
    
    return variables;
}

//Return Description of Program for display
+ (NSString *)descriptionOfProgram:(id)program
{
    return @"2";
}


//Push operand for backwards compatibility with RPN Calculator
-(void)pushOperand:(double)operand
{
    [self.programStack addObject: [NSNumber numberWithDouble:operand]];
    
}

//Perform Operation for backwards compatibility with RPN Calculator
-(double)performOperation:(NSString *)operation
{
    [self.programStack addObject:operation];
    return[[self class] runProgram:self.program];
}

//Add Variable to Stack.  Adds compatiblility for variables
-(void)pushVariableToStack:(NSString *)variable
{
    [self.programStack addObject:variable];
}

//Main method off running programmible calculator
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