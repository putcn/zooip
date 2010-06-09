/*
 * Thank you for Facebook original source code
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * modified by xuyan(yan.xu@opi-corp.com) to fit RenRen in China.
 */

#import "LoginButton.h"
#import "LoginDialog.h"

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation LoginButton

@synthesize session = _session, style = _style;

///////////////////////////////////////////////////////////////////////////////////////////////////
// private

- (UIImage*)buttonImage {
  if (_session.isConnected) {
		if (_style == LoginButtonStyleNormal) {
			return [UIImage imageNamed:@"logout button_blue_up_90X30.png"];
		} else if (_style == LoginButtonStyleWide) {
			return [UIImage imageNamed:@"logout button_blue_up_112X23.png"];
		} else {
			return nil;
		}
  } else {
    if (_style == LoginButtonStyleNormal) {
      return [UIImage imageNamed:@"login button_blue_up_90X30.png"];
    } else if (_style == LoginButtonStyleWide) {
      return [UIImage imageNamed:@"login button_blue_up_112X23.png"];
    } else {
      return nil;
    }
  }
}

- (UIImage*)buttonHighlightedImage {
  if (_session.isConnected) {
    if (_style == LoginButtonStyleNormal) {
			return [UIImage imageNamed:@"logout button_blue_down_90X30.png"];
		} else if (_style == LoginButtonStyleWide) {
			return [UIImage imageNamed:@"logout button_blue_down_112X23.png"];
		} else {
			return nil;
		}
  } else {
    if (_style == LoginButtonStyleNormal) {
      return [UIImage imageNamed:@"login button_blue_down_90X30.png"];
    } else if (_style == LoginButtonStyleWide) {
      return [UIImage imageNamed:@"login button_blue_down_112X23.png"];
    } else {
      return nil;
    }
  }
}

- (void)updateImage {
  if (self.highlighted) {
    _imageView.image = [self buttonHighlightedImage];
  } else {
    _imageView.image = [self buttonImage];
  }
}

- (void)touchUpInside {
  if (_session.isConnected) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定退出吗？" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
    [alert show];
		[alert release];
  } else {
    LoginDialog* dialog = [[[LoginDialog alloc] initWithSession:_session] autorelease];
    [dialog show];
	}
}

- (void)initButton {
  _style = LoginButtonStyleNormal;

  _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  _imageView.contentMode = UIViewContentModeCenter;
	_imageView.image = [self buttonImage];
  [self addSubview:_imageView];

  self.backgroundColor = [UIColor clearColor];
  [self addTarget:self action:@selector(touchUpInside)
    forControlEvents:UIControlEventTouchUpInside];

  self.session = [Session session];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self initButton];
    if (CGRectIsEmpty(frame)) {
      [self sizeToFit];
    }
  }
  return self;
}

- (void)dealloc {
  [_session.delegates removeObject:self];
  [_session release];
  [_imageView release];
  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIView

- (CGSize)sizeThatFits:(CGSize)size {
  return _imageView.image.size;
}

- (void)layoutSubviews {
  _imageView.frame = self.bounds;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIControl

- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];
  [self updateImage];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// SessionDelegate

- (void)session:(Session*)session didLogin:(RRUID)uid {
  [self updateImage];
}

- (void)sessionDidLogout:(Session*)session {
  [self updateImage];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSLog(@"%d", buttonIndex);
	if(buttonIndex == 0) {
		[_session logout];
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// public

- (void)setSession:(Session*)session {
  if (session != _session) {
    [_session.delegates removeObject:self];
    [_session release];
    _session = [session retain];
    [_session.delegates addObject:self];
    
    [self updateImage];
  }
}

- (void)setStyle:(LoginButtonStyle)style {
  _style = style;
  
  [self updateImage];
}

@end
