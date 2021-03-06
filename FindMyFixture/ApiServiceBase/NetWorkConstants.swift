//
//  NetworkConstants.swift
//  FindMyFixture
//
//  Created by Konstantin Schirmer on 08.02.22.
//

import Foundation

enum URLConstants: String {
    case baseHttpScheme = "http"
    case baseHost = "hasashi.bplaced.net"
    case basePath = "/findmyfixture/php/"
}

enum UrlEndPaths: String {
    case getUserById = "getuser_byid_pdo.php"
    case getAllFixtures = "get_all_fixtures.php"
    case loginPath = "loginsql_fmf.php"
    case registerPath = "register_fmf.php"
    case addFixturePath = "add_fixture.php"
}




