//
//  Flower+Defaults.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 21.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "Flower.h"

@interface Flower (Defaults)

+(Flower*)flowerWithName:(NSString *)name
        inManagedContext:(NSManagedObjectContext *)context;

+(Flower*)initflowerWithName:(NSString *)name
                   andColors:(NSDictionary *)colors
            inManagedContext:(NSManagedObjectContext *)context;

+(NSArray*) flowersInManagedContext:(NSManagedObjectContext *)context;

- (NSString *)description;

@end
