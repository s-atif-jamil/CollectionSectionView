//
//  CustomLayout.m
//  TestCollection
//
//  Created by Atif on 9/21/14.
//  Copyright (c) 2014 Atif. All rights reserved.
//

#import "SectionBackgroundLayout.h"

@interface SectionBackgroundLayout ()

// Len: use NSMutableArray will result in crash when reload section
@property (strong, nonatomic) NSMutableDictionary *itemAttributes;

@end

@implementation SectionBackgroundLayout


- (void)prepareLayout
{
    [super prepareLayout];
    self.itemAttributes = [NSMutableDictionary new];
    id<UICollectionViewDelegateFlowLayout> delegate = (id)self.collectionView.delegate;
    
    NSInteger numberOfSection = self.collectionView.numberOfSections;
    for (int section=0; section<numberOfSection; section++)
    {
        if (!self.alternateBackgrounds && section == self.decorationViewOfKinds.count)
            break;
        
        NSString *decorationViewOfKind = self.decorationViewOfKinds[section % self.decorationViewOfKinds.count];
        if ([decorationViewOfKind isKindOfClass:[NSNull class]])
            continue;
        
        NSInteger lastIndex = [self.collectionView numberOfItemsInSection:section] - 1;
        if (lastIndex < 0)
            continue;
        
        UICollectionViewLayoutAttributes *firstItem = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
        UICollectionViewLayoutAttributes *lastItem = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:lastIndex inSection:section]];

        UIEdgeInsets sectionInset = self.sectionInset;
        if ([delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)])
            sectionInset = [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
        
        CGRect frame = CGRectUnion(firstItem.frame, lastItem.frame);
        frame.origin.x -= sectionInset.left;
        frame.origin.y -= sectionInset.top;
        
        if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal)
        {
            frame.size.width += sectionInset.left + sectionInset.right;
            frame.size.height = self.collectionView.frame.size.height;
        }
        else
        {
            frame.size.width = self.collectionView.frame.size.width;
            frame.size.height += sectionInset.top + sectionInset.bottom;
        }
        
        
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:decorationViewOfKind withIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
        attributes.zIndex = -1;
        attributes.frame = frame;
        // Len: replace addObject: with setObject:forKey
        [self.itemAttributes setObject:attributes forKey:@(section)];
        [self registerNib:[UINib nibWithNibName:decorationViewOfKind bundle:[NSBundle mainBundle]] forDecorationViewOfKind:decorationViewOfKind];
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *attributes = [NSMutableArray arrayWithArray:[super layoutAttributesForElementsInRect:rect]];
    for (UICollectionViewLayoutAttributes *attribute in self.itemAttributes)
    {
        if (!CGRectIntersectsRect(rect, attribute.frame))
            continue;
        
        [attributes addObject:attribute];
    }
    
    return attributes;
}

// Len: NSMutableArray will result in array bound.
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if ([elementKind isEqualToString: self.decorationViewOfKinds[indexPath.section % self.decorationViewOfKinds.count]]) {
        return [self.itemAttributes objectForKey:@(indexPath.section)];
    }
    return [super layoutAttributesForDecorationViewOfKind:elementKind atIndexPath:indexPath];
}

@end
