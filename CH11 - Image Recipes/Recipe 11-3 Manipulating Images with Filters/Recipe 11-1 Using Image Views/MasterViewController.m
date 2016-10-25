//
//  MasterViewController.m
//  Recipe 11-3 Manipulating Images with Filters
//
//  Created by joseph hoffman on 8/29/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "MasterViewController.h"


@interface MasterViewController () 


@end

@implementation MasterViewController

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    self.detailViewController.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSMutableArray *)filteredImages
{
    if (!_filteredImages)
    {
        _filteredImages = [[NSMutableArray alloc] initWithCapacity:3];
    }
    return _filteredImages;
}

-(void)populateImageViewWithImage:(UIImage *)image
{
    CIImage *main = [[CIImage alloc] initWithImage:image];
    
    CIFilter *hueAdjust = [CIFilter filterWithName:@"CIHueAdjust"];
    [hueAdjust setDefaults];
    [hueAdjust setValue:main forKey:@"inputImage"];
    [hueAdjust setValue:[NSNumber numberWithFloat: 3.14/2.0f]
                 forKey:@"inputAngle"];
    CIImage *outputHueAdjust = [hueAdjust valueForKey:@"outputImage"];
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage1 = [context createCGImage:outputHueAdjust
                                        fromRect:outputHueAdjust.extent];
    UIImage *outputImage1 = [UIImage imageWithCGImage:cgImage1];
    CGImageRelease(cgImage1);
    [self.filteredImages addObject:outputImage1];
    
    CIFilter *strFilter = [CIFilter filterWithName:@"CIStraightenFilter"];
    [strFilter setDefaults];
    [strFilter setValue:main forKey:@"inputImage"];
    [strFilter setValue:[NSNumber numberWithFloat:3.14f] forKey:@"inputAngle"];
    CIImage *outputStr = [strFilter valueForKey:@"outputImage"];
    CGImageRef cgImage2 = [context createCGImage:outputStr fromRect:outputStr.extent];
    UIImage *outputImage2 = [UIImage imageWithCGImage:cgImage2];
    CGImageRelease(cgImage2);
    [self.filteredImages addObject:outputImage2];
    
    CIFilter *seriesFilter = [CIFilter filterWithName:@"CIStraightenFilter"];
    [seriesFilter setDefaults];
    [seriesFilter setValue:outputHueAdjust forKey:@"inputImage"];
    [seriesFilter setValue:[NSNumber numberWithFloat:3.14/2.0f] forKey:@"inputAngle"];
    CIImage *outputSeries = [seriesFilter valueForKey:@"outputImage"];
    CGImageRef cgImage3 = [context createCGImage:outputSeries
                                        fromRect:outputSeries.extent];
    UIImage *outputImage3 = [UIImage imageWithCGImage:cgImage3];
    [self.filteredImages addObject:outputImage3];

}

-(UIImage *)aspectFillImage:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    if (image.size.height< image.size.width)
    {
        float ratio = size.height/image.size.height;
        [image drawInRect:CGRectMake(0, 0, image.size.width*ratio, size.height)];
    }
    else
    {
        float ratio = size.width/image.size.width;
        [image drawInRect:CGRectMake(0, 0, size.width, image.size.height*ratio)];
    }
    UIImage *aspectScaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return aspectScaledImage;
}



#pragma mark - Class

-(UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

-(UIImage *)aspectScaleImage:(UIImage *)image toSize:(CGSize)size
{
    if (image.size.height < image.size.width)
    {
        float ratio = size.height / image.size.height;
        CGSize newSize = CGSizeMake(image.size.width * ratio, size.height);
        UIGraphicsBeginImageContext(newSize);
        [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    }
    else {
        float ratio = size.width / image.size.width;
        CGSize newSize = CGSizeMake(size.width, image.size.height * ratio);
        UIGraphicsBeginImageContext(newSize);
        [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    }
    UIImage *aspectScaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return aspectScaledImage;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.mainImage == nil)
        return 1;
    else
        return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    if (indexPath.row == 0)
        cell.textLabel.text = NSLocalizedString(@"Selected Image", @"Detail");
    else if (indexPath.row == 1)
        cell.textLabel.text = NSLocalizedString(@"Resized Image", @"Detail");
    else if (indexPath.row == 2)
        cell.textLabel.text = NSLocalizedString(@"Scaled Image", @"Detail");
    else if (indexPath.row == 3)
    {
        CGSize thumbnailSize = CGSizeMake(120, 75);
        UIImage *displayImage = [self.filteredImages objectAtIndex:0];
        UIImage *thumbnailImage = [self aspectFillImage:displayImage
                                                                 toSize:thumbnailSize];
        cell.imageView.image = thumbnailImage;
        cell.textLabel.text = NSLocalizedString(@"Hue Adjust", @"Detail");
    }
    else if (indexPath.row == 4)
    {
        CGSize thumbnailSize = CGSizeMake(120, 75);
        UIImage *displayImage = [self.filteredImages objectAtIndex:1];
        UIImage *thumbnailImage = [self aspectFillImage:displayImage
                                                 toSize:thumbnailSize];
        cell.imageView.image = thumbnailImage;
        cell.textLabel.text = NSLocalizedString(@"Straighten Filter", @"Detail");
    }
    else if (indexPath.row == 5)
    {
        CGSize thumbnailSize = CGSizeMake(120, 75);
        UIImage *displayImage = [self.filteredImages objectAtIndex:2];
        UIImage *thumbnailImage = [self aspectFillImage:displayImage
                                                 toSize:thumbnailSize];
        cell.imageView.image = thumbnailImage;

        cell.textLabel.text = NSLocalizedString(@"Series Filter", @"Detail");
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.mainImage != nil)
    {
        UIImage *image;
        NSString *label;
        BOOL showsButtons = NO;
        if (indexPath.row == 0)
        {
            image = self.mainImage;
            label = @"Select an Image to Display";
            showsButtons = YES;
        }
        else if (indexPath.row == 1)
        {
            image = [self scaleImage:self.mainImage
                                              toSize:self.detailViewController.imageView.frame.size];
            label = @"Chosen Image Resized";
        }
        else if (indexPath.row == 2)
        {
            image = [self aspectScaleImage:self.mainImage
                                                    toSize:self.detailViewController.imageView.frame.size];
            label = @"Chosen Image Scaled";
        }
        else if (indexPath.row == 3)
        {
            image = [self.filteredImages objectAtIndex:0];
            image = [self aspectScaleImage:image toSize:self.detailViewController.imageView.frame.size];
            label = @"Hue Adjustment";
        }
        else if (indexPath.row == 4)
        {
            image = [self.filteredImages objectAtIndex:1];
            image = [self aspectScaleImage:image toSize:self.detailViewController.imageView.frame.size];
            label = @"Straightening Filter";
        }
        else if (indexPath.row == 5)
        {
            image = [self.filteredImages objectAtIndex:2];
            image = [self aspectScaleImage:image toSize:self.detailViewController.imageView.frame.size];
            label = @"Series Filter";
        }

        [self.detailViewController configureDetailsWithImage:image label:label
                                                showsButtons:showsButtons];
    }
}

#pragma mark - DetailViewControllerDelegateProtocol

- (void)detailViewController:(DetailViewController *)controller didSelectImage:(UIImage *)image
{
    self.mainImage = image;
    [self populateImageViewWithImage:image];
    [self.tableView reloadData];
}

- (void)detailViewControllerDidClearImage:(DetailViewController *)controller
{
    self.mainImage = nil;
    [self.filteredImages removeAllObjects];
    [self.tableView reloadData];
}

@end
