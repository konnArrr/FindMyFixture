//
//  LoginService.swift
//  FindMyFixture
//
//  Created by Student on 09.06.21.
//

import Foundation
import SwiftUI

class LoginService: ObservableObject {
    @Published var userIsIn:Bool = false
    @Published var errorText: String = ""
    @Published var responseTextSendRegister: String = ""
    
    
    
    var aData: NSMutableArray = NSMutableArray()
    
    // , userIsIn: Binding<Bool>
    
    public func checkLoginData(u: String, p: String){
        
        print("\(u)/\(p)" )
        // eigenen link eintragen oder von Alex
//        let url:URL = URL(string: "http://18.192.126.85/ios/login_register/loginsql.php")!
        let url:URL = URL(string: "http://hasashi.bplaced.net/findmyfixture/php/loginsql_fmf.php")!
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        //Mitzusendene Parameter definieren
        let bodyData:String = "username=\(u)&password=\(p)"

        //Parameter an Anfragenpaket übergeben
        request.httpBody = bodyData.data(using: String.Encoding.utf8)
        //===============  ----
        //=============== 3. Sendeprozess und Datenladeprozess definieren .
        // print("\(request.httpBody)")
        URLSession.shared.dataTask(with: request){ data,response,error in
            //=== - Antwort in Bytes - ====
            print(data)
            //=== - Antwort in String - ====
            let resultStr:String = String(data: data!, encoding: String.Encoding.utf8 )!
            print(resultStr)
//            //=== - Antwort in JSON -> Array - ====
            self.aData = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSMutableArray
//            print((self.aData.object(at: 0) as! NSMutableDictionary).object(forKey: "txt") as! String)
            DispatchQueue.main.async {
                // let antwort = (aData.object(at: 0) as! NSMutableDictionary).object(forKey: "txt") as! String
                if((self.aData.object(at: 0) as! NSMutableDictionary).object(forKey: "state") as! String == "3"){
                    self.userIsIn = true
                    // userIsIn = self.userIsIn
                } else {
                    self.errorText = (self.aData.object(at: 0) as! NSMutableDictionary).object(forKey: "txt") as! String
                }
            }
        }.resume()
    }
}
