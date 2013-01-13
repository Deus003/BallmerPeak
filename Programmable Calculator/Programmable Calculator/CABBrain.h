//
//  CABBrain.h
//  Programmable Calc
//
//  Created by Craig Butrick on 12/11/12.
//  Copyright (c) 2012 Craig Butrick. All rights reserved.
//

#import <Foundation/Foundation.h>

//Public API
@interface CABBrain : NSObject

- (void) pushOperand: (double)operand;
- (void)addOperationToStack: (NSString *)operation;
- (void) clear;
-(double)equalPressed;

@property (nonatomic, readonly) id program;

+ (NSString *)descriptionOfProgram:(id)program;
+ (double) runProgram:(id)program;
+ (double) runProgram:(id)program
usingVariablesAsValues:(NSDictionary *)variableValues;
+ (NSSet *) variablesUsedInProgram: (id)program;

@end
