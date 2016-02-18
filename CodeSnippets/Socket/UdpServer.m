////
////  UdpServer.m
////  CodeSnippets
////
////  Created by GeekRRK on 1/25/16.
////  Copyright © 2016 GeekRRK. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//#include <stdio.h>
//#include <stdlib.h>
//#include <string.h>
//#include <errno.h>
//#include <sys/types.h>
//#include <sys/socket.h>
//#include <netinet/in.h>
//#import <arpa/inet.h>
//
//int main(int argc, char **argv)
//{
//    int ser_sockfd;
//    int len;
//    //int addrlen;
//    socklen_t addrlen;
//    char seraddr[100];
//    struct sockaddr_in ser_addr;
//
//    ser_sockfd = socket(AF_INET,SOCK_DGRAM,0);
//    if(ser_sockfd < 0)
//    {
//        printf("I cannot socket success\n");
//        return 1;
//    }
//
//    addrlen = sizeof(struct sockaddr_in);
//    bzero(&ser_addr, addrlen);
//    ser_addr.sin_family = AF_INET;
//    ser_addr.sin_addr.s_addr = htonl(INADDR_ANY);
//    ser_addr.sin_port = htons(1024);
//
//    if(bind(ser_sockfd, (struct sockaddr *)&ser_addr, addrlen) < 0)
//    {
//        printf("connect");
//        return 1;
//    }
//    while(1)
//    {
//        bzero(seraddr, sizeof(seraddr));
//        len = recvfrom(ser_sockfd, seraddr, sizeof(seraddr), 0, (struct sockaddr*)&ser_addr, &addrlen);
//        printf("receive from %s\n",inet_ntoa(ser_addr.sin_addr));
//        printf("recevce:%s", seraddr);
//        sendto(ser_sockfd, seraddr, len, 0, (struct sockaddr*)&ser_addr, addrlen);
//    }
//}