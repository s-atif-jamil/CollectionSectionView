//
//  CustomLayout.h
//  TestCollection
//
//  Created by tenpearls on 8/26/14.
//  Copyright (c) 2014 tenpearls. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionBackgroundLayout : UICollectionViewFlowLayout

@property (assign, nonatomic) BOOL alternateBackgrounds;
@property (strong, nonatomic) NSArray *decorationViewOfKinds;

@end
