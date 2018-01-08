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
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

/**
 Responsible for creating and managing `Request` objects and returning response model and error
 */

class MSBaseService<Model : Mappable> {
    
    var model :  Model!
    
    // MARK: - Request
    
    /**
     Creates a request for the specified method, URL string, parameters, parameter encoding and headers.
     
     - parameter URLString:  The URL string.
     - parameter method:     The HTTP method.
     - parameter query:      The query parameters. `nil` by default.
     - parameter headers:    The HTTP headers. `nil` by default.
     - parameter body:       The parameters. `nil` by default.
     
     - returns: The response in given model class and error.
     */
     func makeRequest(with urlString:String, method: HTTPMethod = .get, query: [String:String]? = nil, headers: [String : String]? = nil, body: [String : Any]? = nil, successCompletionHandler : @escaping (_ model : Model) -> Void , failureCompletionHandler : @escaping ((_ error : Error) -> Void ) ) -> Void {
        let completeUrl:String
        
        var params: [String] = []
        
        if let query = query {
            query.forEach({ (key: String, value: String) in
                let param = "\(key)=\(value)"
                params.append(param)
            })
        }
        
        let queryString = params.joined(separator: "&")
        completeUrl = "\(urlString)?\(queryString)"
        
        
        //Create request
        guard let url = URL(string: completeUrl) else {
            failureCompletionHandler(MSNetworking.requestUrlError())
            return
        }
        var request = URLRequest(url: url)
        
        //Add headers
        if let headers = headers {
            headers.forEach({ (key: String, value: String) in
                request.setValue(value, forHTTPHeaderField: key)
            })
        }
        
        //Add body
        if let body = body {
            do {
                let bodyData = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                request.httpBody = bodyData
            } catch {
                let bodyError = MSNetworkingError.request(message:"Could not serialize JSON, check input.")
                failureCompletionHandler(bodyError) //Exit if invalid body is provided
            }
        }
        
        //Set method
       request.httpMethod = method.rawValue
        
        print("REQUEST\n")
        print("URL - \(urlString)\n")
        if let body = body {
            print("BODY - \(body)\n")
        }
        //end
        
        //Make request
        Alamofire.request(request)
            .responseObject { (response: DataResponse<Model>) in
    
                print("RESPONSE\n")
                if let httpResponse = response.response {
                    print("CODE - \(httpResponse.statusCode)\n")
                }
                if let data = response.data {
                    print("BODY - \(String(data:data, encoding:.utf8) ?? "Unknown")\n")
                }
                //end

                switch response.result {
                case .success(let value):
                    if response.result.value != nil {
                        self.model = value
                        DispatchQueue.main.async {
                            successCompletionHandler(self.model)
                        }
                    }
                case .failure:
                    guard let data = response.data else {
                        failureCompletionHandler(MSNetworkingError.response(message:"Error response does not contain body."))
                        return
                    }

                    let json:[String:Any]
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                        guard let jsonDictionary = jsonObject as? [String:Any] else {
                            failureCompletionHandler(MSNetworkingError.response(message:"Response does not contain valid JSON dictionary."))
                            return
                        }
                        json = jsonDictionary
                    } catch {
                        failureCompletionHandler(MSNetworkingError.response(message:"Response does not contain valid JSON."))
                        return
                    }

                    let newError = NSError(domain: "com.mindstix.baseline", code: response.response?.statusCode ?? -1, userInfo: json)
                    failureCompletionHandler(newError)
                }
        }
    }
}
