//
//  CustomError.swift
//  Classmates
//
//  Created by Duolan Ouyang on 10/28/21.
//  Copyright © 2021 TripleC. All rights reserved.
//

import Foundation

enum CustomError: Error {
    // Throw when an invalid password is entered
    case invalidPassword

    // Throw when an expected resource is not found
    case notFound

    // Throw in all other cases
    case unexpected(code: Int)
    
}
