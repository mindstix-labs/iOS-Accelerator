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


class MSHomeContainer: UIViewController {
    var launchOptions:NSDictionary?
    
    public func initWithLaunchOptions(launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Self {
        //required to handle app launch
        let homeContainer = MSHomeContainer()
        homeContainer.launchOptions = launchOptions as NSDictionary?
        return self
    }
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if(Constants.SOCIAL_LOGIN){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            self.navigationController?.navigationBar.isHidden = false
            
            let navigationController = UINavigationController.init(rootViewController: loginViewController)
            self.addChildViewController(navigationController)
            self.view.addSubview(navigationController.view)
        }else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let weatherReportViewController = storyboard.instantiateViewController(withIdentifier: "WeatherReportViewController")
            self.navigationController?.navigationBar.isHidden = false
            
            let navigationController = UINavigationController.init(rootViewController: weatherReportViewController)
            self.addChildViewController(navigationController)
            self.view.addSubview(navigationController.view)
        }
        
    }
}
