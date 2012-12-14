//
//  CABBrain.h
//  RPNCalculator
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


@end
