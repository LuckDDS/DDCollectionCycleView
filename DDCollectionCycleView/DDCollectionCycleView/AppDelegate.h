//
//  AppDelegate.h
//  DDCollectionCycleView
//
//  Created by 董德帅 on 2020/5/20.
//  Copyright © 2020 九天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

