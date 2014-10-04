Collection Section View
=======================
SectionBackgroundLayout can provide background decoration view for each section.

How To
------

1. Add SectionBackgroundLayout.h & SectionBackgroundLayout.m in project
2. In Storyboard or Xib, under UICollectionView change UICollectionViewFlowLayout to SectionBackgroundLayout
3. Add xib in project like "SectionBackgroundView1.xib" which is UICollectionReusableView to use as decoration view
4. The identifier of reusable view (in Attribute Inspector) will be same name as file name like "SectionBackgroundView1". And change the background color as you want.
5. Look bellow code for how can it be use

```objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];
    SectionBackgroundLayout *layout = (id)self.collectionView.collectionViewLayout;
    layout.decorationViewOfKinds = @[@"SectionBackgroundView1", @"SectionBackgroundView2", [NSNull null]];
    ...
}
```

Note
----
* if layout.alternateBackgrounds = YES and sections are more than background views then new section reuse the 1st background view and next section will 2nd one and so on. Like alternate background colors.
* if array contains [NSNull null] element then that section will not create any background just reflect the UICollectionView background

