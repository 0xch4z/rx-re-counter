//
//  AppReducer.swift
//  rxrecounter
//
//  Created by Charlie Kenney on 2/5/18.
//  Copyright © 2018 Charlie Kenney. All rights reserved.
//

import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
  var state = state ?? AppState.initialState
  
  switch action {
  case let incrementCountAction as IncrementCount:
    state.count = state.count + incrementCountAction.factor
    break
  case let decrementCountAction as DecrementCount:
    state.count = state.count - decrementCountAction.factor
    break
  default:
    break
  }
  
  return state
}
