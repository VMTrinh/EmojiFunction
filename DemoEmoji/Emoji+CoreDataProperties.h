//
//  Emoji+CoreDataProperties.h
//  DemoEmoji
//
//  Created by Mai Trinh on 11/6/15.
//  Copyright © 2015 EBIZWORLD. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Emoji.h"

NS_ASSUME_NONNULL_BEGIN

@interface Emoji (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *category;
@property (nullable, nonatomic, retain) NSString *name_emoji;

@end

NS_ASSUME_NONNULL_END
