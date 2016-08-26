//
//  LanceItem.h
//  LanceToyStarter
//
//  Copyright © 2016 LanceHome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LanceItem : NSObject

- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value;

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic) int valueInDollars;
@property (nonatomic, strong) NSDate *dateCreated;

@end
