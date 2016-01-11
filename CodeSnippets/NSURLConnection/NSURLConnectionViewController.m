//
//  NSURLConnectViewController.m
//  CodeSnippets
//
//  Created by GeekRRK on 1/11/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "NSURLConnectionViewController.h"

@interface NSURLConnectionViewController ()

@property (strong, nonatomic) NSURLConnection *connection;
@property (strong, nonatomic) NSMutableData *receivedData;

@end

@implementation NSURLConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self syncGetWithUrl:@"http://www.baidu.com/s?wd=test"];
}

- (void)syncGetWithUrl:(NSString *)url {
    NSURL *nsurl = [NSURL URLWithString:url];
    NSURLRequest *request =
    [[NSURLRequest alloc]initWithURL:nsurl
                         cachePolicy:NSURLRequestUseProtocolCachePolicy
                     timeoutInterval:30];
    
    NSData *received = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil
                                                         error:nil];
    NSString *str = [[NSString alloc] initWithData:received
                                          encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    
    if(received != nil){
        NSDictionary *dict =
        [NSJSONSerialization JSONObjectWithData:received
                                        options:NSJSONReadingAllowFragments
                                          error:nil];
        NSLog(@"%@", dict);
    }
}

- (void)syncPostWithUrl:(NSString *)url params:(NSString *)pms{
    NSURL *nsurl = [NSURL URLWithString:url];
    NSMutableURLRequest *request =
    [[NSMutableURLRequest alloc] initWithURL:nsurl
                                 cachePolicy:NSURLRequestUseProtocolCachePolicy
                             timeoutInterval:30];
    
    [request setHTTPMethod:@"POST"];
    
    NSData *data = [pms dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:data];

    NSData *received = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil
                                                         error:nil];
    NSString *str = [[NSString alloc] initWithData:received
                                           encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    
    if(received != nil){
        NSDictionary *dict =
        [NSJSONSerialization JSONObjectWithData:received
                                        options:NSJSONReadingAllowFragments
                                          error:nil];
        NSLog(@"%@", dict);
    }
}

- (void)asyncGetWithUrl:(NSString *)url {
    NSURL *nsurl = [NSURL URLWithString: url];
    NSURLRequest *request =
    [[NSURLRequest alloc] initWithURL:nsurl
                          cachePolicy:NSURLRequestUseProtocolCachePolicy
                      timeoutInterval:30];
    
    self.connection = [[NSURLConnection alloc] initWithRequest:request
                                                      delegate:self];
}

- (void)asyncPostWithUrl:(NSString *)url params:(NSString *)pms {
    NSURL *nsurl = [NSURL URLWithString:url];
    NSMutableURLRequest *request =
    [[NSMutableURLRequest alloc] initWithURL:nsurl
                                 cachePolicy:NSURLRequestUseProtocolCachePolicy
                             timeoutInterval:30];
    
    [request setHTTPMethod:@"POST"];
    NSData *data = [pms dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    self.connection =
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    //Alertnatively, use the following code to omit the NSURLConnectionDelegate
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:queue
//                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//                               if (data) {
//                                   NSDictionary *dict =
//                                   [NSJSONSerialization JSONObjectWithData:data
//                                                                   options:NSJSONReadingMutableLeaves
//                                                                     error:nil];
//                                   NSLog(@"%@",dict);
//                               }
//    }];
    
    //If the http server supports json
//    NSDictionary *json = @{
//                           @"username" : @"geekrrk",
//                           @"password" : @"123"
//                           };
//
//    NSData *jsonData =
//    [NSJSONSerialization dataWithJSONObject:json
//                                    options:NSJSONWritingPrettyPrinted
//                                      error:nil];
//    request.HTTPBody = jsonData;
}

#pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response
{
    
    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
    NSLog(@"%@",[res allHeaderFields]);
    self.receivedData = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *received = [[NSString alloc] initWithData:self.receivedData
                                                 encoding:NSUTF8StringEncoding];
    NSLog(@"%@",received);
    
    if(received != nil){
        NSDictionary *dict =
        [NSJSONSerialization JSONObjectWithData:self.receivedData
                                        options:NSJSONReadingAllowFragments
                                          error:nil];
        NSLog(@"%@", dict);
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}

@end
