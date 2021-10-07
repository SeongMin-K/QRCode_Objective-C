//
//  MainViewController.m
//  QRCode_Objective-C
//
//  Created by SeongMinK on 2021/10/05.
//

#import "MainViewController.h"
#import <QRCodeReaderViewController/QRCodeReaderViewController.h>
#import <QRCodeReader.h>

@interface MainViewController () <QRCodeReaderDelegate>

{
    QRCodeReaderViewController *qrCodeVC;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Create the reader object
    QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];

    // Instantiate the view controller
    qrCodeVC = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancel" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];

    // Set the presentation style
    qrCodeVC.modalPresentationStyle = UIModalPresentationFormSheet;

    // Define the delegate receiver
    qrCodeVC.delegate = self;

    // Or use blocks
//    [_reader setCompletionWithBlock:^(NSString *resultAsString) {
//      NSLog(@"%@", resultAsString);
//    }];
    
    // 웹 뷰 띄우기
    NSURL *webSiteUrl = [NSURL URLWithString:@"http://www.naver.com"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:webSiteUrl];
    [_webView loadRequest:urlRequest];
    
    [_qrCodeBtn layer].borderColor = [UIColor greenColor].CGColor;
    [_qrCodeBtn layer].borderWidth = 2;
    [_qrCodeBtn layer].cornerRadius = 10;
    
    // QR 코드 스캔 버튼 이벤트 처리
    [_qrCodeBtn addTarget:self action:@selector(qrCodeReaderLaunch) forControlEvents:UIControlEventTouchUpInside];
}

- (void)qrCodeReaderLaunch {
    NSLog(@"MainViewController - qrCodeReaderLaunch() called");
    [self presentViewController:qrCodeVC animated:YES completion:NULL];
}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    NSLog(@"QR 코드 인식 성공!");
    
    // 웹 뷰 띄우기
    NSURL *webSiteUrl = [NSURL URLWithString:result];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:webSiteUrl];
    [_webView loadRequest:urlRequest];
    
  [self dismissViewControllerAnimated:YES completion:^{
    NSLog(@"QR 코드 결과: %@", result);
  }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    NSLog(@"QR 코드 스캔 취소");
  [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
