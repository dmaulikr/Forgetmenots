//
//  FlowerCollectionViewCell.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 11.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowerView.h"

@interface FlowerCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet FlowerView *flowerView;

@end
