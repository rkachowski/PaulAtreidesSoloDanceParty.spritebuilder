#import "GameOverScene.h"
#import "CCNode+UIFlow.h"


@implementation GameOverScene
{

}

-(void)onAgain
{
    [self sendUIMessage:@"again"];
}
@end