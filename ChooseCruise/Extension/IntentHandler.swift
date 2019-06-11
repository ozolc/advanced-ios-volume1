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
        <#code#>
    }
    
    func handle(intent: INRequestRideIntent, completion: @escaping (INRequestRideIntentResponse) -> Void) {
        <#code#>
    }
    
    func handle(intent: INGetRideStatusIntent, completion: @escaping (INGetRideStatusIntentResponse) -> Void) {
        let result = INGetRideStatusIntentResponse(code: .success, userActivity: nil)
        completion(result)
    }
    
    func startSendingUpdates(for intent: INGetRideStatusIntent, to observer: INGetRideStatusIntentResponseObserver) {
        <#code#>
    }
    
    func stopSendingUpdates(for intent: INGetRideStatusIntent) {
        <#code#>
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
    }
    
    func resolveDropOffLocation(for intent: INRequestRideIntent, with completion: @escaping (INPlacemarkResolutionResult) -> Void) {
    }
    
    
}
