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
- (double)performOperation: (NSString *)operation;
- (void) clear;

@property (nonatomic, readonly) id program;

+ (NSString *)descriptionOfProgram:(id)program;
+ (double) runProgram:(id)program;

@end
