//
//  Calendar_appApp.swift
//  Calendar app
//
//  Created by 유선영 on 2022/02/25.
//

import SwiftUI

@main
struct Calendar_appApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(listViewModel)
            
        }
    }
}
