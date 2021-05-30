//
//  APIServer.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/18.
//

import Foundation

struct ApiUrl {
    private static let Production = "https://f22c6493-fe9a-4dba-a830-21b3849f47d7.mock.pstmn.io"
//
    private static let Domain = Production
    static let BaseURL = Domain + "/AnimalDodge/"
    
    static let appVersion = BaseURL + "appVersion.json"
}

class APIServer {
    private init() {}
    static let shared = APIServer()
    
    func oc_appVersion(completion: @escaping (_ model: AppVersion?) -> ()) {
        let request = oc_clientURLRequest(path: ApiUrl.appVersion+"?id=\(Const.self)",
                                       params: nil,
                                       data: nil,
                                       fileField: "")
        get(request: request) { (suc, object) in
            DispatchQueue.main.async {
                if let errorMessage = object as? String {
                    print("got error: \(errorMessage)")
                } else if let dic = object as? NSDictionary {
                    if let appVersion = dic.map(AppVersion.self) {
                        completion(appVersion)
                    }
                }
                completion(nil)
            }
        }
    }
    
    // private method
    private func post(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        oc_dataTask(request: request, method: "POST", completion: completion)
    }
    
    private func put(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        oc_dataTask(request: request, method: "PUT", completion: completion)
    }
    
    private func get(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        oc_dataTask(request: request, method: "GET", completion: completion)
    }
    
    private func delete(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        oc_dataTask(request: request, method: "DELETE", completion: completion)
    }
    
    private func oc_dataTask(request: NSMutableURLRequest,
                          method: String,
                          completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
            request.httpMethod = method
            
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
                
                if error != nil {
                    
                    print("Error!")
                    var message = error?.localizedDescription
                    
                    if (error! as NSError).code == -1001 {
                        message = "Server timed out. Try again later."
                    }
                    
                    completion(false, message as AnyObject)
                }
                else {
                    if let data = data {
                        
                        let jsonString = String(data: data, encoding: .utf8)
    //                    print("jsonString: \(jsonString!)")
                        
                        if let jsonObject = jsonString?.toObject() {
                            if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                                completion(true, jsonObject)
                            }
                            else {
                                 
                                if jsonObject is [String: Any] {
                                    let dict = jsonObject as! [String: Any]
                                    completion(false, dict as AnyObject)
                                }
                                else if jsonObject is NSArray {
                                    let array = jsonObject as! NSArray
                                    completion(false, array.removeNull() as AnyObject)
                                }
                                else {
                                    completion(false, jsonString as AnyObject)
                                }
                                
                            }
                        }
                    }
                }
                }.resume()
        }
    
    private func oc_clientURLRequest(path: String,
                                     params: [String: Any]?,
                                     authorization: Bool = false,
                                     data: Data?,
                                     fileField: String) -> NSMutableURLRequest {
            let request = NSMutableURLRequest(url: NSURL(string: path)! as URL)
            
            request.timeoutInterval = 20
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            if authorization {
                let token = UserDefaults.standard.string(forKey: "UserToken")
                request.addValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
            }
            
            if let params = params {
                if let data = data {
                    let boundary = generateBoundaryString()
                    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                    
                    request.httpBody = oc_createBodyWithParameters(parameters: params, filePathKey: fileField, imageDataKey: data, boundary: boundary)
                }
                else {
                    request.addValue("application/json-patch+json", forHTTPHeaderField: "Content-Type")
                    
                    let jsonTodo: Data
                    do {
                        jsonTodo = try JSONSerialization.data(withJSONObject: params, options: [])
                        request.httpBody = jsonTodo
                    } catch {
                        print("Error: cannot create JSON from todo")
                    }
                }
            }
            
            return request
        }
    
    func oc_createBodyWithParameters(parameters: [String: Any]?, filePathKey: String?, imageDataKey: Data, boundary: String) -> Data {
        var body = Data();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.append("\(value)\r\n")
            }
        }
        
        let filename = "receiptImage.jpg"
        let mimetype = "image/jpg"
        
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.append("Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey)
        body.append("\r\n")
        
        body.append("--\(boundary)--\r\n")
        
        return body
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...length-1).map{ _ in letters.randomElement()! })
    }
}

extension Data {
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}

private func sp_getUsersMostFollowerSuccess() {
    print("Check your Network")
}
