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
@property NSMutableSet *pairTest;
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
        UIImage *image = [UIImage imageNamed:randomLocations[i]];
        [self.cards[i] setCardImage:image];
        [self.cards[i] setImage:[UIImage imageNamed:@"back"]];
    }
    for (Card *card in self.cards) {
        card.delegate = self;
    }
    
}

-(void)didTapCard:(Card *)card{
    if (!card.isFlipped){
        [UIView animateWithDuration:0.8 animations:^{
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:card cache:YES];
            [card setImage:card.cardImage];
        }];
        if ([self.pairTest count] == 0) {
            [self.pairTest addObject:card];
        } else if ([self.pairTest count] == 1) {
            [self.pairTest addObject:card];
        }else{
            
        }
        
    }else if (card.isFlipped) {
        [UIView transitionWithView:card
                          duration:0.8
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations: ^{
                            [card setImage:[UIImage imageNamed:@"back"]];
                        }
                        completion:NULL];
    }
    
    card.isFlipped = !card.isFlipped;
}
@end
