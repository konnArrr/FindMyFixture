//
//  URLHost.swift
//  FindMyFixture
//
//  Created by Konstantin Schirmer on 08.02.22.
//

import Foundation

struct URLHost: RawRepresentable {
    var rawValue: String
}

extension URLHost {
    static var staging: Self {
        URLHost(rawValue: URLConstants.baseHost.rawValue)
    }

    static var production: Self {
        URLHost(rawValue: URLConstants.baseHost.rawValue)
    }

    static var `default`: Self {
        #if DEBUG
        return staging
        #else
        return production
        #endif
    }
}

extension URL {
    static var staging: URL {
        return URL(string: URLConstants.baseHttpScheme.rawValue + "://" + URLConstants.baseHost.rawValue + URLConstants.basePath.rawValue)!
    }

    static var production: URL {
        return URL(string: URLConstants.baseHttpScheme.rawValue + "://" + URLConstants.baseHost.rawValue + URLConstants.basePath.rawValue)!
    }

    static var `default`: URL {
        #if DEBUG
        return staging
        #else
        return production
        #endif
    }
    
}
