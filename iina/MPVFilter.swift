//
//  MPVFilter.swift
//  iina
//
//  Created by lhc on 2/9/16.
//  Copyright © 2016年 lhc. All rights reserved.
//

import Cocoa

// FIXME: can refactor using RawRepresent
class MPVFilter: NSObject {
  
  enum FilterType: String {
    case crop = "crop"
    case flip = "flip"
    case mirror = "mirror"
  }
  
  static func crop(w: Int?, h: Int?, x: Int?, y: Int?) -> MPVFilter {
    let f = MPVFilter(name: "crop", label: nil,
                      params: ["w": w?.toStr() ?? "", "h": h?.toStr() ?? "", "x": x?.toStr() ?? "", "y": y?.toStr() ?? ""])
    return f
  }
  
  static func flip() -> MPVFilter {
    return MPVFilter(name: "flip", label: nil, params: nil)
  }
  
  static func mirror() -> MPVFilter {
    return MPVFilter(name: "mirror", label: nil, params: nil)
  }
  
  var type: FilterType?
  var name: String
  var label: String?
  var params: [String: String]?
  
  var stringFormat: String {
    get {
      var str = ""
      if let label = label { str += "@\(label):" }
      str += name
      if params != nil && params!.count > 0 {
        let format = MPVFilter.formats[type!]!
        str += "="
        str += format.components(separatedBy: ":").map { params![$0] ?? "" }.joined(separator: ":")
      }
      return str
    }
  }
  
  init(name: String, label: String?, params: [String: String]?) {
    self.type = FilterType(rawValue: name)
    self.name = name
    self.label = label
    self.params = params
  }
  
  static let formats: [FilterType: String] = [
    .crop: "w:h:x:y"
  ]

}
