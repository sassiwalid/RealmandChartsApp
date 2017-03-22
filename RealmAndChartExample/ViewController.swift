//
//  ViewController.swift
//  RealmAndChartExample
//
//  Created by Walid Sassi on 22/03/2017.
//  Copyright © 2017 Walid Sassi. All rights reserved.
//

import UIKit
import Charts
import RealmSwift
class ViewController: UIViewController {

  @IBOutlet weak var tfValue: UITextField!
  @IBOutlet weak var barView: BarChartView!
  @IBAction func btnAddTapped(_ sender: Any) {
    if let value = tfValue.text , value != "" {
      let visitorCount = VisitorCount()
      visitorCount.count = (NumberFormatter().number(from: value)?.intValue)!
      visitorCount.save()
      tfValue.text = ""
    }
    updateChartWithData()
  }
  
  func updateChartWithData() {
    var dataEntries: [BarChartDataEntry] = []
    let visitorCounts = getVisitorCountsFromDatabase()
    for i in 0..<visitorCounts.count {
      let dataEntry = BarChartDataEntry(x: Double(i), y: Double(visitorCounts[i].count))
      dataEntries.append(dataEntry)
    }
    let chartDataSet = BarChartDataSet(values: dataEntries, label: "Visitor count")
    let chartData = BarChartData(dataSet: chartDataSet)
    barView.data = chartData
  }
  
  func getVisitorCountsFromDatabase() -> Results<VisitorCount> {
    do {
      let realm = try Realm()
      return realm.objects(VisitorCount.self)
    } catch let error as NSError {
      fatalError(error.localizedDescription)
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    updateChartWithData()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

