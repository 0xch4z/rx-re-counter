//
//  MainController.swift
//  rxrecounter
//
//  Created by Charlie Kenney on 2/5/18.
//  Copyright © 2018 Charlie Kenney. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReSwift
import ReRxSwift
import Stevia

class MainController: UIViewController {
  
  fileprivate let disposeBag = DisposeBag()
  fileprivate var countLabel: UILabel!
  fileprivate var incrementButton: UIButton!
  fileprivate var decrementButton: UIButton!
  
  struct Props {
    let count: Int
  }
  
  struct Actions {
    let incrementCount: (Int) -> Void
    let decrementCount: (Int) -> Void
  }
  
  fileprivate let connection = Connection(
    store: mainStore,
    mapStateToProps: mapStateToProps,
    mapDispatchToActions: mapDispatchToActions
  )
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupCountLabel()
    setupIncrementButton()
    setupDecrementButton()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    connection.connect()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    
    connection.disconnect()
  }
  
}

// MARK: - mapStateToProps

fileprivate let mapStateToProps = { (appState: AppState) in
  return MainController.Props(
    count: appState.count
  )
}

// MARK: - mapDispatchToProps

fileprivate let mapDispatchToActions = { (dispatch: @escaping DispatchFunction) in
  return MainController.Actions(
    incrementCount: { dispatch(IncrementCount(by: $0)) },
    decrementCount: { dispatch(DecrementCount(by: $0)) }
  )
}

// MARK: - ViewPreperations

fileprivate extension MainController {
  
  func setupView() {
    view.backgroundColor = .white
  }
  
  func setupCountLabel() {
    countLabel = UILabel()
    countLabel.text = "0"
    countLabel.font = UIFont(name: "Helvetica Neue", size: 100)
    countLabel.textAlignment = .center
    countLabel.translatesAutoresizingMaskIntoConstraints = false
    
    connection.bind(\Props.count, to: countLabel.rx.text, mapping: { String($0) })
    
    view.addSubview(countLabel)
    countLabel.height(100).width(250).top(25%).centerHorizontally()
  }
  
  func setupIncrementButton() {
    incrementButton = UIButton()
    incrementButton.setTitle("Increment", for: .normal)
    incrementButton.setTitleColor(.black, for: .normal)
    incrementButton.translatesAutoresizingMaskIntoConstraints = false
    
    incrementButton.rx.tap
      .subscribe(onNext: { [unowned self] _ in
        self.connection.actions.incrementCount(1)
      })
      .disposed(by: disposeBag)
    
    view.addSubview(incrementButton)
    incrementButton.height(35).width(200).centerHorizontally()
    incrementButton.Top == countLabel.Bottom + 50
  }
  
  func setupDecrementButton() {
    decrementButton = UIButton()
    decrementButton.setTitle("Decrement", for: .normal)
    decrementButton.setTitleColor(.black, for: .normal)
    decrementButton.translatesAutoresizingMaskIntoConstraints = false
    
    decrementButton.rx.tap
      .subscribe(onNext: { [unowned self] _ in
        self.connection.actions.decrementCount(1)
      })
      .disposed(by: disposeBag)
    
    view.addSubview(decrementButton)
    decrementButton.height(35).width(200).centerHorizontally()
    decrementButton.Top == incrementButton.Bottom + 10
  }
  
}
