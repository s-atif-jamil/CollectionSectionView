//
//  CustomLayout.m
//  TestCollection
//
//  Created by Atif on 9/21/14.
//  Copyright (c) 2014 Atif. All rights reserved.
//

#import "SectionBackgroundLayout.h"

@interface SectionBackgroundLayout ()

@property (strong, nonatomic) NSMutableArray *itemAttributes;

@end

@implementation SectionBackgroundLayout


- (void)prepareLayout
{
    [super prepareLayout];
    self.itemAttributes = [NSMutableArray new];
    
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
        
        CGRect frame = CGRectUnion(firstItem.frame, lastItem.frame);
        frame.origin.x -= self.sectionInset.left;
        frame.origin.y -= self.sectionInset.top;
        
        if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal)
        {
            frame.size.width += self.sectionInset.left + self.sectionInset.right;
            frame.size.height = self.collectionView.frame.size.height;
        }
        else
        {
            frame.size.width = self.collectionView.frame.size.width;
            frame.size.height += self.sectionInset.top + self.sectionInset.bottom;
        }
        
        
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:decorationViewOfKind withIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
        attributes.zIndex = -1;
        attributes.frame = frame;
        [self.itemAttributes addObject:attributes];
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

@end
