#import "WinScene.h"
#import "CCNode+UIFlow.h"
#import "GameConfig.h"


@implementation WinScene
{

}

- (void)onEnter
{
    [super onEnter];

    float score = 10 * [[[GameConfig sharedConfig] getValueForKey:@"funk"] floatValue];
    int intScore = (int)score;

    _winText.string = [NSString stringWithFormat:@"you cut %d sweet moves!", intScore];
}


- (void) onButton
{
    [self sendUIMessage:@"again"];
}
@end