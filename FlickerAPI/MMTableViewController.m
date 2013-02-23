//
//  MMTableViewController.m
//  FlickerAPI
//
//  Created by James Donner on 2/20/13.
//  Copyright (c) 2013 jdsv650. All rights reserved.
//

#import "MMTableViewController.h"
#import "MMPhotoViewController.h"

@interface MMTableViewController ()
{
    NSMutableArray *photosArray;
    NSDictionary *resultsAsDictionary;
    NSDictionary *pictDict;
    
    __weak IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UITableView *FlickerTableView;
}

@end


@implementation MMTableViewController
@synthesize searchTerm;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [activityIndicator startAnimating];
    
    // path to API as string
    NSString *flickerAPIString = @"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=9752319060f3fd77e514166ab2771c72&tags=cat&format=json&nojsoncallback=1";
    
    NSString *flickerAPIStringWithSearchTerm = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=9752319060f3fd77e514166ab2771c72&tags=%@&format=json&nojsoncallback=1", searchTerm];
    
    // convert string to an actual URL
    NSURL *flickerURL = [NSURL URLWithString:flickerAPIStringWithSearchTerm];
    
    // Build a URL request
    NSMutableURLRequest *flickerURLRequest = [NSMutableURLRequest requestWithURL:flickerURL];
    flickerURLRequest.HTTPMethod = @"GET";
    
    [NSURLConnection sendAsynchronousRequest:flickerURLRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^ void (NSURLResponse *myResponse, NSData *myData, NSError *myError)
     {
         if(myError)
         {
             NSLog(@"%@", myError.localizedDescription);
         }
         else
         {
             NSError *jsonError;
             //convert from raw data of type NSData to
             id genericObjectThatIKnowIsDictionary = [NSJSONSerialization  JSONObjectWithData:myData
                                                                                   options:NSJSONReadingAllowFragments
                                                                                     error:&jsonError];
             
            resultsAsDictionary = (NSDictionary *) genericObjectThatIKnowIsDictionary;
        
            NSLog(@"%@", [[resultsAsDictionary valueForKey:@"photos"] valueForKey:@"photo"]);
            photosArray = [[resultsAsDictionary valueForKey:@"photos"] valueForKey:@"photo"];
             
            //reload data and stop animating
            [FlickerTableView reloadData];
            [activityIndicator stopAnimating];
             
         }
         
     } ];
}




-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
    MMPhotoViewController *pvc = [segue destinationViewController];
    pvc.pictDict = pictDict;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return photosArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     
    UITableViewCell *myCustomCell = [FlickerTableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    
    NSString *picName = [[photosArray objectAtIndex:indexPath.row] valueForKey:@"title"];
    UIView *viewThatIsReallyALabel = [myCustomCell viewWithTag:100];
    UILabel *picNameLabel = (UILabel *) viewThatIsReallyALabel;
    picNameLabel.text = picName;

    
    NSString *farmString = [[photosArray objectAtIndex:indexPath.row] valueForKey:@"farm"];
    NSString *serverString = [[photosArray objectAtIndex:indexPath.row] valueForKey:@"server"];
    NSString *idString = [[photosArray objectAtIndex:indexPath.row] valueForKey:@"id"];
    NSString *secretString = [[photosArray objectAtIndex:indexPath.row] valueForKey:@"secret"];
    
   NSString *completedString = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_m.jpg" ,farmString,serverString, idString, secretString];
    
    NSURL *flickPictureURL = [NSURL URLWithString:completedString];
    NSData *picData = [NSData dataWithContentsOfURL:flickPictureURL];
    
    UIImage *flickPicImage = [UIImage imageWithData:picData];
    UIView *viewThatIsAnImage = [myCustomCell viewWithTag:101];
    UIImageView *picImageView = (UIImageView *) viewThatIsAnImage;
    picImageView.image = flickPicImage;
    
    return myCustomCell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    pictDict = [photosArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"picSegueID" sender:self];
    
}

@end
