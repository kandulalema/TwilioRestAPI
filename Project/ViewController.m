//
//  ViewController.m
//  Project
//
//  Created by Kolla, Venubabu (UMKC-Student) on 6/17/15.
//  Copyright (c) 2015 Kolla, Venubabu (UMKC-Student). All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPRequestOperationManager.h"

#define BASE_URL "https://api.twilio.com/2010-04-01/Accounts/AC13834e7b7d18ffeb52f674846b2017c7/SMS/Messages"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *status;

@property (strong, nonatomic) IBOutlet UITextView *messageBody;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendMessage:(id)sender {
    
    NSLog(@" Sending Request....");
    
    NSString *twilioSID = @"AC13834e7b7d18ffeb52f674846b2017c7";
    NSString *twilioAuthKey = @"ce7ea32845386f7aa9efbe73e8e1be43";
    NSString *fromNumber = @"+19784155546";
    NSString *ToNumber = self.phoneNumber.text;
    NSString *bodyMessage = self.messageBody.text;
    
  
   // NSString *messageBody = self.messageBody.text;
    
    //Building Http request to send the data
    
    NSString *urlString = [NSString stringWithFormat:@"https://%@:%@@api.twilio.com/2010-04-01/Accounts/%@/SMS/Messages", twilioSID, twilioAuthKey, twilioSID];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    
    //Set up the body the request
    
    NSString *bodyString = [NSString stringWithFormat:@"From=%@&To=%@&Body=%@", fromNumber,ToNumber,bodyMessage];
    
    NSData *data =[bodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:data];
    
    NSError *error;
    
    NSURLResponse *response;
    
    NSData *receivedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    //Handle the received data
    
    if(error){
        NSLog(@"Error:%@", error);
    }else{
        NSString *receivedString = [[NSString alloc]initWithData:receivedData encoding:NSUTF8StringEncoding];
        NSLog(@"Request sent.%@",receivedString);
    }
    
}
@end
