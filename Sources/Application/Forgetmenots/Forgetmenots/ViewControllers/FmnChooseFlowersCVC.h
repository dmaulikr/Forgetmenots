//
//  PickFlowersViewController.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 11.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForgetmenotsAppDelegate.h"

@class FmnChooseFlowersCVC;

@protocol PickFlowersDelegate <NSObject>

- (void)setSelectedFlowers:(FmnChooseFlowersCVC *)controller selectedFlowers:(NSArray *)flowers;

@end

@interface FmnChooseFlowersCVC : UICollectionViewController <UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) id <PickFlowersDelegate> delegate;

@property (nonatomic, weak) ForgetmenotsAppDelegate *appDelegate;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray* selectedFlowers;

@end
