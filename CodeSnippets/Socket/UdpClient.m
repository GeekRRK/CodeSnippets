//
//  UdpClient.m
//  CodeSnippets
//
//  Created by GeekRRK on 1/25/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/in.h>
#import <arpa/inet.h>

int GetServerAddr(char *addrname)
{
    printf("please input server addr:");
    scanf("%s",addrname);
    return 1;
}
int main(int argc, char **argv)
{
    int cli_sockfd;
    int len;
    socklen_t addrlen;
    char seraddr[14];
    struct sockaddr_in cli_addr;
    char buffer[256];
    GetServerAddr(seraddr);
    cli_sockfd = socket(AF_INET,SOCK_DGRAM,0);
    if(cli_sockfd < 0)
    {
        printf("I cannot socket success\n");
        return 1;
    }

    addrlen = sizeof(struct sockaddr_in);
    bzero(&cli_addr, addrlen);
    cli_addr.sin_family = AF_INET;
    cli_addr.sin_addr.s_addr = inet_addr(seraddr);
    // cli_addr.sin_addr.s_addr = htonl(INADDR_ANY);
    cli_addr.sin_port = htons(1024);
    bzero(buffer, sizeof(buffer));
    len = read(STDIN_FILENO, buffer, sizeof(buffer));
    sendto(cli_sockfd, buffer, len, 0, (struct sockaddr*)&cli_addr, addrlen);
    len = recvfrom(cli_sockfd, buffer, sizeof(buffer), 0, (struct sockaddr*)&cli_addr, &addrlen);
    // printf("receive from %s\n",inet_ntoa(cli_addr.sin_addr));
    printf("receive: %s", buffer);
    close(cli_sockfd);
}