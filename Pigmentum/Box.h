//
//  Box.h
//  Pigmentum
//
//  Created by Gautham Kesineni on 7/20/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Box : CCSprite {
    
    int owner; //0 is unselected, 1 is player, 2 is enemy
    
}

-(int)owner;
-(void)setOwner:(int)temp;

@end
