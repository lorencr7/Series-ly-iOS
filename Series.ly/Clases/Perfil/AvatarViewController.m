//
//  AvatarViewController.m
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 07/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "AvatarViewController.h"
#import "User.h"
#import "UIImage+StackBlur.h"
#import "ManejadorServicioWebSeriesLy.h"


@interface AvatarViewController ()

@end

@implementation AvatarViewController

/*- (id)initWithFrame:(CGRect)frame User: (User *) user {
    self = [super initWithFrame:frame];
    if (self) {
        self.user = user;
        self.title = @"perfil";
    }
    return self;
}*/

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.title = @"perfil";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
        //NSLog(@"%.2f",self.view.frame.size.height);
    self.view.backgroundColor = [UIColor yellowColor];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) getData {
    ManejadorServicioWebSeriesLy * manejadorServicioWebSeriesLy = [ManejadorServicioWebSeriesLy getInstance];
    self.user = [manejadorServicioWebSeriesLy getUserInfoWithRequest:nil ProgressView:nil];
    
    if (self.user) {
        return YES;
    } else {
        return NO;
    }
    
}

-(void) createData {
    [self createBlurPhoto];
    [self createNameView];
    [self createProfilePhoto];
    [self stopActivityIndicator];
    self.view.layer.masksToBounds = YES;
}

-(void) createBlurPhoto {
    self.blurImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    //self.blurImageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.blurImageView];
    [self performSelectorInBackground:@selector(configureBlurPhoto) withObject:nil];
}

-(void) configureBlurPhoto {
    NSNumber * photoHeight = [NSNumber numberWithDouble:MIN(self.blurImageView.frame.size.width, self.blurImageView.frame.size.height)];
    
    
    //self.blurImageView = [[UIImageView alloc] initWithFrame:CGRectMake(borderX, borderY, photoHeight.intValue, photoHeight.intValue)];
    //self.blurImageView.layer.cornerRadius = photoHeight.intValue/2;
    
    NSString * imageURL = self.user.imgUser;
    NSMutableDictionary * arguments = [[NSMutableDictionary alloc] init];
    [arguments setObject:self.blurImageView forKey:@"imageView"];
    [arguments setObject:imageURL forKey:@"url"];
    [arguments setObject:photoHeight forKey:@"maxHeight"];
    [arguments setObject:photoHeight forKey:@"maxWidth"];
    [self configureImageView:arguments];
    
    [self performSelectorOnMainThread:@selector(setUpBlurPhoto) withObject:nil waitUntilDone:YES];
}

-(void) setUpBlurPhoto {
    UIImage * blurredImage = [self.blurImageView.image stackBlur:10];
    [self.blurImageView setImage:blurredImage];
    CGRect frame = self.blurImageView.frame;
    frame.origin.y = -100;
    frame.size.width = self.view.frame.size.width;
    frame.size.height = self.view.frame.size.width;
    self.blurImageView.frame = frame;
}

-(void) createNameView {
    int height = 50;
    NSString * text = self.user.nick;
    
    UIView *viewText = [[UIView  alloc] initWithFrame:CGRectMake(0,
                                                                 self.view.frame.size.height/2 - height/2,
                                                                 self.view.frame.size.width,
                                                                 50)];
    viewText.backgroundColor = [UIColor colorWithRed:(0/255) green:(0/255) blue:(0/255) alpha:0.8];
    [self.view addSubview:viewText];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(115,
                                                               0,
                                                               self.view.frame.size.width - 110,
                                                               50)];
    label.backgroundColor = [UIColor clearColor];
    label.text = text;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    label.numberOfLines = 2;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    
    [viewText addSubview:label];
}

-(void) createProfilePhoto {
    NSNumber * photoHeight = @90;
    //int borderX = (self.view.frame.size.width/2) - (photoHeight.intValue/2);
    //int borderY = 5;
    
    int borderX = 5;
    int borderY = self.view.frame.size.height/2 - photoHeight.intValue/2;
    
    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(borderX, borderY, photoHeight.intValue, photoHeight.intValue)];
    self.avatarImageView.image = [UIImage imageNamed:@"photomissing.png"];
    self.avatarImageView.layer.cornerRadius = photoHeight.intValue/2;
    self.avatarImageView.layer.borderWidth = 2;
    self.avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.avatarImageView.layer.masksToBounds = YES;
    [self.view addSubview:self.avatarImageView];
    
    NSString * imageURL = self.user.imgUser;
    NSMutableDictionary * arguments = [[NSMutableDictionary alloc] init];
    [arguments setObject:self.avatarImageView forKey:@"imageView"];
    [arguments setObject:imageURL forKey:@"url"];
    [arguments setObject:photoHeight forKey:@"maxHeight"];
    [arguments setObject:photoHeight forKey:@"maxWidth"];
    [self performSelectorInBackground:@selector(configureImageView:) withObject:arguments];
    
}

@end
