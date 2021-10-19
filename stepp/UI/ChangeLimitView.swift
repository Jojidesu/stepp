//
//  ChangeLimitView.swift
//  stepp
//
//  Created by Giorgy null on 18/10/21.
//

import SwiftUI

struct ChangeLimitView: View {
  @Binding var dailyStepGoal: Int
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("Your daily step goal").font(.title2)
      TextField("10000", value: $dailyStepGoal, formatter: NumberFormatter())
        .font(.body)
        .foregroundColor(.green)
        .textFieldStyle(RoundedBorderTextFieldStyle())
      Spacer()
    }.padding(16)
  }
}

struct TestView: View {
  @State var stepGoal: Int = 10000
  var body: some View {
    ChangeLimitView(dailyStepGoal: $stepGoal)
  }
}

struct ChangeLimitView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
