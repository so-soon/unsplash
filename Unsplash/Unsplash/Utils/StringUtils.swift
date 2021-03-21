//
//  StringUtils.swift
//  Unsplash
//
//  Created by Randy on 2021/03/21.
//

import Foundation

extension Optional where Wrapped == String{
    func orEmpty() -> String {
        return self ?? ""
    }
}
