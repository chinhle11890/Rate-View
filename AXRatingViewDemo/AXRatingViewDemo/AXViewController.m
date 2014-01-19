//
//  AXViewController.m
//  AXRatingViewDemo
//

#import "AXViewController.h"

@implementation AXViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  
  CGFloat padding = 28.0;
  CGRect componentBounds = (CGRect){
    padding, 0.0,
    CGRectGetWidth(self.view.bounds) - padding * 2, 32.0
  };
  __block NSUInteger positionCounter = 0;
  
  CGRect (^nextFrame)() = ^CGRect() {
    return CGRectOffset(componentBounds, 0.0, padding * ++positionCounter);
  };

  // Smooth

  UILabel *basicLabel = [[UILabel alloc] initWithFrame:nextFrame()];
  basicLabel.text = @"Smooth";
  [self.view addSubview:basicLabel];

  AXRatingView *basicRatingView = [[AXRatingView alloc] initWithFrame:nextFrame()];
  [basicRatingView sizeToFit];
  [self.view addSubview:basicRatingView];

  // Step

  UILabel *stepLabel = [[UILabel alloc] initWithFrame:nextFrame()];
  stepLabel.text = @"Step";
  [self.view addSubview:stepLabel];

  AXRatingView *stepRatingView = [[AXRatingView alloc] initWithFrame:nextFrame()];
  [stepRatingView sizeToFit];
  [stepRatingView setSmoothEditing:NO];
  [self.view addSubview:stepRatingView];
  
  // Free character
  
  UILabel *freeCharacterLabel = [[UILabel alloc] initWithFrame:nextFrame()];
  freeCharacterLabel.text = @"Free character";
  [self.view addSubview:freeCharacterLabel];
  
  AXRatingView *freeCharacterRatingView = [[AXRatingView alloc] initWithFrame:nextFrame()];
  [freeCharacterRatingView setMarkCharacter:@"\u263B"];
  freeCharacterRatingView.markFont = [UIFont systemFontOfSize:18.0];
  [freeCharacterRatingView sizeToFit];
  [self.view addSubview:freeCharacterRatingView];
  
  // Free image
  
  UILabel *freeImageLabel = [[UILabel alloc] initWithFrame:nextFrame()];
  freeImageLabel.text = @"Free image";
  [self.view addSubview:freeImageLabel];
  
  AXRatingView *freeImageRatingView = [[AXRatingView alloc] initWithFrame:nextFrame()];
  [freeImageRatingView setMarkImage:[UIImage imageNamed:@"face"]];
  [freeImageRatingView sizeToFit];
  [self.view addSubview:freeImageRatingView];
  
  // Not editable
  
  UILabel *notEditableLabel = [[UILabel alloc] initWithFrame:nextFrame()];
  notEditableLabel.text = @"Not editable";
  [self.view addSubview:notEditableLabel];
  
  AXRatingView *notEditableRatingView = [[AXRatingView alloc] initWithFrame:nextFrame()];
  [notEditableRatingView sizeToFit];
  [notEditableRatingView setUserInteractionEnabled:NO];
  [notEditableRatingView setValue:4.0];
  [self.view addSubview:notEditableRatingView];
  
  // More stars
  
  UILabel *moreStarsLabel = [[UILabel alloc] initWithFrame:nextFrame()];
  moreStarsLabel.text = @"More stars";
  [self.view addSubview:moreStarsLabel];
  
  AXRatingView *moreStarsRatingView = [[AXRatingView alloc] initWithFrame:nextFrame()];
  [moreStarsRatingView setNumberOfStar:12];
  [moreStarsRatingView sizeToFit];
  [self.view addSubview:moreStarsRatingView];

  // Set and get

  self.label = [[UILabel alloc] initWithFrame:nextFrame()];
  [self.view addSubview:_label];
  
  self.ratingView = [[AXRatingView alloc] initWithFrame:nextFrame()];
  _ratingView.smoothEditing = NO;
  _ratingView.value = 2.5;
  _ratingView.userInteractionEnabled = YES; // if NO, just showing. default value is YES.
  [_ratingView addTarget:self action:@selector(ratingChanged:) forControlEvents:UIControlEventValueChanged];
  [_ratingView sizeToFit];
  [self.view addSubview:_ratingView];
  
  self.slider = [[UISlider alloc] initWithFrame:nextFrame()];
  _slider.minimumValue = 0.0;
  _slider.maximumValue = 5.0;
  [_slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:_slider];
  
  [self ratingChanged:self.ratingView];
}

- (void)sliderChanged:(UISlider *)sender
{
  [self.ratingView setValue:[sender value]];
}

- (void)ratingChanged:(AXRatingView *)sender
{
  [self.slider setValue:[sender value]];
  [self.label setText:[NSString stringWithFormat:@"Set and Get Sample: %.2f", sender.value]];
}

@end
