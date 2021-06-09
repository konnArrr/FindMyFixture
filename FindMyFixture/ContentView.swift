//
//  ContentView.swift
//  FindMyFixture
//
//  Created by Student on 09.06.21.
//

import SwiftUI

struct ContentView: View {
    let loginService = LoginService()
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                loginService.checkLoginData(u: "admin", p: "admin")
                // print("userIsIn: \(loginService.userIsIn)")
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
