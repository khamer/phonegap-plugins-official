//
//  EmailComposer.m
// 
//
//  Created by Jesse MacFadyen on 10-04-05.
//  Copyright 2010 Nitobi. All rights reserved.
//

#import "EmailComposer.h"



@implementation EmailComposer

- (void) showEmailComposer:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{	
	// NSUInteger argc = [arguments count];
	
	NSString* toRecipientsString = [options valueForKey:@"toRecipients"];
	NSString* ccRecipientsString = [options valueForKey:@"ccRecipients"];
	NSString* bccRecipientsString = [options valueForKey:@"bccRecipients"];
	NSString* subject = [options valueForKey:@"subject"];
	NSString* body = [options valueForKey:@"body"];
	NSString* isHTML = [options valueForKey:@"bIsHTML"];
	NSString* mimeType = @"image/jpeg";
	NSString* fileName = @"petwatch.jpeg";
    
	NSString* encodedData = [options valueForKey:@"attachment"];
	NSData* attachment = [Base64 decode:encodedData];
	
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
	// Set subject
	if(subject != nil)
		[picker setSubject:subject];
	// set body
	if(body != nil)
	{
		if(isHTML != nil && [isHTML boolValue])
		{
			[picker setMessageBody:body isHTML:YES];
		}
		else
		{
			[picker setMessageBody:body isHTML:NO];
		}
		
		if(attachment != nil)
		{
			[picker addAttachmentData:attachment mimeType:mimeType fileName:fileName];
		}
	}
	
	// Set recipients
	if(toRecipientsString != nil)
	{
		[picker setToRecipients:[ toRecipientsString componentsSeparatedByString:@","]];
	}
	if(ccRecipientsString != nil)
	{
		[picker setCcRecipients:[ ccRecipientsString componentsSeparatedByString:@","]]; 
	}
	if(bccRecipientsString != nil)
	{
		[picker setBccRecipients:[ bccRecipientsString componentsSeparatedByString:@","]];
	}
	
    
    [[ super appViewController ] presentModalViewController:picker animated:YES];
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{   
    // Notifies users about errors associated with the interface
	int webviewResult = 0;
	
    switch (result)
    {
        case MFMailComposeResultCancelled:
			webviewResult = 0;
            break;
        case MFMailComposeResultSaved:
			webviewResult = 1;
            break;
        case MFMailComposeResultSent:
			webviewResult =2;
            break;
        case MFMailComposeResultFailed:
            webviewResult = 3;
            break;
        default:
			webviewResult = 4;
            break;
    }
	
    [[ super appViewController ] dismissModalViewControllerAnimated:YES];
	
	NSString* jsString = [[NSString alloc] initWithFormat:@"window.plugins.emailComposer._didFinishWithResult(%d);",webviewResult];
	[self writeJavascript:jsString];
}

@end
