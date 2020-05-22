//
//  String+Data.swift
//  Reciplease
//
//  Created by SayajinPapuru on 10/04/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import Foundation

extension String {
    ///Converting string to data
    var data: Data? {
        guard let url = URL(string: self) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return data
    }
}
