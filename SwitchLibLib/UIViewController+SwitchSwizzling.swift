//
//  UIViewController+SwitchSwizzling.swift
//  SwitchLib
//
//  Created by Dylan Elliott on 21/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import UIKit
import SwiftySound

private var hasSwizzled = false

extension UIViewController {
	
	final public class func swizzle() {
		guard !hasSwizzled else { return }
		
		hasSwizzled = true
		swizzleMethods(self, #selector(viewWillAppear(_:)), #selector(proj_viewWillAppear(animated:)))
	}
	
	// MARK: - Method Swizzling
	
	@objc func proj_viewWillAppear(animated: Bool) {
		self.proj_viewWillAppear(animated: animated)
		
		let viewControllerName = NSStringFromClass(type(of: self))
		print("viewWillAppear: \(viewControllerName)")
		
		findSwitchText { didFind in
			print("SWITCHLIB: \(viewControllerName) \(didFind ? "FOUND" : "NOT")")
			if didFind {
				playSwitch()
			}
		}
	}
}

extension UIViewController {
	func findSwitchText(completion: (Bool) -> Void) {
		self.view.recurse { subview in
			switch subview {
			case let label as UILabel:
				if let text = label.text, text.lowercased().contains("switch") {
					completion(true); return true
				}
			case let textField as UITextField:
				if let text = textField.text, text.lowercased().contains("switch") {
					completion(true); return true
				} else if let placeholder = textField.placeholder, placeholder.lowercased().contains("switch") {
					completion(true); return true
				}
			default: break
			}
			
			return false
		}
	}
	
	private func playSwitch() {
		Sound.soundsBundle = Bundle(for: SwitchLib.self)
		let success = Sound.play(file: "switch.m4a")
		
		if success == false {
			print("SWITCHLIB: Error playing sounds")
		}
	}
}
