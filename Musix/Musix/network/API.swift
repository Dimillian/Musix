//
//  API.swift
//  Musix
//
//  Created by Thomas Ricouard on 02/07/2017.
//  Copyright © 2017 Thomas Ricouard. All rights reserved.
//

import Foundation
import Alamofire

/**
 Structure for an API Response.

 Can be consumed and forwarded at the view level.
 */
struct APIResponse<Class> {

    /// Generic object, contain the processed data from the API, if any.
    public var object: Class?

    /// Error from the API or API response processor if any.
    public var error: Error?

    /// Indicate if this respone come from cache or network. True if from cache.
    public var cached: Bool

    public var request: APIReqest
    public var response: HTTPURLResponse?

    public init(object: Class?, error: Error?, cached: Bool, request: APIReqest, response: HTTPURLResponse?) {
        self.object = object
        self.error = error
        self.cached = cached
        self.request = request
        self.response = response
    }
}

class APIReqest: URLRequestConvertible {

    static let baseURL = URL(string: "https://api.music.apple.com/v1/")!

    static var token: String {
        if let path = Bundle.main.path(forResource: "conf", ofType: "plist"), let conf = NSDictionary(contentsOfFile: path) {
            if let token = conf["token"] as? String {
                return token
            }
        }
        return ""
    }

    let path: String
    let params: [String: AnyObject]?

    var method: Alamofire.HTTPMethod {
        return .get
    }

    func asURLRequest() throws -> URLRequest {
        return URLRequest(url: APIReqest.baseURL)
    }

    init(path: String, params: [String: AnyObject]?) {
        self.path = path
        self.params = params
    }

    /// Run the current request against the API and forward the result in the completion handler.
    open func start<Class: Codable>(_ completionHandler: @escaping (APIResponse<Class>) -> Void) {
        guard let request = try? asURLRequest() else {
            completionHandler(APIResponse(object: nil, error: nil, cached: false, request: self, response: nil))
            return
        }

        DispatchQueue.global().async {
            Alamofire.request(request).responseData(completionHandler: { (response) in
                if let data = response.data {
                    do {
                        let object = try JSONDecoder().decode(Class.self, from: data)
                        completionHandler(APIResponse(object: object,
                                                      error: nil,
                                                      cached: false,
                                                      request: self,
                                                      response: response.response))
                    } catch {
                        print(error)
                        completionHandler(APIResponse(object: nil,
                                                      error: nil,
                                                      cached: false,
                                                      request: self,
                                                      response:
                            response.response))
                    }
                } else {
                    completionHandler(APIResponse(object: nil, error: nil, cached: false, request: self, response: nil))
                }
            }).resume()
        }
    }
}

class GETRequest: APIReqest {

    var headers: [String: String] {
        return ["Authorization": "Bearer \(APIReqest.token)"]
    }

    override func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: APIReqest.baseURL.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        return try Alamofire.URLEncoding.default.encode(request, with: params)
    }
}
