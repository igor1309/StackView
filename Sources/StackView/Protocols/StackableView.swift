//
//  StackableView.swift
//  
//
//  Created by Max Gribov on 26.11.2022.
//

import SwiftUI

public protocol StackableView: View {

    associatedtype VM: StackableViewModel
    
    init(viewModel: VM)
}
