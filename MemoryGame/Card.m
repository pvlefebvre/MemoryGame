//
//  Card.m
//  MemoryGame
//
//  Created by Paul Lefebvre on 6/6/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

#import "Card.h"

@interface Card ()

@end

@implementation Card

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    self.gestureRecognizers = @[tap];
    return self;
}

- (void)setCardName:(NSString *)cardName{
    _cardName = cardName;
    self.cardImage = [UIImage imageNamed:cardName];
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer{
    [self.delegate didTapCard:self];
}

//- (void)showCard{
//    [UIView animateWithDuration:0.8 animations:^{
//        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:YES];
//        [self setImage:self.cardImage];
//    }];
//    self.isFlipped = !self.isFlipped;
//}
//
//- (void)hideCard{
//    [UIView transitionWithView:self
//                      duration:0.8
//                       options:UIViewAnimationOptionTransitionFlipFromLeft
//                    animations: ^{
//                        [self setImage:[UIImage imageNamed:@"back"]];
//                    }
//                    completion:NULL];
//    self.isFlipped = !self.isFlipped;
//}
@end
