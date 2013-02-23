//
//  MMPhotoViewController.m
//  FlickerAPI
//
//  Created by James Donner on 2/21/13.
//  Copyright (c) 2013 jdsv650. All rights reserved.
//

#import "MMPhotoViewController.h"

@interface MMPhotoViewController ()
{
    __weak IBOutlet UIImageView *detailImageView;
}

@end

@implementation MMPhotoViewController

@synthesize pictDict;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSString *farmString = [NSString stringWithFormat:@"%@", [pictDict objectForKey:@"farm"]];
    NSString *serverString = [NSString stringWithFormat:@"%@", [pictDict objectForKey:@"server"]];
    NSString *idString = [NSString stringWithFormat:@"%@", [pictDict objectForKey:@"id"]];
    NSString *secretString = [NSString stringWithFormat:@"%@", [pictDict objectForKey:@"secret"]];
    
    NSString *awesomeString = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_n.jpg",farmString, serverString, idString, secretString];
    
    NSURL *flickPictureURL = [NSURL URLWithString:awesomeString];
    NSData *picData = [NSData dataWithContentsOfURL:flickPictureURL];
    
    UIImage *flickPicImage = [UIImage imageWithData:picData];
  
    detailImageView.image = flickPicImage;
    
}

@end
