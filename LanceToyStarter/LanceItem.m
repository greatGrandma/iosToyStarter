//
//  LanceItem.m
//  LanceToyStarter
//
//  Copyright © 2016 LanceHome. All rights reserved.
//

#import "LanceItem.h"

@implementation LanceItem

- (id)initWithItemName:(NSString *)name
        valueInDollars:(int)value
{
    // Call the superclass's designated initializer
    self = [super init];
    // Did the superclass's designated initializer succeed?
    if (self) {
        // Give the instance variables initial values
        self.itemName = name;
        self.valueInDollars = value;
        self.dateCreated = [[NSDate alloc] init];
    }
    
    // Return the address of the newly initialized object
    return self;
}

@end
