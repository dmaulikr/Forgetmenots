//
//  PickFlowersViewController.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 11.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PickFlowersViewController;

@protocol PickFlowersDelegate <NSObject>

- (void)setSelectedFlowers:(PickFlowersViewController *)controller selectedFlowers:(NSArray *)flowers;

@end

@interface PickFlowersViewController : UICollectionViewController <UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) id <PickFlowersDelegate> delegate;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray* selectedFlowers;

@end
