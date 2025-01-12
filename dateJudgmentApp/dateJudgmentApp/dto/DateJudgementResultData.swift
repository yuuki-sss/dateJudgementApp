//
//  DateJudgementResultData.swift
//  dateJudgmentApp
//
//  Created by 徳永勇希 on 2025/01/11.
//

import Foundation
import RealmSwift

class DateJudgementResultData: Object {
    @objc dynamic var judgementDate: String = ""
    @objc dynamic var startedAt: String = ""
    @objc dynamic var endAt: String = ""
    @objc dynamic var result: Bool = false
    
}
