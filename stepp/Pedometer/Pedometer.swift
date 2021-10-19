//
//  Pedometer.swift
//  stepp
//
//  Created by Giorgy null on 17/10/21.
//

import Foundation
import CoreMotion

protocol StepCounter {
  func getStepCount(from: Date, to: Date, onFinish: @escaping (NSNumber?, Error?) -> Void)
}

class Pedometer: StepCounter {
  enum PedometerError: Error {
    case noPermission
  }
  private let cmPedometer: CMPedometer = CMPedometer()

  private func hasPermission() -> Bool {
    return CMPedometer.isStepCountingAvailable() && CMPedometer.isPedometerEventTrackingAvailable()
  }

  func getStepCount(from: Date, to: Date, onFinish: @escaping (NSNumber?, Error?) -> Void) {
    guard hasPermission() else {
      onFinish(nil, PedometerError.noPermission)
      return
    }
    cmPedometer.queryPedometerData(from: from, to: to) { (data, error) in
      guard let data = data, error == nil else {
        onFinish(nil, error)
        return
      }
      DispatchQueue.main.async {
        onFinish(data.numberOfSteps, nil)
      }
    }
    cmPedometer.startUpdates(from: from) { (data, error) in
      guard let data = data, error == nil else {
        onFinish(nil, error)
        return
      }
      DispatchQueue.main.async {
        onFinish(data.numberOfSteps, nil)
      }
    }
  }
}
