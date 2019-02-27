//
//  SwitchLib.swift
//  SwitchLibLib
//
//  Created by Dylan Elliott on 21/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import UIKit

public class SwitchLib {
	public static func initialize() {
		UIViewController.swizzle()
		UITextField.swizzle()
	}
}
