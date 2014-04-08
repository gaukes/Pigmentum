//
//  Box.m
//  Pigmentum
//
//  Created by Gautham Kesineni on 7/20/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Box.h"


@implementation Box

-(id) init
{
    if(self = [super initWithFile:@"Basic Box.png"])
    {
        owner = 0;
    }
    return self;
}

-(int)owner
{
    return owner;
}

-(void)setOwner:(int)temp
{
    owner = temp;
}


@end
