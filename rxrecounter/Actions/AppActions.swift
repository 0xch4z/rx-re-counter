//
//  AppActions.swift
//  rxrecounter
//
//  Created by Charlie Kenney on 2/5/18.
//  Copyright © 2018 Charlie Kenney. All rights reserved.
//

import ReSwift

struct IncrementCount: Action {
  let factor: Int
  
  init(by factor: Int = 1) {
    self.factor = factor
  }
}

struct DecrementCount: Action {
  let factor: Int
  
  init(by factor: Int = 1) {
    self.factor = factor
  }
}
