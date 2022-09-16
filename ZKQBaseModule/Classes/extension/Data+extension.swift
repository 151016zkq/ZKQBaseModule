//
//  Data+extension.swift
//  SmartPicc
//
//  Created by 张凯强 on 2021/1/25.
//  Copyright © 2021 picclife. All rights reserved.
//

import Foundation
public extension Data {
    func asDict() -> [String: Any]? {
        if let dic = try? JSONSerialization.jsonObject(with: self,
                           options: .mutableContainers) as? [String : Any] {

            return dic
        }
        return nil

    }
}
