//
//  Validation.swift
//  dateJudgmentApp
//
//  Created by 徳永勇希 on 2025/01/12.
//

import Foundation
import UIKit

class Validation {
    //開始日時と終了日時の必須項目エラー
    static func validateRequiredDate(started: String, endAt: String) -> Bool {
        if (started == "" && endAt == "") {
            return true
            
        }
        return false
        
    }
}
