//
//  MessageView.h
//  Litter Stopper
//
//  Created by Applr on 24/08/18.
//  Copyright © 2018 Sunfocus Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MessageRemoveDelegate <NSObject>

-(void)closeButtonPressed;

@end

@interface MessageView : UILabel

+ (void) showInView : (UIView *) view withMessage: (NSString *) message;

@property (strong, nonatomic) IBOutlet MessageView *messageHUD;

@end
