//
//  NSArray+LINQ_Projection.h
//  LINQ
//
//  Created by Michal Konturek on 22/06/2013.
//  Copyright (c) 2013 Michal Konturek. All rights reserved.
//

#import "LINQ.h"

@interface NSArray (LINQ_Projection)

/**
 Projects values that are based on a transform function.
 */
- (instancetype)LINQ_select:(LINQSelectorBlock)selectorBlock;


/**
 Projects sequences of values that are based on a transform
 function and then flattens them into one sequence.
 */
- (instancetype)LINQ_selectMany:(LINQSelectorBlock)selectorBlock;

@end