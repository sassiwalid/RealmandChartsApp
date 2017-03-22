//
//  VisitorCount.swift
//  RealmAndChartExample
//
//  Created by Walid Sassi on 22/03/2017.
//  Copyright © 2017 Walid Sassi. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class VisitorCount: Object {
  dynamic var date: Date = Date()
  dynamic var count: Int = Int(0)

func save()
{
  do {
   let realm = try Realm()
    try realm.write {
      realm.add(self)
    }
    
  } catch let error as NSError {
    fatalError(error.localizedDescription)
  }
}
}
