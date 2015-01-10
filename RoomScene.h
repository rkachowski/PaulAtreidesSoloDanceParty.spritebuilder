#import <Foundation/Foundation.h>


@interface RoomScene : CCNode

@property(nonatomic) CCSprite *background;
@property(nonatomic) CCSprite *objects;

@property(nonatomic) CCSprite *player;
@property (nonatomic) CCSprite *roomObjects;

@property(nonatomic) CCSprite *foreground;
@property(nonatomic) CCSprite *hud;

@property (nonatomic) CCNodeGradient *timer;
@property (nonatomic) CCNodeGradient *cool;
@end