//
//  MasterTabView.swift
//  stepp
//
//  Created by Jimmy Ngaditowo on 19/10/21.
//

import SwiftUI

struct MasterTabView: View {
    @State private var selection = 0
    init() {
            UITabBar.appearance().barTintColor = UIColor.black
        }
    
    var body: some View {
        TabView {
            TabView1()
                .tabItem {
                    Text ("Detail")
                }
                .tag(0)
            TabView2()
                .tabItem {
                    Text ("History")
                }
                .tag(1)
        }
        .accentColor(.green)
        .font(.body)
    }
}

struct TabView1: View {
    var body: some View {
        ContentView()
    }
}

struct TabView2: View {
    var body: some View {
        Text ("Step History")
    }
}

struct MasterTabView_Previews: PreviewProvider {
    static var previews: some View {
      MasterTabView()
    }
}
