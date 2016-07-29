//
//  Types.swift
//  ViewModel
//
//  Created by Guido Marucci Blas on 7/11/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit
import Foundation

protocol ViewType {
 
    var renderedView: UIView { get }
    
}

extension ViewType where Self: UIView {
    
    var renderedView: UIView { return self }
    
}

protocol NibViewLoader {
    
    static func loadFromNib() -> Self?
    
}

extension NibViewLoader where Self: UIView {
    
    static func loadFromNib() -> Self? {
        let bundle = Bundle(for: Self.self)
        return (String(self) as NSString).components(separatedBy: ".").first.flatMap { nibName in
            let nib = bundle.loadNibNamed(nibName, owner: bundle, options: nil)?.first
            return nib as? Self
        }
    }
    
}

struct ValidableTextField {
    
    typealias Validator = (String) -> Bool
    typealias ColorMapper = (Bool) -> UIColor
    
    
    static func defaultColorMapper(valid: Bool) -> UIColor {
        return (valid) ? .black() : .red()
    }
    
    var text: String = ""
    var isValid: Bool { return _validator(text) }
    var borderColor: UIColor { return _colorMapper(isValid) }
    
    private let _validator: Validator
    private let _colorMapper: ColorMapper
    
    init(validator: Validator, colorMapper: ColorMapper = ValidableTextField.defaultColorMapper) {
        _validator = validator
        _colorMapper = colorMapper
    }
    
}

protocol ViewModelType {
    
}

protocol ControllerType {
    
    
    associatedtype View: ViewType
    associatedtype ViewModel: ViewModelType
    
    var typedView: View? { get }
    var viewModel: ViewModel { get }
    
    init(viewModel: ViewModel, viewFactory: () -> View?)
    
    func bind()
    
}
