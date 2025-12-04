//
//  OperationResult.swift
//  AP3Tag
//
//  Created by Aviran Dabush on 02/12/2025.
//

import Foundation

struct OperationResult<T> {
    let success: Bool
    let message: String
    let value: T?
    
    init(success: Bool, message: String, value: T? = nil) {
        self.success = success
        self.message = message
        self.value = value
    }
}
