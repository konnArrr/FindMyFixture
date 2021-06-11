//
//  ContentView.swift
//  FindMyFixture
//
//  Created by Student on 09.06.21.
//

import SwiftUI

struct ContentView: View {
    
    let loginService = LoginService()
    let userLoader = UserLoader()
    let registerService = UserRegisterService()
    let fixtureLoader = FixtureLoader()
    let addingService = FixtureAdding()

    
    
    let fixture = Fixture(id: 1, name: "Pointe", producer: "Robe Roberts", power: 1200, powerLight: 700, headMover: 1, goboWheels: 2, prisms: 3, minZoom: 15.0, maxZoom: 45.0, colorSystem: 1, dmxModes: 2, minDmx: 27, maxDmx: 45, weight: 26, comment: "Klassiker und macht was er soll", imageURL: "http://hasashi.bplaced.net/findmyfixture/images/default_mh_img.png")
    
    var body: some View {
        LoginView()
//            .padding()
//            .onAppear {
////                loginService.userLogin(username: "gue", password: "ads") { (success, msg, uid) in
////                    print("succes: \(success)")
////                    print("msg: \(msg)")
////                    print("uid: \(uid)")
////                }
//
////                userLoader.getUserBy(userId: 16) { (user) in
////                    print("\(user)")
////                }
////                registerService.registerUser(username: "bärbel", password: "bärbel") { (string) in
////                    print("\(string)")
////                }
//                // print("userIsIn: \(loginService.userIsIn)")
////                fixtureLoader.loadAllFixtures { (fixtures) in
////                    print("\(fixtures)")
////                }
////                addingService.addFixture(fixture: fixture) { (msg) in
////                    print("\(msg)")
////                }
//
//            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
