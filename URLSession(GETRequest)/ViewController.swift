//
//  ViewController.swift
//  URLSession(GETRequest)
//
//  Created by Poonam on 26/06/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getRequest12()
        //getRequest11()
        //getRequest10()
        //getRequest9(parameters:["postId" : "1"])
        //getRequest8()
        //getRequest7()
        //getRequest6()
        //getRequest5()
        //getRequest4()
        //getRequest3()
        //getRequest2()
        //getRequest1()
    }
    
    //MARK: Get request with Header

    func getRequest12() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        var urlRequest = URLRequest(url: url)
        //urlRequest.allHTTPHeaderFields = ["Content-Type": "application/json"]
        //urlRequest.setValue("Content-Type", forHTTPHeaderField: "application/json")
        //urlRequest.addValue("Content-Type", forHTTPHeaderField: "application/json")
        urlRequest.httpMethod = "GET"
        
        let session = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data {
                if let json = String(data: data, encoding: .utf8) {
                    print(json)
                }
            }
            if let response = response as? HTTPURLResponse {
                print(response.allHeaderFields)
            }
        }
        session.resume()
    }
    
    
    //MARK: Parsing data with JSONDecoder (Decodable protocol) and CodingKeys enum
    func getRequest11() {
        
        struct Post:Decodable {
            let body:String?
            let id:Int?
            let title:String?
            let user_id:Int?
            
            enum CodingKeys: String, CodingKey {
                case body
                case id
                case title
                case user_id = "userId"
            }
        }
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let posts = try JSONDecoder().decode([Post].self, from: data)
                    print(posts)
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    
    //MARK: Parsing data with JSONDecoder (Decodable protocol)
    func getRequest10() {
        
        struct Post:Decodable {
            let body:String?
            let id:Int?
            let title:String?
            let userId:Int?
        }
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let posts = try JSONDecoder().decode([Post].self, from: data)
                    print(posts)
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
        
    //MARK: Get request with  parameters
    func getRequest9(parameters:[String:String]) {
       
        guard var urlComponet = URLComponents(string: "https://jsonplaceholder.typicode.com/comments") else { return }
        
        var queryItems:[URLQueryItem] = []
        for item in parameters {
            queryItems.append(URLQueryItem(name: item.key, value: item.value))
        }
        urlComponet.queryItems = queryItems
        
        guard let query = urlComponet.query else {
            return
        }
        print("query:\(query)")
        
        guard let url = urlComponet.url else {
            return
        }
        print("url:\(url)")
        
        URLSession.shared.dataTask(with:url) { (data, response, error) in
            if let data = data {
                let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [])
                print(jsonObject!)
            }
        }.resume()
    }
    
    //MARK: Get request with mulitple parameters
    func getRequest8() {
        
        guard var urlComponet = URLComponents(string: "https://jsonplaceholder.typicode.com/comments") else { return }
        urlComponet.queryItems = [URLQueryItem(name: "postId", value: "1"), URLQueryItem(name: "postId", value: "2")]
        
        guard let query = urlComponet.query else {
            return
        }
        print("query:\(query)")
        
        guard let url = urlComponet.url else {
            return
        }
        print("url:\(url)")

        
        URLSession.shared.dataTask(with:url) { (data, response, error) in
            if let data = data {
                let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [])
                print(jsonObject!)
            }
        }.resume()
    }
    
    
    //MARK: Get request with single parameter
    func getRequest7() {
        
        guard var urlComponet = URLComponents(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        urlComponet.queryItems = [URLQueryItem(name: "postId", value: "1")]
        
        guard let query = urlComponet.query else {
            return
        }
        print("query:\(query)")
        
        guard let url = urlComponet.url else {
            return
        }
        print("url:\(url)")

        
        URLSession.shared.dataTask(with:url) { (data, response, error) in
            if let data = data {
                let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [])
                print(jsonObject!)
            }
        }.resume()
    }
    
    //MARK: Data to josnObject (Native Object) Using try?
    func getRequest6() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [])
                print(jsonObject!)
            }
        }.resume()
    }
    
    //MARK: Data to josnObject (Native Object) Using try catch block
    func getRequest5() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    print(jsonObject)
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    //MARK: Data to string(JSON)
    func getRequest4() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let stringData = String(data: data, encoding: .utf8) {
                    print(stringData)
                }
            }
        }.resume()
    }
    
    
    //MARK: Calling with invalid url(status code 404)
    func getRequest3() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/pots") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
        }.resume()
    }
    
    //MARK: Http status code verification
    func getRequest2() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                if response.statusCode >= 200 && response.statusCode < 300 {
                    print(response)
                }
            }
        }.resume()
    }

    //MARK: Sample get request

    func getRequest1() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                print(data)
            }
            if let response = response {
                print(response)
            }
            if let error = error {
                print(error)
            }
        }.resume()
        
    }

}

