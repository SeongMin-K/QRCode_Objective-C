//
//  MainViewController.h
//  QRCode_Objective-C
//
//  Created by SeongMinK on 2021/10/05.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *qrCodeBtn;

@end

