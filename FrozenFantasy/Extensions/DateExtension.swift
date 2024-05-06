//
//  DateExtension.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 06.05.2024.
//

import Foundation

extension Date {
    private static let simpleDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()
    
    var simpleDateString: String {
        Date.simpleDateFormatter.string(from: self)
    }
}
