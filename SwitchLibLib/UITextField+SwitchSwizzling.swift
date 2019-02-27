//
//  UITextField+SwitchSwizzling.swift
//  SwitchLibLib
//
//  Created by Dylan Elliott on 21/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import UIKit

private var hasSwizzled = false

extension UITextField {
	
	final public class func swizzle() {
		guard !hasSwizzled else { return }
		
		hasSwizzled = true
		swizzleMethods(self, Selector("setText:"), #selector(proj_setText(text:)))
	}
	

	@objc dynamic func proj_setText(text: String) {
		proj_setText(text: text)
		print(text)
	}
}

