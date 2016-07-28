//
//  DetailViewController.m
//  SplitView
//
//  Created by LLDM on 28/07/2016.
//  Copyright © 2016 LLDM. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTextView];
    [self setUpView];
    [self addPickerView];
    [self addSwitch];
    [self addSlider];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)addTextView{
    UITextView *myTextView = [[UITextView alloc]initWithFrame:
                  CGRectMake(50,350,275,100)];
    [myTextView setText:@"Trivia:\n\n\nA 3-digit result of any number multiplied by 11 has its middle digit the sum of other two, like\n\n21 × 11 = 231 (2+1=3)\n\n13 × 11 = 143 (1+3=4)\n\n44 × 11 = 484 (4+4=8)"];
    myTextView.delegate = self;
    [self.view addSubview:myTextView];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"Did begin editing");
}

-(void)textViewDidChange:(UITextView *)textView{ NSLog(@"Did Change");
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"Did End editing");
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
    return YES;
}

#pragma mark - Text View delegates

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange: (NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}

-(void)setUpView{
    view1 = [[UIView alloc]initWithFrame:self.view.frame];
    view1.backgroundColor = [UIColor lightTextColor];
    view2 = [[UIView alloc]initWithFrame:self.view.frame];
    view2.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view1];
    [self.view sendSubviewToBack:view1];
}

- (void)doTransitionWithType:(UIViewAnimationOptions)animationTransitionType {
    if ([[self.view subviews] containsObject:view2 ]) {
        [UIView transitionFromView:view2
                            toView:view1
                          duration:2
                           options:animationTransitionType
                        completion:^(BOOL finished) {
                            [view2 removeFromSuperview];
                        }];
        [self.view addSubview:view1];
        [self.view sendSubviewToBack:view1];
    } else {
        [UIView transitionFromView:view1
                            toView:view2
                          duration:2
                           options:animationTransitionType
                        completion:^(BOOL finished) {
                            [view1 removeFromSuperview];
                        }];
        [self.view addSubview:view2];
        [self.view sendSubviewToBack:view2];
    }
}

- (IBAction)curlDown:(id)sender {
    [self doTransitionWithType:UIViewAnimationOptionTransitionCurlDown];
}

- (IBAction)curlUp:(id)sender {
    [self doTransitionWithType:UIViewAnimationOptionTransitionCurlUp];
}

- (IBAction)flipFromTop:(id)sender {
    [self doTransitionWithType:UIViewAnimationOptionTransitionFlipFromTop];
}

- (IBAction)flipFromBottom:(id)sender {
    [self doTransitionWithType:UIViewAnimationOptionTransitionFlipFromBottom];
}

- (IBAction)flipFromRight:(id)sender {
    [self doTransitionWithType:UIViewAnimationOptionTransitionFlipFromRight];
}

- (IBAction)flipFromLeft:(id)sender {
    [self doTransitionWithType:UIViewAnimationOptionTransitionFlipFromLeft];
}

- (IBAction)dissolve:(id)sender {
    [self doTransitionWithType:UIViewAnimationOptionTransitionCrossDissolve];
}

- (IBAction)noTransition:(id)sender {
    [self doTransitionWithType:UIViewAnimationOptionTransitionNone];
}

-(void)addPickerView{
    pickerArray = [[NSArray alloc]initWithObjects:@"Basketball",@"Chess",@"Cricket",@"Football",@"Tennis",@"Volleyball",nil];
    myTextField = [[UITextField alloc]initWithFrame: CGRectMake(50,300,275,30)];
    myTextField.borderStyle = UITextBorderStyleRoundedRect;
    myTextField.textAlignment = NSTextAlignmentCenter; myTextField.delegate = self;
    [self.view addSubview:myTextField];
    [myTextField setPlaceholder:@"Pick a Sport"]; myPickerView = [[UIPickerView alloc]init];
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    myPickerView.showsSelectionIndicator = YES;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done:)];
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame: CGRectMake(0, self.view.frame.size.height -50, 320, 50)];
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    NSArray *toolbarItems = [NSArray arrayWithObjects: doneButton, nil];
    [toolBar setItems:toolbarItems];
    myTextField.inputView = myPickerView; myTextField.inputAccessoryView = toolBar;
}

- (void)done:(id)sender {
    [myTextField resignFirstResponder];
}

#pragma mark - Text field delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField.text isEqualToString:@""]) {
        //[self dateChanged:nil];
    }
}

#pragma mark - Picker View Data source

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [pickerArray count];
}

#pragma mark - Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component { [myTextField setText:[pickerArray objectAtIndex:row]];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}

-(IBAction)switched:(id)sender{
    NSLog(@"Switch current state %@", mySwitch.on ? @"On" : @"Off");
    [self addAlertView];
        [alertView setMessage:[NSString stringWithFormat:@"Switched %@",mySwitch.on? @"On" : @"Off"]];
}

-(void)addSwitch{
    mySwitch = [[UISwitch alloc] init];
    [self.view addSubview:mySwitch];
    mySwitch.center = CGPointMake(330,92);
    [mySwitch setOn:YES];
    mySwitch.layer.cornerRadius = 20;
    mySwitch.backgroundColor = mySwitch.tintColor = [UIColor redColor];
    [mySwitch addTarget:self action:@selector(switched:) forControlEvents:UIControlEventValueChanged];
}

-(IBAction)sliderChanged:(id)sender{
    NSLog(@"SliderValue %f",mySlider.value);
    self.detailDescriptionLabel.text = [NSString stringWithFormat:@"%03d",(int)mySlider.value];
}

-(void)addSlider{
    mySlider = [[UISlider alloc] initWithFrame:CGRectMake(20,85,100,23)]; [self.view addSubview:mySlider];
    mySlider.minimumValue = 0;
    mySlider.maximumValue = 999;
    mySlider.continuous = YES;
    [mySlider setValue:[[self.detailItem description] floatValue] animated:YES];
    [mySlider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
}

-(void)addAlertView{
    alertView = [[UIAlertView alloc]initWithTitle:@"SWITCH"
                                                       message:@""
                                                      delegate:self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:@"Ok", nil];
    [alertView show];
}

#pragma mark - Alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [mySwitch setOn:!mySwitch.on animated:YES];
            NSLog(@"Cancel button clicked");
            break;
        case 1:
            NSLog(@"OK button clicked");
            break;
        default:
            break;
    }
}

@end
