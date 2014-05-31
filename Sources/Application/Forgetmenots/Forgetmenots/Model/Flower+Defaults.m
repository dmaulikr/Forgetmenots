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
    
    return flower;
}

+(Flower*)initflowerWithName:(NSString *)name
              andColors:(NSDictionary *)colors
        inManagedContext:(NSManagedObjectContext *)context
{
    Flower *flower = [Flower flowerWithName:name inManagedContext:context];
    
    if (!flower){
        flower = [NSEntityDescription insertNewObjectForEntityForName:@"Flower" inManagedObjectContext:context];
    }
    
    flower.name = name;
    flower.colors = colors;
    
    return flower;
}

+(NSArray*) flowersInManagedContext:(NSManagedObjectContext *)context
{
    NSArray *result = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Flower"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"name != nil"]];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || error){
        // handle error
    }
    else if ([matches count])
    {
        result = matches;
    }
    else
    {
        //nothing here
    }
    
    return result;
}

- (NSString *)description
{
    return self.name;
}

@end
