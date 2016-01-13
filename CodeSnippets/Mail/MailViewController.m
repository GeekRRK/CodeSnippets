//
//  MainViewController.m
//  CodeSnippets
//
//  Created by GeekRRK on 1/11/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "MailViewController.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface MailViewController () <MFMailComposeViewControllerDelegate>

@end

@implementation MailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self sendMailInApp];
}

-(void)launchMailApp
{
    NSMutableString *mailUrl = [[NSMutableString alloc] init];
    NSArray *toRecipients = [NSArray arrayWithObject: @"669672615@qq.com"];
    [mailUrl appendFormat:@"mailto:%@",
     [toRecipients componentsJoinedByString:@","]];
    NSArray *ccRecipients =
    [NSArray arrayWithObjects:@"fanfangxiangc@gmail.com", nil];
    [mailUrl appendFormat:@"?cc=%@",
     [ccRecipients componentsJoinedByString:@","]];
    NSArray *bccRecipients =
    [NSArray arrayWithObjects:@"1719366416@qq.com", nil];
    [mailUrl appendFormat:@"&bcc=%@",
     [bccRecipients componentsJoinedByString:@","]];
    [mailUrl appendString:@"&subject=My Email"];
    [mailUrl appendString:@"&body=<b>Test Email</b> body!"];
    NSString* email =
    [mailUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];
}

- (void)sendMailInApp
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (!mailClass) {
        NSLog(@"The current system version doesn't support send email inner,\
              use mailto instead.");
        return;
    }
    if (![mailClass canSendMail]) {
        NSLog(@"User didn't setup the email account.");
        return;
    }
    
    [self displayMailPicker];
}

- (void)displayMailPicker
{
    MFMailComposeViewController *mailPicker =
    [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    
    [mailPicker setSubject: @"Email Subject"];
    NSArray *toRecipients = [NSArray arrayWithObject: @"669672615@qq.com"];
    [mailPicker setToRecipients: toRecipients];
    NSArray *ccRecipients =
    [NSArray arrayWithObjects:@"fanfangxiangc@gmail.com", nil];
    [mailPicker setCcRecipients:ccRecipients];
    NSArray *bccRecipients =
    [NSArray arrayWithObjects:@"1719366416@qq.com", nil];
    [mailPicker setBccRecipients:bccRecipients];
    
    UIImage *addPic = [UIImage imageNamed: @"addPic.jpg"];
    NSData *imageData = UIImageJPEGRepresentation(addPic, 1);
    [mailPicker addAttachmentData: imageData
                         mimeType: @"image/jpeg"
                         fileName: @"addPic.jpg"];
    
    NSString *file =
    [[NSBundle mainBundle] pathForResource:@"serverStartup" ofType:@".pdf"];
    NSData *pdf = [NSData dataWithContentsOfFile:file];
    [mailPicker addAttachmentData: pdf
                         mimeType: @""
                         fileName: @"serverStartup"];
    
    NSString *emailBody = @"<font color='red'>Email</font> Body";
    [mailPicker setMessageBody:emailBody isHTML:YES];
    
    [self presentViewController:mailPicker animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSString *msg;
    switch (result) {
        case MFMailComposeResultCancelled:
            msg = @"Cancel to edit email.";
            break;
        case MFMailComposeResultSaved:
            msg = @"Save email successfully.";
            break;
        case MFMailComposeResultSent:
            msg = @"Sending email";
            break;
        case MFMailComposeResultFailed:
            msg = @"Fail to save or send email.";
            break;
        default:
            msg = @"";
            break;
    }
    
    NSLog(@"%@", msg);
}

@end
