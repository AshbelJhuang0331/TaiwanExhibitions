//
//  API.swift
//  TaiwanExhibitions
//
//  Created by Chuan-Jie Jhuang on 2022/3/16.
//

import Foundation

class API: NSObject {
        
    private struct URI {
        static let scheme = "https"
        static let host = "cloud.culture.tw"
        static let path = "/frontsite/trans/SearchShowAction.do"
        static let defaultQuery = ""
    }
    
    private var urlComponents = URLComponents()
    private let session = URLSession.shared
    
    override init() {
        super.init()
        self.urlComponents.scheme = URI.scheme
        self.urlComponents.host = URI.host
        self.urlComponents.path = URI.path
    }
    
    func fetchAllExhibitions(succeed: @escaping (Data) -> Void, fail: @escaping (Error) -> Void) {
//        self.urlComponents.query = "method=doFindTypeJ&category=6"
//        self.urlComponents.queryItems = [
//            URLQueryItem(name: "method", value: "doFindTypeJ"),
//            URLQueryItem(name: "category", value: "6")
//        ]
        self.urlComponents.queryItems = [
            "method": "doFindTypeJ",
            "category": "6"
        ].map{ URLQueryItem(name: $0.key, value: $0.value) }
        let url = self.urlComponents.url
        session.dataTask(with: url!) { (data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard error == nil else {
                    fail(error!)
                    return
                }
                if let data = data {
                    succeed(data)
                }
            }
        }.resume()
    }
    
}
