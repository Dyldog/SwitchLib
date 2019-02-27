//
//  Swizzle.swift
//  SwitchLibLib
//
//  Created by Dylan Elliott on 21/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation

internal let swizzleMethods: (AnyObject.Type, Selector, Selector) -> () = { type, originalSelector, swizzledSelector in
	
	let originalMethod = class_getInstanceMethod(type, originalSelector)!
	let swizzledMethod = class_getInstanceMethod(type, swizzledSelector)!
	
//	method_exchangeImplementations(originalMethod, swizzledMethod)
	
	let didAddMethod = class_addMethod(type, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
	
	if didAddMethod {
		class_replaceMethod(type, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
	} else {
		method_exchangeImplementations(originalMethod, swizzledMethod)
	}
}
