//
//  ViewModel.swift
//  
//
//  Created by Max Gribov on 26.11.2022.
//

import SwiftUI

public protocol ViewModel {
    
    associatedtype V: View
    
    var viewType: V.Type { get }
}
