//
//  Theme.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/6/22.
//

import Foundation
import UIKit

class Theme {
    static func navigationBarColors(background: UIColor?, titleColor: UIColor? = nil, tintColor: UIColor? = nil) {
        
        let navigationApperance = UINavigationBarAppearance()
        navigationApperance.configureWithOpaqueBackground()
        navigationApperance.backgroundColor = background ?? .clear
        
        navigationApperance.titleTextAttributes = [.foregroundColor: titleColor ?? .black]
        navigationApperance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .black]
        
        UINavigationBar.appearance().standardAppearance = navigationApperance
        UINavigationBar.appearance().compactAppearance = navigationApperance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationApperance
        
        UINavigationBar.appearance().tintColor = tintColor ?? titleColor ?? .black
    }
    
}
