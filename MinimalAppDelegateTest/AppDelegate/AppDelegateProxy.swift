//
//  AppDelegateProxy.swift
//  Pods
//
//  Created by Andrey Zarembo on 10.02.16.
//
//

import UIKit

@UIApplicationMain
public class AppDelegateProxy: NSObject, UIApplicationDelegate {
	public var handlers: [AppDelegateHandler] = [
		RemoteNotificationHandler(),
		SomeOtherHandler(),
	]

	public override func responds(to aSelector: Selector!) -> Bool {
		if shouldForwardSelector(aSelector: aSelector) {
			for handler in handlers {
				if handler.responds(to: aSelector) {
					return true
				}
			}
		}
		return NSObject.instancesRespond(to: aSelector)
	}

	public override func forwardingTarget(for aSelector: Selector!) -> Any? {
		for handler in handlers {
			if handler.responds(to: aSelector) {
				return handler
			}
		}
		return nil
	}

	private func shouldForwardSelector(aSelector: Selector) -> Bool {
		return
			isSelector(aSelector: aSelector, fromProtocol: UIApplicationDelegate.self) &&
			!isSelector(aSelector: aSelector, fromProtocol: NSObjectProtocol.self)
	}

	private func isSelector(aSelector: Selector, fromProtocol aProtocol: Protocol) -> Bool {
		let requiredMethod = [false, false, true, true]
		let instanceMethod = [false, true, false, true]

		for callVariant in 0 ..< 4 {
			let methodDescription = protocol_getMethodDescription(aProtocol,
			                                                      aSelector,
			                                                      requiredMethod[callVariant],
			                                                      instanceMethod[callVariant])
			if methodDescription.types != nil, methodDescription.name != nil {
				return true
			}
		}

		return false
	}
}
