//
//  AirMapPermitDecisionNavController.swift
//  AirMapSDK
//
//  Created by Adolfo Martinelli on 7/20/16.
//  Copyright © 2016 AirMap, Inc. All rights reserved.
//

protocol AirMapPermitDecisionFlowDelegate {
	func decisionFlowDidSelectPermit(permit: AirMapAvailablePermit, requiredBy advisory: AirMapStatusAdvisory, with customProperties: [AirMapPilotPermitCustomProperty])
}

class AirMapPermitDecisionNavController: UINavigationController {

	var permitDecisionFlowDelegate: AirMapPermitDecisionFlowDelegate!
	
	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return .LightContent
	}
	
}
