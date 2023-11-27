//
//  NSObject+ObjcRuntime.swift
//  
//
//  Created by Mikalai Shuhno on 28/11/2023.
//

import Foundation

extension NSObject {
  /// The class of the instance reported by the ObjC `-class:` message.
  ///
  /// - note: `type(of:)` might return the runtime subclass, while this property
  ///         always returns the original class.
  @nonobjc internal var objcClass: AnyClass {
    return (self as AnyObject).objcClass
  }
}

