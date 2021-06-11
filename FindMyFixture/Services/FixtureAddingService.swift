//
//  FixtureAddingService.swift
//  FindMyFixture
//
//  Created by Student on 10.06.21.
//

import Foundation


class FixtureAdding {
    private let decoder = JSONDecoder()
    
    
    public func addFixture(fixture: Fixture, completion: @escaping (_ message: String) -> Void) {
        guard let url:URL = URL(string: "http://hasashi.bplaced.net/findmyfixture/php/add_fixture.php") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        let bodyData:String = """
        name=\(fixture.name)\
        &producer=\(fixture.producer)\
        &power=\(fixture.power)\
        &powerlight=\(fixture.powerLight)\
        &headmover=\(fixture.headMover)\
        &gobowheels=\(fixture.goboWheels)\
        &prisms=\(fixture.prisms)\
        &minzoom=\(fixture.minZoom)\
        &maxzoom=\(fixture.maxZoom)\
        &colorsystem=\(fixture.colorSystem)\
        &dmxmodes=\(fixture.dmxModes)\
        &mindmx=\(fixture.minDmx)\
        &maxdmx=\(fixture.maxDmx)\
        &maxdmx=\(fixture.maxDmx)\
        &weight=\(fixture.weight)\
        &comment=\(fixture.comment)
        """
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
