//
//  AppStepper.swift
//  KnowYourCountry
//
//  Created by Mateo Doslic on 12.04.25.
//

import RxFlow
import RxSwift
import RxCocoa

class AppStepper: Stepper {
    let steps = PublishRelay<Step>()
    
    var initialStep: Step {
        return AppStep.home
    }
}
