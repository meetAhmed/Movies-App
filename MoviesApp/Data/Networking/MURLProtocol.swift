//
//  MURLProtocol.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 18/03/2025.
//

import Foundation

class MURLProtocol: URLProtocol {
    private var sessionTask: URLSessionDataTask?
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        printReq(request)
        
        let session = URLSession(configuration: .default)
        sessionTask = session.dataTask(with: request) { [weak self] data, response, error in
            guard let self else { return }
            
            if let response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                printRes(response, data)
            }
            
            if let data {
                client?.urlProtocol(self, didLoad: data)
            }
            
            if let error {
                client?.urlProtocol(self, didFailWithError: error)
            }
            
            client?.urlProtocolDidFinishLoading(self)
        }
        sessionTask?.resume()
    }
    
    override func stopLoading() {
        sessionTask?.cancel()
    }
}

private extension MURLProtocol {
    func printReq(_ req: URLRequest) {
        print("\n[Request] Method: \(req.httpMethod ?? "") URL: \(req.url?.absoluteString ?? "")")
        if let headers = request.allHTTPHeaderFields {
            print("Headers: \(headers)")
        }
        if let body = request.httpBody, let bodyStr = String(data: body, encoding: .utf8) {
            print("Request Body: \(bodyStr)")
        }
    }
    
    func printRes(_ res: URLResponse, _ data: Data?) {
        if let httpRes = res as? HTTPURLResponse {
            print("\n[Response] \(httpRes.statusCode) \(httpRes.url?.absoluteString ?? "")")
        }
        if let data, let dataStr = String(data: data, encoding: .utf8) {
            print("Response Body: \(dataStr)")
        }
    }
}
