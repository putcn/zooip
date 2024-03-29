#import "Dialog.h"
#import "Session.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
// global

static NSString* kDefaultTitle = @"与人人连接";

static CGFloat kRenRenBlue[4] = {0.0, 0.3686275, 0.67451, 1.0};
static CGFloat kBorderGray[4] = {0.3, 0.3, 0.3, 0.8};
static CGFloat kBorderBlack[4] = {0.3, 0.3, 0.3, 1};
static CGFloat kBorderBlue[4] = {0.23, 0.35, 0.6, 1.0};

static CGFloat kTransitionDuration = 0.3;

static CGFloat kTitleMarginX = 8;
static CGFloat kTitleMarginY = 4;
static CGFloat kPadding = 10;
static CGFloat kBorderWidth = 10;

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation Dialog

@synthesize session = _session, delegate = _delegate;

@synthesize navigationController;

///////////////////////////////////////////////////////////////////////////////////////////////////
// private

- (NSString*)string:(NSString*)actionString URLencode:(NSStringEncoding)enc {
	NSMutableString *escaped = [NSMutableString string];
	[escaped setString:[actionString stringByAddingPercentEscapesUsingEncoding:enc]];
	      
	[escaped replaceOccurrencesOfString:@"&" withString:@"%26" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
	[escaped replaceOccurrencesOfString:@"+" withString:@"%2B" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
	[escaped replaceOccurrencesOfString:@"," withString:@"%2C" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
	[escaped replaceOccurrencesOfString:@"/" withString:@"%2F" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
	[escaped replaceOccurrencesOfString:@":" withString:@"%3A" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
	[escaped replaceOccurrencesOfString:@";" withString:@"%3B" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
	[escaped replaceOccurrencesOfString:@"=" withString:@"%3D" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
	[escaped replaceOccurrencesOfString:@"?" withString:@"%3F" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
	[escaped replaceOccurrencesOfString:@"@" withString:@"%40" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
	[escaped replaceOccurrencesOfString:@" " withString:@"%20" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
	[escaped replaceOccurrencesOfString:@"\t" withString:@"%09" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
	[escaped replaceOccurrencesOfString:@"#" withString:@"%23" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
	[escaped replaceOccurrencesOfString:@"<" withString:@"%3C" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
	[escaped replaceOccurrencesOfString:@">" withString:@"%3E" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
	[escaped replaceOccurrencesOfString:@"\"" withString:@"%22" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
	[escaped replaceOccurrencesOfString:@"\n" withString:@"%0A" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
	return escaped;
}

- (void)addRoundedRectToPath:(CGContextRef)context rect:(CGRect)rect radius:(float)radius {
  CGContextBeginPath(context);
  CGContextSaveGState(context);

  if (radius == 0) {
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextAddRect(context, rect);
  } else {
    rect = CGRectOffset(CGRectInset(rect, 0.5, 0.5), 0.5, 0.5);
    CGContextTranslateCTM(context, CGRectGetMinX(rect)-0.5, CGRectGetMinY(rect)-0.5);
    CGContextScaleCTM(context, radius, radius);
    float fw = CGRectGetWidth(rect) / radius;
    float fh = CGRectGetHeight(rect) / radius;
    
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
  }

  CGContextClosePath(context);
  CGContextRestoreGState(context);
}

- (void)drawRect:(CGRect)rect fill:(const CGFloat*)fillColors radius:(CGFloat)radius {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();

  if (fillColors) {
    CGContextSaveGState(context);
    CGContextSetFillColor(context, fillColors);
    if (radius) {
      [self addRoundedRectToPath:context rect:rect radius:radius];
      CGContextFillPath(context);
    } else {
      CGContextFillRect(context, rect);
    }
    CGContextRestoreGState(context);
  }
  
  CGColorSpaceRelease(space);
}

- (void)strokeLines:(CGRect)rect stroke:(const CGFloat*)strokeColor {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();

  CGContextSaveGState(context);
  CGContextSetStrokeColorSpace(context, space);
  CGContextSetStrokeColor(context, strokeColor);
  CGContextSetLineWidth(context, 1.0);
    
  {
    CGPoint points[] = {rect.origin.x+0.5, rect.origin.y-0.5,
      rect.origin.x+rect.size.width, rect.origin.y-0.5};
    CGContextStrokeLineSegments(context, points, 2);
  }
  {
    CGPoint points[] = {rect.origin.x+0.5, rect.origin.y+rect.size.height-0.5,
      rect.origin.x+rect.size.width-0.5, rect.origin.y+rect.size.height-0.5};
    CGContextStrokeLineSegments(context, points, 2);
  }
  {
    CGPoint points[] = {rect.origin.x+rect.size.width-0.5, rect.origin.y,
      rect.origin.x+rect.size.width-0.5, rect.origin.y+rect.size.height};
    CGContextStrokeLineSegments(context, points, 2);
  }
  {
    CGPoint points[] = {rect.origin.x+0.5, rect.origin.y,
      rect.origin.x+0.5, rect.origin.y+rect.size.height};
    CGContextStrokeLineSegments(context, points, 2);
  }
  
  CGContextRestoreGState(context);

  CGColorSpaceRelease(space);
}

- (BOOL)shouldRotateToOrientation:(UIDeviceOrientation)orientation {
  if (orientation == _orientation) {
    return NO;
  } else {
    return orientation == UIDeviceOrientationLandscapeLeft
      || orientation == UIDeviceOrientationLandscapeRight
      || orientation == UIDeviceOrientationPortrait
      || orientation == UIDeviceOrientationPortraitUpsideDown;
  }
}

- (CGAffineTransform)transformForOrientation {
  UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
  if (orientation == UIInterfaceOrientationLandscapeLeft) {
    return CGAffineTransformMakeRotation(M_PI*1.5);
  } else if (orientation == UIInterfaceOrientationLandscapeRight) {
    return CGAffineTransformMakeRotation(M_PI/2);
  } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
    return CGAffineTransformMakeRotation(-M_PI);
  } else {
    return CGAffineTransformIdentity;
  }
}

- (void)sizeToFitOrientation:(BOOL)transform {
  if (transform) {
    self.transform = CGAffineTransformIdentity;
  }

  CGRect frame = [UIScreen mainScreen].applicationFrame;
  CGPoint center = CGPointMake(
    frame.origin.x + ceil(frame.size.width/2),
    frame.origin.y + ceil(frame.size.height/2));
  
  CGFloat width = frame.size.width - kPadding * 2;
  CGFloat height = frame.size.height - kPadding * 2;
  
  _orientation = [UIApplication sharedApplication].statusBarOrientation;
  if (UIInterfaceOrientationIsLandscape(_orientation)) {
    self.frame = CGRectMake(kPadding, kPadding, height, width);
  } else {
    self.frame = CGRectMake(kPadding, kPadding, width, height);
  }
  self.center = center;

  if (transform) {
    self.transform = [self transformForOrientation];
  }
}

- (void)updateWebOrientation {
  UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
  if (UIInterfaceOrientationIsLandscape(orientation)) {
    [_webView stringByEvaluatingJavaScriptFromString:
      @"document.body.setAttribute('orientation', 90);"];
  } else {
    [_webView stringByEvaluatingJavaScriptFromString:
      @"document.body.removeAttribute('orientation');"];
  }
}

- (void)bounce1AnimationStopped {
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:kTransitionDuration/2];
  [UIView setAnimationDelegate:self];
  [UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
  self.transform = CGAffineTransformScale([self transformForOrientation], 0.9, 0.9);
  [UIView commitAnimations];
}

- (void)bounce2AnimationStopped {
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:kTransitionDuration/2];
  self.transform = [self transformForOrientation];
  [UIView commitAnimations];
}

- (NSURL*)generateURL:(NSString*)baseURL params:(NSDictionary*)params {
  if (params) {
    NSMutableArray* pairs = [NSMutableArray array];
    for (NSString* key in params.keyEnumerator) {
      NSString* value = [params objectForKey:key];
      NSString* val = [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
      NSString* pair = [NSString stringWithFormat:@"%@=%@", key, val];
      [pairs addObject:pair];
    }
      
    NSString* query = [pairs componentsJoinedByString:@"&"];
    NSString* url = [NSString stringWithFormat:@"%@?%@", baseURL, query];
    return [NSURL URLWithString:url];
  } else {
    return [NSURL URLWithString:baseURL];
  }
}

- (NSMutableData*)generatePostBody:(NSDictionary*)params {
  if (!params) {
    return nil;
  }
  
  NSMutableData* body = [NSMutableData data];
  NSMutableArray* pairs = [NSMutableArray array];
	for (NSString* key in params.keyEnumerator) {
		NSString* value = [params objectForKey:key];
		NSString* val = [self string:value URLencode:NSUTF8StringEncoding];
		NSString* pair = [NSString stringWithFormat:@"%@=%@", key, val];
		[pairs addObject:pair];
	}
	
	[body appendData:[[pairs componentsJoinedByString:@"&"] dataUsingEncoding:NSUTF8StringEncoding]];

  return body;
}

- (void)addObservers {
  [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(deviceOrientationDidChange:)
    name:@"UIDeviceOrientationDidChangeNotification" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(keyboardWillShow:) name:@"UIKeyboardWillShowNotification" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(keyboardWillHide:) name:@"UIKeyboardWillHideNotification" object:nil];
	
	//new add by alex
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HideTheNavigationController:) name:@"POP" object:nil];
	
}

- (void)removeObservers {
  [[NSNotificationCenter defaultCenter] removeObserver:self
    name:@"UIDeviceOrientationDidChangeNotification" object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self
    name:@"UIKeyboardWillShowNotification" object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self
    name:@"UIKeyboardWillHideNotification" object:nil];
	
	//new add by alex
	//remove the observer of hide navigationController.
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"POP" object:nil];
}

- (void)HideTheNavigationController:(NSNotification*)notification 
{
	[self.navigationController.view removeFromSuperview];
}

- (void)postDismissCleanup {
  [self removeObservers];
  [self removeFromSuperview];
}

- (void)dismiss:(BOOL)animated {
  [self dialogWillDisappear];

  [_loadingURL release];
  _loadingURL = nil;
  
  if (animated) {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(postDismissCleanup)];
    self.alpha = 0;
    [UIView commitAnimations];
  } else {
    [self postDismissCleanup];
  }
}

- (void)cancel {
  [self dismissWithSuccess:NO animated:YES];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)init {
  return [self initWithSession:[Session session]];
}

- (id)initWithSession:(Session*)session {
  if (self = [super initWithFrame:CGRectZero]) {
	  
	  //init notification
	  
	  navigationController = [[UINavigationController alloc] initWithRootViewController:nil];
	  
	  
    _delegate = nil;
    _session = [session retain];
    _loadingURL = nil;
    _orientation = UIDeviceOrientationUnknown;
    _showingKeyboard = NO;
    
    self.backgroundColor = [UIColor clearColor];
    self.autoresizesSubviews = YES;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.contentMode = UIViewContentModeRedraw;
    
    UIImage* iconImage = [UIImage imageNamed:@"iphone-title-logo.png"];
    UIImage* closeImage = [UIImage imageNamed:@"close.png"];
    
    _iconView = [[UIImageView alloc] initWithImage:iconImage];
    [self addSubview:_iconView];
    
    UIColor* color = [UIColor colorWithRed:167.0/255 green:184.0/255 blue:216.0/255 alpha:1];
    _closeButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    [_closeButton setImage:closeImage forState:UIControlStateNormal];
    [_closeButton setTitleColor:color forState:UIControlStateNormal];
    [_closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_closeButton addTarget:self action:@selector(cancel)
      forControlEvents:UIControlEventTouchUpInside];
    _closeButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    _closeButton.showsTouchWhenHighlighted = YES;
    _closeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin
      | UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:_closeButton];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.text = kDefaultTitle;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin
      | UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:_titleLabel];
        
    _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    _webView.delegate = self;
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:_webView];

    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
      UIActivityIndicatorViewStyleWhiteLarge];
    _spinner.autoresizingMask =
      UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin
      | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self addSubview:_spinner];
  }
  return self;
}

- (void)dealloc {
  _webView.delegate = nil;
  [_webView release];
  [_spinner release];
  [_titleLabel release];
  [_iconView release];
  [_closeButton release];
  [_loadingURL release];
  [_session release];
  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIView

- (void)drawRect:(CGRect)rect {
  CGRect grayRect = CGRectOffset(rect, -0.5, -0.5);
  [self drawRect:grayRect fill:kBorderGray radius:10];

  CGRect headerRect = CGRectMake(
    ceil(rect.origin.x + kBorderWidth), ceil(rect.origin.y + kBorderWidth),
    rect.size.width - kBorderWidth*2, _titleLabel.frame.size.height);
  [self drawRect:headerRect fill:kRenRenBlue radius:0];
  [self strokeLines:headerRect stroke:kBorderBlue];

  CGRect webRect = CGRectMake(
    ceil(rect.origin.x + kBorderWidth), headerRect.origin.y + headerRect.size.height,
    rect.size.width - kBorderWidth*2, _webView.frame.size.height+1);
  [self strokeLines:webRect stroke:kBorderBlack];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
    navigationType:(UIWebViewNavigationType)navigationType {
	
	NSURL* url = request.URL;
	
	if ([url.scheme isEqualToString:@"rrconnect"]) 
	{
		if ([url.resourceSpecifier hasPrefix:@"//cancel"]) 
		{
			[self dialogDidCancel:url];
		} else 
		{
			[self dialogDidSucceed:url];
		}
		return NO;
	} 
	else if ([_loadingURL isEqual:url])
	{
		return YES;
	} 
	else if (navigationType == UIWebViewNavigationTypeLinkClicked)
	{
		if ([_delegate respondsToSelector:@selector(dialog:shouldOpenURLInExternalBrowser:)])
		{
			if (![_delegate dialog:self shouldOpenURLInExternalBrowser:url])
			{
				return NO;
			}
		}
		
		
		
		// [[UIApplication sharedApplication] openURL:request.URL];
		
		//[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://reg.renren.com"]];
		//[[[UIApplication sharedApplication] keyWindow] addSubview:navigationController.view];
		
//		RegistorWebView *reg =[[[RegistorWebView alloc] initWithURL:url] autorelease];


		
		RegistorWebView *reg =[[RegistorWebView alloc] initWithURL:url];
		reg.view.frame = CGRectMake(0, 30, 480, 290);
		
		[[[UIApplication sharedApplication] keyWindow] addSubview:navigationController.view];
		
		[navigationController initWithRootViewController:reg];
//		[navigationController pushViewController:reg animated:YES];
		[reg release];
		
		return NO;
	} 
	else
	{
		return YES;
	}
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  [_spinner stopAnimating];
  _spinner.hidden = YES;
  
  self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
  [self updateWebOrientation];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIDeviceOrientationDidChangeNotification

- (void)deviceOrientationDidChange:(void*)object {
  UIDeviceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
  if (!_showingKeyboard && [self shouldRotateToOrientation:orientation]) {
    [self updateWebOrientation];

    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [self sizeToFitOrientation:YES];
    [UIView commitAnimations];
  }
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIKeyboardNotifications

- (void)keyboardWillShow:(NSNotification*)notification {
  UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
  if (UIInterfaceOrientationIsLandscape(orientation)) {
    _webView.frame = CGRectInset(_webView.frame,
      -(kPadding + kBorderWidth),
      -(kPadding + kBorderWidth) - _titleLabel.frame.size.height);
  }

  _showingKeyboard = YES;
}

- (void)keyboardWillHide:(NSNotification*)notification {
	UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
  if (UIInterfaceOrientationIsLandscape(orientation)) {
    _webView.frame = CGRectInset(_webView.frame,
      kPadding + kBorderWidth,
      kPadding + kBorderWidth + _titleLabel.frame.size.height);
  }

  _showingKeyboard = NO;
}
 
///////////////////////////////////////////////////////////////////////////////////////////////////
// public

- (NSString*)title {
  return _titleLabel.text;
}

- (void)setTitle:(NSString*)title {
  _titleLabel.text = title;
}

- (void)show {
  [self load];
  [self sizeToFitOrientation:NO];

  CGFloat innerWidth = self.frame.size.width - (kBorderWidth+1)*2;  
  [_iconView sizeToFit];
  [_titleLabel sizeToFit];
  [_closeButton sizeToFit];

  _titleLabel.frame = CGRectMake(
    kBorderWidth + kTitleMarginX + _iconView.frame.size.width + kTitleMarginX - 2,
    kBorderWidth,
    innerWidth - (_titleLabel.frame.size.height + _iconView.frame.size.width + kTitleMarginX*2),
    _titleLabel.frame.size.height + kTitleMarginY*2);
  
  _iconView.frame = CGRectMake(
    kBorderWidth + kTitleMarginX - 7,
    kBorderWidth + floor(_titleLabel.frame.size.height/2 - _iconView.frame.size.height/2),
    _iconView.frame.size.width,
    _iconView.frame.size.height);

  _closeButton.frame = CGRectMake(
    self.frame.size.width - (_titleLabel.frame.size.height + kBorderWidth),
    kBorderWidth,
    _titleLabel.frame.size.height,
    _titleLabel.frame.size.height);
  
  _webView.frame = CGRectMake(
    kBorderWidth+1,
    kBorderWidth + _titleLabel.frame.size.height,
    innerWidth,
    self.frame.size.height - (_titleLabel.frame.size.height + 1 + kBorderWidth*2));

  [_spinner sizeToFit];
  [_spinner startAnimating];
  _spinner.center = _webView.center;

  UIWindow* window = [UIApplication sharedApplication].keyWindow;
  if (!window) {
    window = [[UIApplication sharedApplication].windows objectAtIndex:0];
  }
  [window addSubview:self];

  [self dialogWillAppear];
    
  self.transform = CGAffineTransformScale([self transformForOrientation], 0.001, 0.001);
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:kTransitionDuration/1.5];
  [UIView setAnimationDelegate:self];
  [UIView setAnimationDidStopSelector:@selector(bounce1AnimationStopped)];
  self.transform = CGAffineTransformScale([self transformForOrientation], 1.1, 1.1);
  [UIView commitAnimations];
	
  [self addObservers];
}

- (void)dismissWithSuccess:(BOOL)success animated:(BOOL)animated {
  if (success) {
    if ([_delegate respondsToSelector:@selector(dialogDidSucceed:)]) {
      [_delegate dialogDidSucceed:self];
    }
  } else {
    if ([_delegate respondsToSelector:@selector(dialogDidCancel:)]) {
      [_delegate dialogDidCancel:self];
    }
  }

  [self dismiss:animated];
}

- (void)dismissWithError:(NSError*)error animated:(BOOL)animated {
  if ([_delegate respondsToSelector:@selector(dialog:didFailWithError:)]) {
    [_delegate dialog:self didFailWithError:error];
  }

  [self dismiss:animated];
}

- (void)load {
  // Intended for subclasses to override
}

- (void)loadURL:(NSString*)url method:(NSString*)method get:(NSDictionary*)getParams
        post:(NSDictionary*)postParams {
  [_loadingURL release];
  _loadingURL = [[self generateURL:url params:getParams] retain];
  NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:_loadingURL];
  
  if (method) {
    [request setHTTPMethod:method];

    if ([[method uppercaseString] isEqualToString:@"POST"]) {
      NSData* body = [self generatePostBody:postParams];
			
      if (body) {
        [request setHTTPBody:body];
      }
    }
  }
  [_webView loadRequest:request];
}

- (void)dialogWillAppear {
}

- (void)dialogWillDisappear {
}

- (void)dialogDidSucceed:(NSURL*)url {
  [self dismissWithSuccess:YES animated:YES];
}

- (void)dialogDidCancel:(NSURL*)url {
	[self dismissWithSuccess:NO animated:YES];
}
@end
