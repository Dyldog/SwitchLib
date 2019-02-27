//
//  UIView+Recurse.swift
//  SwitchLib
//
//  Created by Dylan Elliott on 21/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import UIKit

extension UIView {
	func recurse(_ block: (UIView) -> (Bool)) {
		for subview in self.subviews {
			subview.recurse(block)
			let stop = block(subview)
			
			if stop { return }
		}
	}
}
