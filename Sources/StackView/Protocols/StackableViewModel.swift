//
//  StackableViewModel.swift
//  
//
//  Created by Max Gribov on 26.11.2022.
//

import Foundation

public protocol StackableViewModel: ViewModel where V: StackableView, V.VM == Self {
    
    var stackViewModel: StackViewModel? { get set }
}
