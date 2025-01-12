//
//  DateJudgementResultTableViewCell.swift
//  dateJudgmentApp
//
//  Created by 徳永勇希 on 2025/01/11.
//

import UIKit

class DateJudgementResultTableViewCell: UITableViewCell {
    // MARK: 部品
    @IBOutlet weak var judgementDateLbl: UILabel!
    @IBOutlet weak var startedAtlbl: UILabel!
    @IBOutlet weak var endAtLbl: UILabel!
    @IBOutlet weak var resultLbl: UILabel!
    // MARK: 変数
    static let identifier = "DateJudgementResultTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: 各メソッド
    static func nib() -> UINib {
        return UINib(nibName: "DateJudgementResultTableViewCell", bundle: nil)
        
    }
    
    func setupDateJudgementResultInfo(locationInfo:DateJudgementResultData) {
        self.judgementDateLbl.text = locationInfo.judgementDate
        self.startedAtlbl.text = locationInfo.startedAt
        self.endAtLbl.text = locationInfo.endAt
        if (locationInfo.result) {
            self.resultLbl.text = "判定日時は開始日時と終了日時の範囲内です。"
            
        } else {
            self.resultLbl.text = "判定日時は開始日時と終了日時の範囲外です。"
            
        }
    }
}
