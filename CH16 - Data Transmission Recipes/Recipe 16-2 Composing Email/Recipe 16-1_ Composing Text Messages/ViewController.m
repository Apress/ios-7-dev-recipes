//
//  ViewController.m
//  Recipe 16-2 Composing Email
//
//  Created by joseph hoffman on 9/5/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.inputTextView.layer.cornerRadius = 15.0;
    self.imageView.layer.cornerRadius = 15.0;
    self.inputTextView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textMessagingAvailabilityChanged:)
                                                 name:MFMessageComposeViewControllerTextMessageAvailabilityDidChangeNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - actions

- (IBAction)textMessage:(id)sender
{
    if ([MFMessageComposeViewController canSendText])
    {
        MFMessageComposeViewController *messageVC =
        [[MFMessageComposeViewController alloc] init];
        messageVC.messageComposeDelegate = self;
        messageVC.recipients = @[@"3015555309"];
        messageVC.body = self.inputTextView.text;
        [self presentViewController:messageVC animated:YES completion:nil];
    }
    else
    {
        NSLog(@"Text Messaging Unavailable");
    }
}

- (IBAction)mailMessage:(id)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailVC =
        [[MFMailComposeViewController alloc] init];
        [mailVC setSubject:@"Send It Out"];
        [mailVC setToRecipients:@[@"test@example.com"]];
        [mailVC setMessageBody:self.inputTextView.text isHTML:NO];
        mailVC.mailComposeDelegate = self;
        
        if (self.imageView.image != nil)
        {
            NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 1.0);
            [mailVC addAttachmentData:imageData mimeType:@"image/jpeg"
                             fileName:@"SelectedImage"];
        }
        
        [self presentViewController:mailVC animated:YES completion:nil];
    }
    else
    {
        NSLog(@"E-mailing Unavailable");
    }
}

- (IBAction)getImage:(id)sender
{
    self.picker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController
         isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.picker.delegate = self;
        
        [self presentViewController:self.picker animated:YES completion:nil];
    }
}

#pragma mark - helper methods

-(void)textMessagingAvailabilityChanged:(id)sender
{
    if ([MFMessageComposeViewController canSendText])
    {
        NSLog(@"Text Messaging Available");
    }
    else
    {
        NSLog(@"Text Messaging Unavailable");
    }
}


#pragma mark - Text Message Delegate methods

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    if (result == MessageComposeResultSent)
    {
        self.inputTextView.text = @"Message sent.";
    }
    else if (result == MessageComposeResultFailed)
    {
        NSLog(@"Failed to send message!");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Mail Message Delegate Methods

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    if (result == MFMailComposeResultSent)
    {
        self.inputTextView.text = @"Mail sent.";
        self.imageView.image = nil;
    }
    else if (result == MFMailComposeResultCancelled)
        NSLog(@"Mail Cancelled");
    else if (result == MFMailComposeResultFailed)
        NSLog(@"Error, Mail Send Failed");
    else if (result == MFMailComposeResultSaved)
        NSLog(@"Mail Saved");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Image Picker Delegates

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.imageView.image = [info valueForKey:@"UIImagePickerControllerOriginalImage"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.picker dismissViewControllerAnimated:YES completion:nil];
}


@end
