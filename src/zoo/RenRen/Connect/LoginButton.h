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

#import "Session.h"

typedef enum {
  LoginButtonStyleNormal,
  LoginButtonStyleWide,
} LoginButtonStyle;

/**
 * 登录或退出的标准按钮
 *
 */
@interface LoginButton : UIControl <SessionDelegate, UIAlertViewDelegate> {
  LoginButtonStyle _style;
  Session* _session;
  UIImageView* _imageView;
}

@property(nonatomic) LoginButtonStyle style;

@property(nonatomic,retain) Session* session;

@end
