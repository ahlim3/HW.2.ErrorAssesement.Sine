//
//  HW_2_ErrorAssesementApp.swift
//  Shared
//
//  Created by Anthony Lim on 2/5/21.
//

import SwiftUI

@main
struct HW_2_ErrorAssesementApp: App {
    
    @StateObject var plotDataModel = PlotDataClass(fromLine: true)
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .environmentObject(plotDataModel)
                    .tabItem {
                        Text("Plot")
                    }
                TextView()
                    .environmentObject(plotDataModel)
                    .tabItem {
                        Text("Text")
                    }
                            
                            
            }
            
        }
    }
}
