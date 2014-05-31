//
//  FlowerCollectionViewCell.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 11.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FmnFlowerV.h"

@interface FmnFlowerCVCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet FmnFlowerV *flowerView;

@end
