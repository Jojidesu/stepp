//
//  ContentView.swift
//  stepp
//
//  Created by Giorgy null on 17/10/21.
//

import SwiftUI

struct ContentView: View {
  let pedometer = Pedometer()
  let notificationManager = NotificationManager()

  @State var todayStep: Int = 0
  @State var targetStep: Int = 10000
  @State var progress: Float = 0
  @State var name: String = "Giorgy"
  @State var encouragement: String = "You're doing great"
  @State var calendarDayChangedCount: Int = 0

  enum Encouragement: String {
    case getStarted = "You need to get moving!"
    case continueDoingIt = "You're doing great! Continue!"
    case almostThere = "Almost there! you're awesome!"
    case youAreDone = "It's done! Congrats!"
  }

  func getEncouragement(from progress: Float) -> Encouragement {
    switch progress {
    case 0.0:
      return .getStarted
    case 0.0..<0.5:
      return .continueDoingIt
    case 0.5..<1:
      return .almostThere
    case 1:
      return .youAreDone
    default:
      return .youAreDone
    }
  }

  var body: some View {
    NavigationView {
      VStack(alignment: .center , spacing: 16) {
        Text("Hi there ")
          .font(.title2)
          + Text("\(name)").font(.title2).foregroundColor(.green)
        Text(getEncouragement(from: progress).rawValue)
          .font(.body)
        CircularProgressBar(progress: $progress)
          .frame(
            width: UIWindow().screen.bounds.width,
            height: UIWindow().screen.bounds.width,
            alignment: .center
          )
        NavigationLink("\(todayStep) / \(targetStep)", destination: ChangeLimitView(dailyStepGoal: $targetStep).onChange(of: targetStep, perform: { value in
          recalculateProgress()
        }))
          .font(.body)
          .foregroundColor(.green)
        Spacer()
      }
    }.onAppear(perform: {
      fetchData()
    }).onReceive(NotificationCenter.default.publisher(for: .NSCalendarDayChanged).receive(on: RunLoop.main), perform: { _ in
      calendarDayChangedCount += 1
      fetchData()
    })
  }

  func recalculateProgress() {
    let currentProgress = Float(todayStep)/Float(targetStep)
    progress = Float.minimum(currentProgress, 1)
  }

  func fetchData() {
    let startDate = Calendar.current.startOfDay(for: Date())
    guard let endDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate) else { return }
    pedometer.getStepCount(from: startDate, to: endDate) { steps, error  in
      guard let steps = steps , error == nil else { return }
      todayStep = steps.intValue
      recalculateProgress()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
    }
}
