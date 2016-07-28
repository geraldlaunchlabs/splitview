//
//  DetailViewController.h
//  SplitView
//
//  Created by LLDM on 28/07/2016.
//  Copyright © 2016 LLDM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate> {
    UIView *view1;
    UIView *view2;    
    UITextField *myTextField;
    UIPickerView *myPickerView;
    NSArray *pickerArray;
    UISwitch *mySwitch;
    UISlider *mySlider;
    UIAlertView *alertView;
}

-(IBAction)flipFromLeft:(id)sender;
-(IBAction)flipFromRight:(id)sender;
-(IBAction)flipFromTop:(id)sender;
-(IBAction)flipFromBottom:(id)sender;
-(IBAction)curlUp:(id)sender;
-(IBAction)curlDown:(id)sender;
-(IBAction)dissolve:(id)sender;
-(IBAction)noTransition:(id)sender;

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

