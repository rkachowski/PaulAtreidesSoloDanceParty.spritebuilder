#import <Foundation/Foundation.h>


@interface RoomScene : CCNode

@property(nonatomic) CCSprite *background;
@property(nonatomic) CCSprite *objects;

@property(nonatomic) CCSprite *player;
@property (nonatomic) CCSprite *roomObjects;

@property(nonatomic) CCSprite *foreground;
@property(nonatomic) CCSprite *hud;

@property (nonatomic) CCSprite *circleSprite;
@property (nonatomic) CCNodeGradient *cool;
@property(nonatomic, strong) CCProgressNode *timer;
@end