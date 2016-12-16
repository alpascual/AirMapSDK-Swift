//
//  AirMapFlightPlanNavigationController.swift
//  AirMapSDK
//
//  Created by Adolfo Martinelli on 7/18/16.
//  Copyright © 2016 AirMap, Inc. All rights reserved.
//

import RxSwift

public protocol AirMapFlightPlanDelegate: class {

	func airMapFlightPlanDidCreate(flight: AirMapFlight)
	func airMapFlightPlanDidEncounter(error: NSError)
}

public class AirMapFlightPlanNavigationController: UINavigationController {

	weak var flightPlanDelegate: AirMapFlightPlanDelegate!
	
	var mapTheme: AirMapMapTheme = .Standard
	var mapLayers: [AirMapLayerType] = []

	let flight = Variable(AirMapFlight())
	let status = Variable(nil as AirMapStatus?)
	let shareFlight = Variable(true)

	let draftPermits    = Variable([AirMapPilotPermit]())
	let existingPermits = Variable([AirMapPilotPermit]())
	let selectedPermits = Variable([(organization: AirMapOrganization, permit: AirMapAvailablePermit, pilotPermit: AirMapPilotPermit)]())
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
		navigationBar.shadowImage = UIImage()
	}

	public override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return .LightContent
	}

	@IBAction func unwindToFlightPlan(segue: UIStoryboardSegue) { /* unwind segue hook; keep */ }

}
