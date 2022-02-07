//
//  FmfError.swift
//  FindMyFixture
//
//  Created by Konstantin Schirmer on 07.02.22.
//

import Foundation


public enum FmfLoadError: Error {
    case urlLoadError
    case dataLoadError
    case imageLoadError
    case jsonCategoryLoadError
}

extension FmfLoadError : LocalizedError {
    
}
