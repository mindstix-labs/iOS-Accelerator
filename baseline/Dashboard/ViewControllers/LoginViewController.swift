// Copyright (c) 2017-18 Mindstix Software Labs, Inc.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit
import FBSDKLoginKit
import TwitterKit
/**
 * ViewController giving socialmedia login options
 * Social Media options- Facebook, Twitter
 *
 */

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add facebook login button
        let btnFacebook = FBSDKLoginButton()
        btnFacebook.frame = CGRect(origin: CGPoint(x: 90,y :200), size: CGSize(width: 200, height: 30))
        btnFacebook.readPermissions = nil
        btnFacebook.delegate = self
        self.view.addSubview(btnFacebook);
        
        //Add Twitter Login Button
        let twitterLogInButton = TWTRLogInButton(logInCompletion: { session, error in
            if (session != nil) {
                print("signed in as \(String(describing: session?.userName))");
            } else {
                print("error: \(String(describing: error?.localizedDescription))");
            }
        })
        twitterLogInButton.frame = CGRect(origin: CGPoint(x: 90,y :260), size: CGSize(width: 200, height: 30))
        self.view.addSubview(twitterLogInButton)
    }
    
    //MARK:- FBSDKLoginButtonDelegate
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let weatherReportViewController = storyboard.instantiateViewController(withIdentifier: "WeatherReportViewController")
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.pushViewController(weatherReportViewController, animated: true)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
}
