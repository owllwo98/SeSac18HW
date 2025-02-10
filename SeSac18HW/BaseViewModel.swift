//
//  BaseViewModel.swift
//  SevenWeek
//
//  Created by 변정훈 on 2/10/25.
//

import Foundation


protocol BaseViewModel {

    associatedtype Input
    associatedtype Output
    
    func transform()
}


