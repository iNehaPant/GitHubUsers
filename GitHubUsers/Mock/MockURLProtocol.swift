//
//  MockHttpProtocol.swift
//  GitHubUsers
//
//  Created by Neha-NewOS on 17/06/2023.
//

import Foundation

class MockURLProtocol: URLProtocol {

    //static var stubResponseData: Data?
    //static var error: Error?
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func stopLoading() { }

    override func startLoading() {
         guard let handler = MockURLProtocol.requestHandler else {
            return
        }

        do {
            let (response, data)  = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch  {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }


}

/*class MockURLProtocol: URLProtocol {

    static var stubResponseData: Data?
    static var error: Error?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }


    override func startLoading() {

        if let signupError = MockURLProtocol.error {
            self.client?.urlProtocol(self, didFailWithError: signupError)
        } else {
            self.client?.urlProtocol(self, didLoad: MockURLProtocol.stubResponseData ?? Data())
        }

        self.client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() { }

}*/
