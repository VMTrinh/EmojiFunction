//
//  ViewController.h
//  DemoEmoji
//
//  Created by Mai Trinh on 10/12/15.
//  Copyright © 2015 EBIZWORLD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData+MagicalRecord.h>

@interface ViewController : UIViewController
{
    BOOL pageControlBeingUsed;
    int currentCollectionView;
}
@property (weak, nonatomic) IBOutlet UIView *viewDetail;

@end

