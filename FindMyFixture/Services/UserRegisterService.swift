//
//  UserRegisterService.swift
//  FindMyFixture
//
//  Created by Student on 10.06.21.
//

import Foundation
import SwiftUI


class UserRegisterService: ObservableObject {
    
    private let decoder = JSONDecoder()

    
    public func registerUser(username: String, password: String, completion: @escaping (_ message: String) -> Void) {
        guard let url:URL = URL(string: "http://hasashi.bplaced.net/findmyfixture/php/register_fmf.php") else {
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
                let dataResponse = try self.decoder.decode([PhpResponse].self, from: data)
                DispatchQueue.main.async {
                    guard let registerResponse = dataResponse.first else { return }
                    completion(registerResponse.message)
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
