//
//  CircularProgressBar.swift
//  stepp
//
//  Created by Giorgy null on 17/10/21.
//

import SwiftUI

struct CircularProgressBar: View {
  @Binding var progress: Float

  var body: some View {
    ZStack {
      Circle()
        .stroke(lineWidth: 8.0)
        .opacity(0.3)
        .foregroundColor(Color.green)

      Circle()
        .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
        .stroke(style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round))
        .foregroundColor(Color.green)
        .rotationEffect(Angle(degrees: 270.0))
      
      Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
        .font(.title2)
        .bold()
    }.padding(16)
  }
}
