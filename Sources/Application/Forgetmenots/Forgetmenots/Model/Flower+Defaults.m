//
//  Flower+Defaults.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 21.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "Flower+Defaults.h"

@implementation Flower (Defaults)

+(Flower*)flowerWithName:(NSString *)name
        inManagedContext:(NSManagedObjectContext *)context
{
    Flower *flower = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Flower"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || error || [matches count] > 1){
        // handle error
    }
    else if ([matches count])
    {
        flower = [matches firstObject];
    }
    else
    {
        flower = [NSEntityDescription insertNewObjectForEntityForName:@"Flower" inManagedObjectContext:context];
        
        flower.name = name;
    }
    
    
    return flower;
}

+(NSArray*) flowersInManagedContext:(NSManagedObjectContext *)context
{
    return @[[Flower flowerWithName:@"Forgetmenot" inManagedContext:context],
             [Flower flowerWithName:@"Rose" inManagedContext:context],
             [Flower flowerWithName:@"Tulip" inManagedContext:context],
             [Flower flowerWithName:@"Mum" inManagedContext:context],
             [Flower flowerWithName:@"Sunflower" inManagedContext:context],
             [Flower flowerWithName:@"Amaryllis" inManagedContext:context],
             [Flower flowerWithName:@"Gerbera" inManagedContext:context],
             [Flower flowerWithName:@"Alstroemeria" inManagedContext:context],
             [Flower flowerWithName:@"Lilium" inManagedContext:context]];
}

- (NSString *)description
{
    return self.name;
}

@end
