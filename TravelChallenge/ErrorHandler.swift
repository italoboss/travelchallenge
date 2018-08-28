//
//  ErrorHandler.swift
//  TravelChallenge
//
//  Created by Italo Boss on 28/08/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import Foundation

class ErrorHandler {
    
    static func printErrorMessage(error: NSError) {
        print(" [ERROR] \(error.code): \(error.localizedDescription)")
        print(" -> \(String(describing: error.localizedFailureReason))")
        print(" -> \(String(describing: error.localizedRecoverySuggestion))")
    }
    
    static func alertErrorMessage(error: NSError) {
        
    }
    
}
