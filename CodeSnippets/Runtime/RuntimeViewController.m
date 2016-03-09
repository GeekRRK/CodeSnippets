//
//  RuntimeViewController.m
//  CodeSnippets
//
//  Created by GeekRRK on 1/21/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "RuntimeViewController.h"
#import <objc/runtime.h>
#import "RuntimeClassVC.h"

//typedef struct objc_method *Method;
//typedef struct objc_ivar *Ivar;
//typedef struct objc_category *Category;
//typedef struct objc_property *objc_property_t;

//struct objc_class {
//    Class isa;
//#if !__OBJC2__
//    Class super_class;
//    const char *name;
//    long version;
//    long info;
//    long instance_size
//    struct objc_ivar_list *ivars
//    struct objc_method_list **methodLists;
//    struct objc_cache *cache;
//    struct objc_protocol_list *protocols
//#endif
//} OBJC2_UNAVAILABLE;
///* Use `Class` instead of `struct objc_class *` */

//+ (BOOL)resolveClassMethod:(SEL)sel;
//+ (BOOL)resolveInstanceMethod:(SEL)sel;
//- (id)forwardingTargetForSelector:(SEL)aSelector;
//- (void)forwardInvocation:(NSInvocation *)anInvocation;

static char associatedObjectKey;

@interface RuntimeViewController ()

@end

@implementation RuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getInfoOfClass: [RuntimeClassVC class]];
    
    [self performSelector:@selector(resolveAdd:) withObject:@"test"];
    
    [self addAssociatedObject:@"Add Property String"];
    NSLog(@"%@", [self getAssociatedObject]);
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL systemSel = @selector(viewWillAppear:);
        SEL swizzSel = @selector(swiz_viewWillAppear:);
        Method systemMethod = class_getInstanceMethod([self class], systemSel);
        Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
        BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
        if (isAdd) {
            class_replaceMethod(self, swizzSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        } else {
            method_exchangeImplementations(systemMethod, swizzMethod);
        }
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}

- (void)swiz_viewWillAppear:(BOOL)animated {
    [self swiz_viewWillAppear:animated];
    NSLog(@"swizzle");
}

- (void)getInfoOfClass: (Class) class{
    unsigned int count;

    objc_property_t *propertyList = class_copyPropertyList([class class], &count);
    for (unsigned int i = 0; i < count; ++i) {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"property---->%@", [NSString stringWithUTF8String:propertyName]);
    }

    Method *methodList = class_copyMethodList([class class], &count);
    for (unsigned int i; i < count; ++i) {
        Method methodName = methodList[i];
        NSLog(@"method---->%@", NSStringFromSelector(method_getName(methodName)));
    }

    Ivar *ivarList = class_copyIvarList([class class], &count);
    for (unsigned int i; i < count; ++i) {
        Ivar myivar = ivarList[i];
        const char *ivarName = ivar_getName(myivar);
        NSLog(@"ivar---->%@", [NSString stringWithUTF8String:ivarName]);
    }

    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([class class], &count);
    for (unsigned int i; i < count; ++i) {
        Protocol *myprotocal = protocolList[i];
        const char *protocolName = protocol_getName(myprotocal);
        NSLog(@"protocol---->%@", [NSString stringWithUTF8String:protocolName]);
    }
}

void runAddMethod(id self, SEL _cmd, NSString *string){
    NSLog(@"add C IMP %@", string);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if ([NSStringFromSelector(sel) isEqualToString:@"resolveAdd:"]) {
        class_addMethod(self, sel, (IMP)runAddMethod, "v@:*");
    }
    return YES;
}

- (void)associateObject {
    objc_setAssociatedObject(self, &associatedObjectKey, @"Add Property String", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSString *string = objc_getAssociatedObject(self, &associatedObjectKey);
    NSLog(@"AssociatedObject = %@", string);
}

- (void)addAssociatedObject:(id)object{
    objc_setAssociatedObject(self, @selector(getAssociatedObject), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)getAssociatedObject{
    return objc_getAssociatedObject(self, _cmd);
}

@end
