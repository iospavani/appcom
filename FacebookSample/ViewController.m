//
//  ViewController.m
//  FacebookSample
//
//  Created by Pavani_ios on 10/3/16.
//  Copyright © 2016 Pavani_iosasman. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>


@interface ViewController (){
    FBSDKLoginButton *loginButton;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
    [self getFacebookData];
    [self buttonForGoogle];
//    FBSDKLoginButton *loginView = [[FBSDKLoginButton alloc] init];
//   // NSArray *requiredPermissions = @[@"publish_actions"];
//
//    loginView.readPermissions =  @[@"publish_actions"];
//    loginView.frame = CGRectMake(100, 150, 100, 40);
//    [self.view addSubview:loginView];
//    
//    
//    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
//    [parameters setValue:@"id,name,email" forKey:@"fields"];
//    
//    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
//     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
//                                  id result, NSError *error) {
//         NSLog(@"%@",result);
//     }];
//
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)buttonForGoogle{
    NSLog(@"googleplus");
}
- (void)getFacebookData{
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"first_name, last_name, picture.type(large), email, name, id, gender"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"fetched user:%@", result);
                 UIImageView *imageView  = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
                 NSString *stringUrl = [[[result objectForKey:@"picture"]objectForKey:@"data"] objectForKey:@"url"];
                 NSURL *url = [[NSURL alloc] initWithString:stringUrl];

                 NSData *imageData = [NSData dataWithContentsOfURL:url];
                 [imageView setImage:[UIImage imageWithData:imageData]];
                 [self.view addSubview:imageView];
                 
                 UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 220, 150, 50)];
                 label.text = [result objectForKey:@"name"];
                 [self.view addSubview:label];
             }
             
         }];
    }
   // loginButton.hidden = YES;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
