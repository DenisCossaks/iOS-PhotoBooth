//
//  SendingProgressController.h
//  ChrismasBubble
//
//  Created by Kim SongIl on 11/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressView.h"
#import "FBConnect.h"

@interface SendingProgressController : UIViewController <FBRequestDelegate>{
    
    ProgressView* progressView;
    NSTimer* timer;
    UIImageView* background;
    float maxValue;
}

@property (nonatomic, retain) IBOutlet UIImageView*  background;

@end
