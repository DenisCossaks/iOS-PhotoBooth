//
//  ProgressView.m
//  ChrismasBubble
//
//  Created by Kim SongIl on 11/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ProgressView.h"

@implementation ProgressView
@synthesize progress;

- (id) initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
     
        progressBG = [[UIImageView alloc] initWithFrame:self.bounds];
        progressBG.image = [UIImage imageNamed:@"bgProbress"];
        [self addSubview:progressBG];
        [progressBG release];
        
        progressbar = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, frame.size.width - 20, frame.size.height - 20)];
        progressbar.image = [[UIImage imageNamed:@"barProgress"] stretchableImageWithLeftCapWidth:24 topCapHeight:15];
        [self addSubview:progressbar];
        [progressbar release];
    }
    
    return self;
}

- (void)setProgress:(float)_progress {
    
    progress = _progress;
    progressbar.frame = CGRectMake(10, 10, (self.bounds.size.width - 20) * progress, self.bounds.size.height - 20);
}


@end
