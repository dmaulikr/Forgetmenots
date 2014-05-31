//
//  FmnChooseFlowersCVC.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 11.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "FmnChooseFlowersCVC.h"
#import "FmnFlowerCVCell.h"
#import "Flower+Defaults.h"
#import "FmnCreateEventTVC.h"

@interface FmnChooseFlowersCVC ()

@property (nonatomic, strong) NSArray* flowers;

@end

@implementation FmnChooseFlowersCVC

-(ForgetmenotsAppDelegate *)appDelegate
{
    if (_appDelegate)
    {
        return _appDelegate;
    }
    else
    {
        _appDelegate = (ForgetmenotsAppDelegate*)[[UIApplication sharedApplication] delegate];
    }
    return _appDelegate;
}

-(NSMutableArray *)selectedFlowers
{
    if (_selectedFlowers)
    {
        return _selectedFlowers;
    }
    else
    {
        _selectedFlowers  = [[NSMutableArray alloc] init];
    }
    return _selectedFlowers;
}

-(NSArray *)flowers
{
    if (_flowers) {
        return _flowers;
    }
    else
    {
        _flowers = [Flower flowersInManagedContext:self.appDelegate.managedObjectContext];
    }
    return _flowers;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.flowers count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FmnFlowerCVCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Flower Cell" forIndexPath:indexPath];
    
    Flower *flower = [self.flowers objectAtIndex:indexPath.row];
    cell.flowerView.flower = flower;
    if ([self.selectedFlowers containsObject:flower])
    {
        cell.selected = YES;
        [self.collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:NO];
        cell.flowerView.selected = YES;
    }
    else
    {
        cell.flowerView.selected = NO;
    }
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    CGFloat width = [UIScreen mainScreen].bounds.size.width;
//    return CGSizeMake(width / 3.6, width / 3.6);
    return CGSizeMake(96, 116);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FmnFlowerCVCell* cell = (FmnFlowerCVCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.flowerView.selected = cell.selected;
    
    Flower *flower = [self.flowers objectAtIndex:indexPath.row];
    [self.selectedFlowers addObject:flower];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FmnFlowerCVCell* cell = (FmnFlowerCVCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.flowerView.selected = cell.selected;
    
    Flower *flower = [self.flowers objectAtIndex:indexPath.row];
    [self.selectedFlowers removeObject:flower];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.allowsMultipleSelection = YES;
    
    self.collectionView.backgroundColor = [UIColor clearColor];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.delegate setSelectedFlowers:self selectedFlowers:self.selectedFlowers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
