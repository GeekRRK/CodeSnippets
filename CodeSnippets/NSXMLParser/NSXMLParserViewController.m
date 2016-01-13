//
//  NSXMLParserViewController.m
//  CodeSnippets
//
//  Created by suorui on 1/12/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "NSXMLParserViewController.h"

@interface NSXMLParserViewController () <NSXMLParserDelegate>

@property (strong, nonatomic) NSMutableArray *parserObjects;
@property (copy, nonatomic) NSString *currentKey;
@property (strong, nonatomic) NSMutableString *currentValue;
@property (strong, nonatomic) NSMutableDictionary *currentDic;
@property (copy, nonatomic) NSString *Cdata;

@end

@implementation NSXMLParserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *xmlStr =
    @"<channel>\
<title>Title</title>\
<link>http://geekrrk.github.io</link>\
<description>Description</description>\
<language>en</language>\
<pubDate>Fri, 03 Jan 2016 10:24:30 GMT</pubDate>\
<item>\
<title>MyTitle</title>\
<author>MyAuthor</author>\
<time>MyTime</time>\
</item>\
</channel>";
    
    BOOL res = [self parser:xmlStr];
    if(!res) {
        NSLog(@"Failed to parse");
    }
}

- (BOOL)parser:(NSString*)string
{
    NSXMLParser *par = [[NSXMLParser alloc]
                        initWithData:[string
                                      dataUsingEncoding:NSUTF8StringEncoding]];
    [par setDelegate:self];
    
    return [par parse];
}

#pragma mark - NSXMLParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
//    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    self.parserObjects = [[NSMutableArray alloc] init];
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
//    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    self.currentValue = [[NSMutableString alloc] init];

    if ([elementName isEqualToString:@"item"]) {
        NSMutableDictionary *newNode =
        [[ NSMutableDictionary alloc] initWithCapacity: 0];
        self.currentDic = newNode;
        [self.parserObjects addObject: newNode];
    } else if (self.currentDic) {
        NSMutableString *string = [[NSMutableString alloc] initWithCapacity: 0];
        [self.currentDic setObject: string forKey: elementName];
        self.currentKey = elementName;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
//    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    [self.currentValue appendString: string];
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
//    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    if ([elementName isEqualToString:@"item"]) {
        self.currentDic = nil;
    }else if ([elementName isEqualToString:self.currentKey]) {
        if ([elementName isEqualToString:@"description"]
            ||[elementName isEqualToString:@"content:encoded"]) {
            [self.currentDic setObject:self.Cdata forKey:self.currentKey];
        }else {
            [self.currentDic setObject:self.currentValue
                              forKey:self.currentKey];
        }
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
//    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    NSLog(@"%@", self.parserObjects);
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
//    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    self.Cdata =[[NSString alloc] initWithData:CDATABlock
                                      encoding:NSUTF8StringEncoding];
}

@end
