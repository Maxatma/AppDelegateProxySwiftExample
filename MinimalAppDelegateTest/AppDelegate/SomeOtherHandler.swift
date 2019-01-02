//
//  SomeOtherHandler.swift
//
//
//  Created by Oleksandr Zaporozhchenko on 1/2/19.
//  Copyright © 2019 Grafect. All rights reserved.
//

import UIKit

public class SomeOtherHandler: AppDelegateHandler {
	func application(_: UIApplication,
	                 didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		print("SomeOtherHandler didFinishLaunchingWithOptions")
		return true
	}
}
