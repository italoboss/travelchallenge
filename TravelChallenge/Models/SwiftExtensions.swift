//
//  SwiftExtensions.swift
//  TravelChallenge
//
//  Created by Karina Paula on 30/08/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

extension Array where Element: Equatable{
    /// Returns an array with only distinct elements
    ///
    /// - Parameter elements: Array of equatable elements
    /// - Returns: a an array with only distinct values from elements
    func distinct(elements: [Element] = []) -> [Element] {
        let itens = elements.count == 0 ? self : elements
        return itens.reduce([], {
            return $0.contains($1) ? $0 : $0 + [$1]
        })
    }
}
