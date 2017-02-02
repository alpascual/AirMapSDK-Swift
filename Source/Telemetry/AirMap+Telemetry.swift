//
//  AirMap+Telemetry.swift
//  AirMapSDK
//
//  Created by Adolfo Martinelli on 6/28/16.
//  Copyright © 2016 AirMap, Inc. All rights reserved.
//

import ProtocolBuffers

private typealias AirMapTelemetryServices = AirMap
extension AirMapTelemetryServices {
	
	public enum TelemetryError: ErrorType {
		case InvalidCredentials
		case InvalidFlight
	}
	
	/**
	
	Send aircraft position telemetry data to AirMap
	
	- parameter flight: The `AirMapFlight` to report telemetry data for
	- parameter coordinate: The latitude & longitude of the aircraft
	- parameter altitudeAgl: The altitude of the aircraft in meters above ground
	- parameter altitudeMsl: The altitude of the aircraft in meters above Mean Sea Level
	- parameter horizontalAccuracy: Optional. The horizontal dilution of precision (HDOP)
	
	*/
	public static func sendTelemetryData(flight: AirMapFlight, coordinate: CLLocationCoordinate2D, altitudeAgl: Float?, altitudeMsl: Float?, horizontalAccuracy: Float? = nil) throws {
		
		try canSendTelemetryFor(flight)
		
		let position = Airmap.Telemetry.Position.Builder()
		position.setTimestamp(NSDate().timeIntervalSince1970.milliseconds)
		position.setLatitude(coordinate.latitude)
		position.setLongitude(coordinate.longitude)
		if let agl = altitudeAgl {
			position.setAltitudeAgl(agl)
		}
		if let msl = altitudeMsl {
			position.setAltitudeMsl(msl)
		}
		if let accuracy = horizontalAccuracy {
			position.setHorizontalAccuracy(accuracy)
		}
		let positionMessage = try position.build()
		telemetryClient.sendTelemetry(flight, message: positionMessage)
	}
	
	/**
	
	Send aircraft speed telemetry data to AirMap
	
	- parameter flight: The `AirMapFlight` to report telemetry data for
	- parameter velocity: A tuple of axis velocities (X,Y,Z) using the N-E-D (North-East-Down) coordinate system
	
	*/
	public static func sendTelemetryData(flight: AirMapFlight, velocity: (x: Float, y: Float, z: Float)) throws {
		
		try canSendTelemetryFor(flight)
		
		let speed = Airmap.Telemetry.Speed.Builder()
		speed.setTimestamp(NSDate().timeIntervalSince1970.milliseconds)
		speed.setVelocityX(velocity.x)
		speed.setVelocityY(velocity.y)
		speed.setVelocityZ(velocity.z)
		
		let speedMessage = try speed.build()
		telemetryClient.sendTelemetry(flight, message: speedMessage)
	}
	
	/**
	
	Send aircraft attitude telemetry data to AirMap
	
	- parameter flight: The `AirMapFlight` to report telemetry data for
	- parameter yaw: The yaw angle in degrees measured from True North (0 <= x < 360)
	- parameter pitch: The angle (up-down tilt) in degrees up or down relative to the forward horizon (-180 < x <= 180)
	- parameter roll: The angle (left-right tilt) in degrees (-180 < x <= 180)
	
	*/
	public static func sendTelemetryData(flight: AirMapFlight, yaw: Float, pitch: Float, roll: Float) throws {
		
		try canSendTelemetryFor(flight)
		
		let attitude = Airmap.Telemetry.Attitude.Builder()
		attitude.setTimestamp(NSDate().timeIntervalSince1970.milliseconds)
		attitude.setYaw(yaw)
		attitude.setPitch(pitch)
		attitude.setRoll(roll)
		
		let attitudeMessage = try attitude.build()
		telemetryClient.sendTelemetry(flight, message: attitudeMessage)
	}
	
	/**
	
	Send barometer telemetry data to AirMap
	
	- parameter flight: The `AirMapFlight` to report telemetry data for
	- parameter baro: The barometric pressure in hPa (~1000)
	
	*/
	public static func sendTelemetryData(flight: AirMapFlight, baro: Float) throws {
		
		try canSendTelemetryFor(flight)
		
		let barometer = Airmap.Telemetry.Barometer.Builder()
		barometer.setTimestamp(NSDate().timeIntervalSince1970.milliseconds)
		barometer.setPressure(baro)

		let barometerMessage = try barometer.build()
		telemetryClient.sendTelemetry(flight, message: barometerMessage)
	}
	
	/**
	
	Verify the user can send telemetry data
	
	*/
	private static func canSendTelemetryFor(flight: AirMapFlight) throws {
	
		guard AirMap.hasValidCredentials() else {
			logger.error(self, "Please login before sending telemetry data.")
			throw TelemetryError.InvalidCredentials
		}
		
		guard flight.flightId != nil else {
			logger.error(self, "Flight must exist before sending telemetry data. Call \(#selector(AirMap.createFlight(flight:handler:))) before sending data.")
			throw TelemetryError.InvalidFlight
		}
	}
	
}
