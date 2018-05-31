//
//  Date.swift
//  FkGallery
//
//  Created by bogdan on 2018-05-31.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import Foundation

extension Date {
    private struct Item {
        let multi: String
        let single: String
        let last: String
        let value: Int?
    }
    
    private var components: DateComponents {
        return Calendar.current.dateComponents(
            [.minute, .hour, .day, .weekOfYear, .month, .year, .second],
            from: Calendar.current.date(byAdding: .second, value: 1, to: Date())!,
            to: self
        )
    }
    
    private func prepareItems(doSeconds: Bool = false) -> [Item] {
        var items = [
            Item(multi: "years ago", single: "1 year ago", last: "Last year", value: components.year),
            Item(multi: "months ago", single: "1 month ago", last: "Last month", value: components.month),
            Item(multi: "weeks ago", single: "1 week ago", last: "Last week", value: components.weekOfYear),
            Item(multi: "days ago", single: "1 day ago", last: "Last day", value: components.day),
            Item(multi: "minutes ago", single: "1 minute ago", last: "Last minute", value: components.minute)
        ]
        
        if doSeconds {
            items.append(Item(multi: "seconds ago", single: "Just now", last: "Last second", value: components.second))
        }
        
        return items
    }
    
    public func timeAgo(doSeconds: Bool = false) -> String {
        let numericDates = false
        let items = prepareItems(doSeconds: doSeconds)
        
        for item in items {
            let value = item.value != nil ? abs(item.value!) : item.value
            switch (value, numericDates) {
            case let (.some(step), _) where step == 0:
                continue
            case let (.some(step), true) where step == 1:
                return item.last
            case let (.some(step), false) where step == 1:
                return item.single
            case let (.some(step), _):
                return String(step) + " " + item.multi
            default:
                continue
            }
        }
        
        return "Just now"
    }
}

