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

-(void)handleTap:(UITapGestureRecognizer *)recognizer{
    [self.delegate didTapCard:self];
}

@end
