//
//  File.swift
//  
//
//  Created by Mikalai Shuhno on 27/11/2023.
//

import Foundation

internal func synchronized<Result>(_ token: AnyObject, execute: () throws -> Result) rethrows
-> Result
{
    objc_sync_enter(token)
    defer { objc_sync_exit(token) }
    return try execute()
}
