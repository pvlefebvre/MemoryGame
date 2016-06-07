//
//  Card.h
//  MemoryGame
//
//  Created by Paul Lefebvre on 6/6/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Card;

@protocol CardDelegate <NSObject>

-(void)didTapCard:(Card *)card;

@end


@interface Card : UIImageView
@property BOOL isFlipped;
@property UIImage *cardImage;
@property (nonatomic,weak) id<CardDelegate> delegate;
@end
