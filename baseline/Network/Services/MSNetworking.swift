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

import Foundation

/**
 Responsible for setting up error while creating request or response
 */

public struct MSNetworkingError {
    enum MSNetworkingErrorType {
        case request
        case response
    }
    
    let type:MSNetworkingErrorType
    let content:String
    
    init(type: MSNetworkingErrorType, content:String) {
        self.content = content
        self.type = type
    }
    public static func request(message:String) -> MSNetworkingError {
        return MSNetworkingError(type: .request, content: message)
    }
    public static func response(message:String) -> MSNetworkingError {
        return MSNetworkingError(type: .response, content: message)
    }
}

extension MSNetworkingError: CustomNSError {
    public static var errorDomain: String {
        return "com.mindstix.baseline"
    }
    
    public var errorCode:Int {
        switch self.type {
        case .request:
            return 0
        case .response:
            return 1
        }
    }
    
    public var errorUserInfo: [String:Any] {
        let userInfo:[String:Any] = [NSLocalizedFailureReasonErrorKey:self.content as NSString]
        return userInfo
    }
}

@objc public class MSNetworking: NSObject {
    
    @objc public static let sharedInstance = MSNetworking()
    
    public class func requestUrlError() -> MSNetworkingError {
        return MSNetworkingError.request(message:"Could not create url, check input")
    }
}
