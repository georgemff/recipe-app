//
//  Auth.swift
//  receipe
//
//  Created by Giorgi Adeishvili on 14.11.22.
//

import Foundation

struct Auth {
    var isAuth: Bool = false
    
    mutating func setAuth(_ auth: Bool) {
        isAuth = auth
    }
}
