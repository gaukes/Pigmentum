//
//  HelloWorldLayer.m
//  Pigmentum
//
//  Created by Gautham Kesineni on 7/16/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super initWithColor:ccc4(25, 25, 25, 255)]) ) {
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		
        self.isTouchEnabled = YES;
        
        //Pigmentum bar
        CCSprite *pigmentumBar = [CCSprite spriteWithFile:@"Pigmentum Bar.png"];
        pigmentumBar.position = ccp(size.width/2, size.height-[pigmentumBar boundingBox].size.height/2-20);
        pigmentumBar.color = ccc3(255, 0, 0);
        [self addChild:pigmentumBar];
        
        CCLabelTTF *pigmentumBarText = [CCLabelTTF labelWithString:@"Pigmentum" fontName:@"Futura" fontSize:24];
        pigmentumBarText.position = pigmentumBar.position;
        pigmentumBarText.color = ccc3(0,0,0);
        [self addChild:pigmentumBarText];
        
        CCSprite *pigmentumBarBack = [CCSprite spriteWithFile:@"Back Button.png"];
        pigmentumBarBack.position = ccp([pigmentumBarBack boundingBox].size.width/2, pigmentumBar.position.y);
        pigmentumBarBack.color = ccc3(255, 0, 0);
        [self addChild:pigmentumBarBack];
        
        CCSprite *pigmentumBarMenu = [CCSprite spriteWithFile:@"Menu Button.png"];
        pigmentumBarMenu.position = ccp(size.width-[pigmentumBarMenu boundingBox].size.width/2, pigmentumBar.position.y);
        pigmentumBarMenu.color = ccc3(255, 0, 0);
        [self addChild:pigmentumBarMenu];
        
        //End turn bar
        CCSprite *endTurnBar = [CCSprite spriteWithFile:@"End Turn Bar.png"];
        endTurnBar.position = ccp(size.width/2, [endTurnBar boundingBox].size.height/2 + 50);
        endTurnBar.color = ccc3(255, 0, 0);
        [self addChild:endTurnBar];
        
        CCLabelTTF *endTurnText = [CCLabelTTF labelWithString:@"END TURN" fontName:@"Futura" fontSize:24];
        endTurnText.position = endTurnBar.position;
        endTurnText.color = ccc3(0,0,0);
        [self addChild:endTurnText];

        //Pigment board
        CCSprite *pigmentBoardFront = [CCSprite spriteWithFile:@"Pigment Board Front.png"];
        pigmentBoardFront.position = ccp(size.width/2, endTurnBar.position.y+[endTurnBar boundingBox].size.height/2+[pigmentBoardFront boundingBox].size.height/2);
        pigmentBoardFront.color = ccc3(255, 0, 0);
        [self addChild:pigmentBoardFront];
        
        megaBoxArray = [NSMutableArray array];
        bool darkerColor = false;
        for(int a=0; a<3; a++)
        {
            NSMutableArray *megaRowArray = [NSMutableArray array];
            for(int b=0; b<3; b++)
            {
                NSMutableArray *miniBoxArray = [NSMutableArray array];
                for(int c=0; c<3; c++)
                {
                    NSMutableArray *miniRowArray = [NSMutableArray array];
                    for (int d=0; d<3; d++)
                    {
                        CCSprite *box = [Box node];
                        float side = [box boundingBox].size.height;
                        float barWidth = ([pigmentBoardFront boundingBox].size.width - 9*side)/2.0;
                        float moreAdjustment = 0;
                        box.position = ccp(side/2.0+ moreAdjustment+ b*(side*3 + barWidth) + d*(side), - ([pigmentumBar boundingBox].size.height/2 - pigmentumBar.position.y + 84.5 + side/2.0+ a*(side*3 + barWidth) + c*side +barWidth +moreAdjustment));
                        if(darkerColor == true)
                            box.color = ccc3(25, 25, 25);
                        if(darkerColor == false)
                            box.color = ccc3(51, 51, 51);
                        [miniRowArray addObject:box];
                        [self addChild:box];
                        darkerColor = !darkerColor;
                    }
                    [miniBoxArray addObject:miniRowArray];
                }
                [megaRowArray addObject:miniBoxArray];
            }
            [megaBoxArray addObject:megaRowArray];
        }
    
        
        
    
	}
	return self;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:[touch view]];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    
    for (NSArray *megaRowArray in megaBoxArray)
    {
        for(NSArray *miniBoxArray in megaRowArray)
        {
            for(NSArray *miniRowArray in miniBoxArray)
            {
                for(CCSprite *box in miniRowArray)
                {
                    if(CGRectContainsPoint([box boundingBox], touchLocation))
                    {
                        
                    }
                }
            }
        }
    }
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
