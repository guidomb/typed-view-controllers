//
//  BaseController.swift
//  ViewModel
//
//  Created by Guido Marucci Blas on 7/11/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit

class ControllerFactory<View: ViewType, ViewModel: ViewModelType, Controller: BaseController<View, ViewModel>> {
    
    private let _viewModelFactory: () -> ViewModel
    private let _viewFactory: () -> View?
    
    init(viewModelFactory: () -> ViewModel, viewFactory: () -> View?) {
        _viewModelFactory = viewModelFactory
        _viewFactory = viewFactory
    }
    
    final func build() -> Controller {
        return Controller(viewModel: _viewModelFactory(), viewFactory: _viewFactory)
    }
    
}

extension ControllerFactory where View: NibViewLoader {
    
    convenience init(viewModelFactory: () -> ViewModel) {
        self.init(viewModelFactory: viewModelFactory) { View.loadFromNib() }
    }
    
}

class BaseController<View: ViewType, ViewModel: ViewModelType>: UIViewController, ControllerType {
    
    lazy var typedView: View? = self._viewFactory()
    let viewModel: ViewModel
    
    private let _viewFactory: () -> View?
    
    // TODO should we use @autoclosure for viewFactory???
    required init(viewModel: ViewModel, viewFactory: () -> View?) {
        self.viewModel = viewModel
        self._viewFactory = viewFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(viewModel: ViewModel, view: View) {
        self.init(viewModel: viewModel) { return view }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    final func bind() {
        if let loadedView = self.typedView {
            bindViewModel(with: loadedView)
        }
    }
    
    final override func loadView() {
        if let loadedView = typedView {
            view = loadedView.renderedView
        } else {
            view = UIView()
            print("ERROR: View for controller '\(self.dynamicType)' could not be loaded")
        }
    }
    
    
    final override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bindViewModel(with view: View) {
        
    }
    
}

extension BaseController where View: NibViewLoader {
    
    convenience init(viewModel: ViewModel) {
        self.init(viewModel: viewModel) { View.loadFromNib() }
    }
    
}

