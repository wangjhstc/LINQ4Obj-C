//
//  NSArray+LINQ_Aggregation.m
//  LINQ
//
//  Created by Michal Konturek on 22/06/2013.
//  Copyright (c) 2013 Michal Konturek. All rights reserved.
//

#import "NSArray+LINQ_Aggregation.h"

@implementation NSArray (LINQ_Aggregation)

- (id)LINQ_avg {
    id sum = [self LINQ_sum];
    
    NSDecimalNumber *result = [NSDecimalNumber decimalNumberWithDecimal:[sum decimalValue]];
    NSDecimalNumber *count = [NSDecimalNumber decimalNumberWithDecimal:
                              [[NSNumber numberWithInteger:[self count]] decimalValue]];
    
    return [result decimalNumberByDividingBy:count];
}

- (id)LINQ_avgForKey:(NSString *)key {
    return [self _aux_applyOperator:@"@avg" toKey:key];
}

- (id)LINQ_max {
    return [self LINQ_aggregate:^id(id item, id aggregate) {
        return ([item compare:aggregate] == NSOrderedDescending) ? item : aggregate;
    }];
}

- (id)LINQ_maxForKey:(NSString *)key {
    return [self _aux_applyOperator:@"@max" toKey:key];
}

- (id)LINQ_min {
    return [self LINQ_aggregate:^id(id item, id aggregate) {
        return ([item compare:aggregate] == NSOrderedAscending) ? item : aggregate;
    }];
}

- (id)LINQ_minForKey:(NSString *)key {
    return [self _aux_applyOperator:@"@min" toKey:key];
}

- (id)LINQ_sum {
    return [self LINQ_aggregate:^id(id item, id aggregate) {
        return [NSNumber numberWithInt:[aggregate integerValue] + [item integerValue]];
    }];
}

- (id)LINQ_sumForKey:(NSString *)key {
    return [self _aux_applyOperator:@"@sum" toKey:key];
}

- (id)LINQ_aggregate:(LINQAccumulatorBlock)accumulatorBlock {
    if (!accumulatorBlock) return self;
    
    id accumulator = nil;
    for (id item in self) {
        if (!accumulator) accumulator = item;
        else accumulator = accumulatorBlock(item, accumulator);
    }
    return accumulator;
}

- (id)_aux_applyOperator:(NSString *)op toKey:(NSString *)key {
    NSString *keyPath = [NSString stringWithFormat:@"%@.%@", op, key];
    return [self valueForKeyPath:keyPath];
}

- (NSUInteger)LINQ_count:(LINQConditionBlock)conditionBlock {
    return [[self LINQ_where:conditionBlock] count];
}


@end