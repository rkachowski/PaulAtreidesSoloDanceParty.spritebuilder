#import <Foundation/Foundation.h>


@interface DanceScene : CCNode

@property (nonatomic) CCSprite *background;
@property (nonatomic) CCSprite *foreground;
@property (nonatomic) CCSprite *objects;
@property (nonatomic) CCSprite *hud;

@property (nonatomic) CCButton *danceButton;

@property (nonatomic) CCSprite *player;

@property (nonatomic) CCSprite *circleSprite;
@property (nonatomic) CCNodeGradient *cool;

@end