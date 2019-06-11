//
//  IntentHandler.swift
//  Extension
//
//  Created by Maksim Nosov on 11/06/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Intents
import UIKit

class IntentHandler: INExtension, INRidesharingDomainHandling {
    func handle(intent: INListRideOptionsIntent, completion: @escaping (INListRideOptionsIntentResponse) -> Void) {
        let result = INListRideOptionsIntentResponse(code: .success, userActivity: nil)
        
        let mini = INRideOption(name: "Mini Cooper", estimatedPickupDate: Date(timeIntervalSinceNow: 1000))
        let accord = INRideOption(name: "Honda Accord", estimatedPickupDate: Date(timeIntervalSinceNow: 800))
        let ferrari = INRideOption(name: "Ferrari F430", estimatedPickupDate: Date(timeIntervalSinceNow: 300))
        ferrari.disclaimerMessage = "This is bad for the environment"
        
        result.expirationDate = Date(timeIntervalSinceNow: 3600)
        result.rideOptions = [mini, accord, ferrari]
        
        completion(result)
    }
    
    func handle(intent: INRequestRideIntent, completion: @escaping (INRequestRideIntentResponse) -> Void) {
        let result = INRequestRideIntentResponse(code: .success, userActivity: nil)
        
        let status = INRideStatus()
        
        // this is our internal value that identifies the ride uniquely in our back-end system
        status.rideIdentifier = "abc123"
        
        // give it the pick up and drop off location we already agreed with the user
        status.pickupLocation = intent.pickupLocation
        status.dropOffLocation = intent.dropOffLocation
        
        // mark it as confirmed – we will deliver a ride
        status.phase = INRidePhase.confirmed
        
        // say we'll be there in 15 minutes
        status.estimatedPickupDate = Date(timeIntervalSinceNow: 900)
        
        // create a new vehicle and configure it fully
        let vehicle = INRideVehicle()
        
        // workaround: load the car image into UIImage, convert that into PNG data, then create an INImage out of that
        let image = UIImage(named: "car")!
        let data = image.pngData()!
        vehicle.mapAnnotationImage = INImage(imageData: data)
        
        // set the vehicle's current location to wherever the user wants to go – this ought to at least place it a little way away for testing purposes
        vehicle.location = intent.dropOffLocation!.location
        
        // now that we have configured the vehicle fully, assign it all at once to status.vehicle
        status.vehicle = vehicle
        
        // attach our finished INRideStatus object to the result
        result.rideStatus = status
        
        // and send it back
        completion(result)
    }
    
    func handle(intent: INGetRideStatusIntent, completion: @escaping (INGetRideStatusIntentResponse) -> Void) {
        let result = INGetRideStatusIntentResponse(code: .success, userActivity: nil)
        completion(result)
    }
    
    func startSendingUpdates(for intent: INGetRideStatusIntent, to observer: INGetRideStatusIntentResponseObserver) {
        
    }
    
    func stopSendingUpdates(for intent: INGetRideStatusIntent) {
        
    }
    
    func handle(cancelRide intent: INCancelRideIntent, completion: @escaping (INCancelRideIntentResponse) -> Void) {
        let result = INCancelRideIntentResponse(code: .success, userActivity: nil)
        completion(result)
    }
    
    func handle(sendRideFeedback sendRideFeedbackintent: INSendRideFeedbackIntent, completion: @escaping (INSendRideFeedbackIntentResponse) -> Void) {
        let result = INSendRideFeedbackIntentResponse(code: .success, userActivity: nil)
        completion(result)
    }
    
    func resolvePickupLocation(for intent: INRequestRideIntent, with completion: @escaping (INPlacemarkResolutionResult) -> Void) {
        let result: INPlacemarkResolutionResult
        
        if let requestedLocation = intent.pickupLocation {
            // we have a valid pick up location – return success!
            result = INPlacemarkResolutionResult.success(with: requestedLocation)
        } else {
            // no pick up location yet; mark this as outstanding
            result = INPlacemarkResolutionResult.needsValue()
        }
        
        completion(result)
    }
    
    func resolveDropOffLocation(for intent: INRequestRideIntent, with completion: @escaping (INPlacemarkResolutionResult) -> Void) {
        let result: INPlacemarkResolutionResult
        
        if let requestedLocation = intent.dropOffLocation {
            result = INPlacemarkResolutionResult.success(with: requestedLocation)
        } else {
            result = INPlacemarkResolutionResult.needsValue()
        }
        
        completion(result)
    }
    
    
}
