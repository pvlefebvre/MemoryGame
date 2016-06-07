//
//  ViewController.m
//  MemoryGame
//
//  Created by Paul Lefebvre on 6/6/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

#import "ViewController.h"
#import "Card.h"

@interface ViewController () <CardDelegate>
@property (nonatomic,strong) IBOutletCollection(Card) NSArray *cards;
@property NSArray *cardValueArray;
@property NSArray *cardFaceArray;
@property Card *card1;
@property Card *card2;
@property BOOL isSecondCard;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cardFaceArray = [NSArray arrayWithObjects:@"diamonds",@"clubs",@"spades",@"hearts", nil];
    self.cardValueArray = [NSArray arrayWithObjects:@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"jack",@"queen",@"king",@"ace", nil];
    
    [self shuffleCards];
}

- (void)shuffleCards{
    NSMutableSet *pairs = [NSMutableSet new];
    while (pairs.count != 8) {
        NSInteger random1 = arc4random_uniform((u_int32_t)[self.cardFaceArray count]);
        NSInteger random2 = arc4random_uniform((u_int32_t)[self.cardValueArray count]);
        [pairs addObject:[NSString stringWithFormat:@"%@_of_%@",self.cardValueArray[random2],self.cardFaceArray[random1]]];
    }
    
    NSMutableArray *randomLocations = [NSMutableArray new];
    
    for(NSMutableSet *pair in pairs){
        [randomLocations addObject:pair];
        [randomLocations addObject:pair];
    }

    for (NSUInteger i = randomLocations.count; i > 1; i--){
        [randomLocations exchangeObjectAtIndex:i - 1 withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
    }
    
    for(int i = 0; i < 16; i++){
        [self.cards[i] setCardName:randomLocations[i]];
        [self.cards[i] setImage:[UIImage imageNamed:@"back"]];
    }
    for (Card *card in self.cards) {
        card.isLocked = NO;
        card.isFlipped = NO;
        card.delegate = self;
    }
    
}

-(void)didTapCard:(Card *)card{
    if (!card.isFlipped && !card.isLocked){
        [self showCard:card];
    }
}

- (void)showCard:(Card *)card{
    [UIView animateWithDuration:0.8 animations:^{
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:card cache:YES];
        [card setImage:card.cardImage];
    } completion:^(BOOL finished) {
        if(finished == YES){
            if(!self.isSecondCard){
                self.card1 = card;
                self.isSecondCard = YES;
            }else{
                self.card2 = card;
                if ([self.card1.cardName isEqualToString:self.card2.cardName]) {
                    self.card1.isLocked = YES;
                    self.card2.isLocked = YES;
                    if([self didCompleteGame]){
                        [self newGame];
                    }
                }else{
                    [self hideCard:self.card1];
                    [self hideCard:self.card2];
                }
                self.isSecondCard = NO;
            }
        }
    }];
    
    card.isFlipped = !card.isFlipped;
}

- (void)hideCard:(Card *)card{
    [UIView animateWithDuration:0.8 animations:^{
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:card cache:YES];
        [card setImage:[UIImage imageNamed:@"back"]];
    } completion:^(BOOL finished) {
        if(finished == YES){
            NSLog(@"DONE");
        }
    }];
    
    card.isFlipped = !card.isFlipped;
}

- (BOOL)didCompleteGame{
    for (Card *card in self.cards) {
        if(!card.isLocked){
            return NO;
        }
    }
    return YES;
}

-(void)newGame{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"New game?" message:@"Congratulations! Would you like to start a new game?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"YES!" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self shuffleCards];
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
}
@end
