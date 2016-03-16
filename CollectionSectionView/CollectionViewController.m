//
//  CollectionViewController.m
//  CollectionSectionView
//
//  Created by Atif on 9/21/14.
//  Copyright (c) 2014 Atif. All rights reserved.
//

#import "CollectionViewController.h"
#import "SectionBackgroundLayout.h"

@interface CollectionViewController ()

@property (strong, nonatomic) NSArray *data;

@end

@implementation CollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    SectionBackgroundLayout *customFlowLayout = [[SectionBackgroundLayout alloc] init];
//    customFlowLayout.minimumInteritemSpacing = 0.f;
//    customFlowLayout.minimumLineSpacing = 0.f;
//    customFlowLayout.alternateBackgrounds = YES;
//    customFlowLayout.decorationViewOfKinds = @[@"SectionBackgroundView1", @"SectionBackgroundView2"];
//    customFlowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
//    
//    self.collectionView.collectionViewLayout = customFlowLayout;
//    self.data = @[@(20), @(2), @(10), @(31), @(1), @(5), @(25)];

    SectionBackgroundLayout *layout = (id)self.collectionViewLayout;
    layout.decorationViewOfKinds = @[@"SectionBackgroundView1", @"SectionBackgroundView2", [NSNull null]];
    layout.alternateBackgrounds = YES;
    layout.scrollDirection = (self.view.bounds.size.width < self.view.bounds.size.height ? UICollectionViewScrollDirectionVertical : UICollectionViewScrollDirectionHorizontal);
    
    self.data = @[@(40), @(2), @(10), @(31), @(1), @(5), @(25)];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    SectionBackgroundLayout *layout = (id)self.collectionViewLayout;
    layout.scrollDirection = (UIInterfaceOrientationIsPortrait(toInterfaceOrientation) ? UICollectionViewScrollDirectionVertical : UICollectionViewScrollDirectionHorizontal);
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
}


#pragma mark - UICollectionView DataSource & Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.data.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.data[section] integerValue];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithWhite:(rand()%255)/255.0 alpha:1.0];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat inset = 20;
    if (section%2 == 0)
        inset = 40;
    
    return UIEdgeInsetsMake(inset, inset, inset, inset);
}

@end
