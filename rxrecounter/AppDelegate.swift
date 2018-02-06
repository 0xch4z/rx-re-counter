//
//  AppDelegate.swift
//  rxrecounter
//
//  Created by Charlie Kenney on 2/5/18.
//  Copyright © 2018 Charlie Kenney. All rights reserved.
//

import UIKit
import RxSwift
import ReSwift

let mainStore = Store<AppState>(
  reducer: appReducer,
  state: nil
)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func applicationDidFinishLaunching(_ application: UIApplication) {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = MainController()
    window?.makeKeyAndVisible()
  }

}
