//
//  DataManager.h
//  Refugees
//
//  Created by Finn Gaida on 18.09.15.
//  Copyright © 2015 Finn Gaida. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    FGTypeRefugee,
    FGTypeHelper,
    FGTypeDude
} FGType;

@interface DataManager : NSObject

@property (nonatomic) FGType type;

+ (instancetype)sharedManager;

@end
