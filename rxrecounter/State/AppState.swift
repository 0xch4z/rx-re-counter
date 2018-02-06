//
//  AppState.swift
//  rxrecounter
//
//  Created by Charlie Kenney on 2/5/18.
//  Copyright © 2018 Charlie Kenney. All rights reserved.
//

import ReSwift

struct AppState: StateType {
  
  var count: Int = 0
  
  static let initialState = AppState(count: 0)
  
}
