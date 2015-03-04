//
//  ProgressView.h
//  ChrismasBubble
//
//  Created by Kim SongIl on 11/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProgressView : UIImageView {
    
    UIImageView* progressbar;
    UIImageView* progressBG;
    float progress;
}

@property (nonatomic, assign) float progress;

@end
