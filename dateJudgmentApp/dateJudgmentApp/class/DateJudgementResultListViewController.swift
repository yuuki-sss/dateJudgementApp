//
//  ViewController.swift
//  dateJudgmentApp
//
//  Created by 徳永勇希 on 2025/01/11.
//

import UIKit
import RealmSwift

class DateJudgementResultListViewController: UIViewController {
    // MARK: 部品
    @IBOutlet weak var startedAtTextFeild: UITextField!
    @IBOutlet weak var endAtTextFeild: UITextField!
    @IBOutlet weak var tableView: UITableView!
    // MARK: 変数
    var dateJudgementResultDataList: [DateJudgementResultData] = []
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.startedAtTextFeild.delegate = self
        self.endAtTextFeild.delegate = self
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // cellの登録
        self.tableView.register(DateJudgementResultTableViewCell.nib(), forCellReuseIdentifier: DateJudgementResultTableViewCell.identifier)
        //登録されたデータを取得
        self.dateJudgementResultDataList = Array(realm.objects(DateJudgementResultData.self))
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    // MARK: アクション
    @IBAction func dateJudgementbButtnTapped(_ sender: Any) {
        //バリデーション
        if (Validation.validateRequiredDate(started: startedAtTextFeild.text ?? "", endAt: endAtTextFeild.text ?? "")) {
            self.alertValidation()
            return
            
        }
        //判定時刻
        let judgementDate = self.getjudgementDate()
        
        let dateJudgementResultData:DateJudgementResultData = DateJudgementResultData()
        dateJudgementResultData.judgementDate = String(judgementDate)
        dateJudgementResultData.startedAt = self.startedAtTextFeild.text ?? ""
        dateJudgementResultData.endAt = self.endAtTextFeild.text ?? ""
        
        let date = (Int(self.startedAtTextFeild.text ?? "") ?? 0, Int(self.endAtTextFeild.text ?? "") ?? 0)
        switch date {
        case (let startedAt, let endAt) where startedAt == endAt && startedAt <= judgementDate && judgementDate <= endAt:
            dateJudgementResultData.result = true
            break
            
        case (let startedAt, let endAt) where startedAt < endAt && startedAt <= judgementDate && judgementDate < endAt:
            dateJudgementResultData.result = true
            break
            
        case (let startedAt, let endAt) where startedAt > endAt && startedAt <= judgementDate && judgementDate < endAt + 24:
            dateJudgementResultData.result = true
            break
            
        default:
            break
            
        }
        //入力されたデータを登録
        try! realm.write{
            realm.add(dateJudgementResultData)
            
        }
        //登録されたデータを取得
        self.dateJudgementResultDataList = Array(realm.objects(DateJudgementResultData.self))
        self.tableView.reloadData()
        self.startedAtTextFeild.text = ""
        self.endAtTextFeild.text = ""
        
    }
    
    // MARK: 各メソッド
    private func getjudgementDate() -> Int{
        let date = Date()
        let dateFormatter = DateFormatter()
        // 時だけ取得
        dateFormatter.dateFormat = "HH"
        let judgementDate = Int(dateFormatter.string(from: date)) ?? 0
        return judgementDate
        
    }
    
    private func alertValidation() {
        let alert: UIAlertController = UIAlertController(title: "開始時刻と終了時刻はどちらも入力してください。", message: "", preferredStyle: .alert)
        //OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: {
            //ボタンが押された時の処理
            (action: UIAlertAction) -> Void in
        })
        //UIAlertControllerにActionを追加
        alert.addAction(defaultAction)
        //Alertを表示
        present(alert, animated: true, completion: nil)
        
    }
}

// MARK: エクステンション
extension DateJudgementResultListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dateJudgementResultDataList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: DateJudgementResultTableViewCell.identifier, for: indexPath) as! DateJudgementResultTableViewCell
        // セルに表示する値を設定する
        cell.setupDateJudgementResultInfo(locationInfo: self.dateJudgementResultDataList[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 削除するTodoオブジェクトを取得
            let dateJudgementResultData = self.dateJudgementResultDataList[indexPath.row]
            // Realmから削除
            try! realm.write {
                realm.delete(dateJudgementResultData)
            }
            // TableViewから削除
            self.dateJudgementResultDataList = Array(realm.objects(DateJudgementResultData.self))
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
}
extension DateJudgementResultListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}


