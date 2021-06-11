//
//  LoginService.swift
//  FindMyFixture
//
//  Created by Student on 09.06.21.
//

import Foundation
import SwiftUI


class LoginService: ObservableObject {
    
    private let decoder = JSONDecoder()
    private var loginSucces: Bool = false
    
    public func userLogin(username: String, password: String, completion: @escaping (_ loginSucces: Bool, _ message: String, _ userId: Int) -> Void) {
        guard let url:URL = URL(string: "http://hasashi.bplaced.net/findmyfixture/php/loginsql_fmf.php") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        let bodyData:String = "username=\(username)&password=\(password)"
        request.httpBody = bodyData.data(using: String.Encoding.utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else { return }
            guard let httpResponse: HTTPURLResponse = response as? HTTPURLResponse else { return }
            let statusCode = httpResponse.statusCode
//            print("statusCode: \(statusCode)")
            guard (200..<299).contains(statusCode) else { return }
            guard let data = data else { return }
            do {
                let dataResponse = try self.decoder.decode([LoginResponse].self, from: data)
                DispatchQueue.main.async {
                    guard let loginData = dataResponse.first else { return }
                    if loginData.state == "3" {
                        self.loginSucces = true
                    } else {
                        self.loginSucces = false
                    }
                    completion(self.loginSucces, loginData.message, Int(loginData.userId) ?? 0)
//                    print("\(loginData)")
                }
            } catch DecodingError.keyNotFound(let key, let context) {
                Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
            } catch DecodingError.valueNotFound(let type, let context) {
                Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
            } catch DecodingError.typeMismatch(let type, let context) {
                Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
            } catch DecodingError.dataCorrupted(let context) {
                Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
            } catch let error as NSError {
                NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
            }
        }.resume()
    }
    
 
}
