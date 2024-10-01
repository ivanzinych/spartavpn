//
//  TextFieldView.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 25.09.2024.
//

import UIKit

protocol TextFieldViewDelegate: AnyObject {
    func textFieldViewDidBeginEditing(_ view: TextFieldView)
    func textFieldViewDidValueChanged(_ view: TextFieldView)
}

class TextFieldView: UIView {
    
    weak var delegate: TextFieldViewDelegate?
    
    private(set) lazy var textField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.borderStyle = .none
        textField.font = AppFont.regular14
        textField.textInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        textField.tintColor = .white
        textField.textColor = .white
        textField.delegate = self
        textField.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
        
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .textFieldBackground
        
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.left.right.bottom.top.equalToSuperview()
        }
    }
    
    @objc
    private func valueChanged() {
        delegate?.textFieldViewDidValueChanged(self)
    }
}

extension TextFieldView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldViewDidBeginEditing(self)
        layer.borderColor = UIColor.appColor(.colorTwo).cgColor
        layer.borderWidth = 1
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        layer.borderWidth = 0
    }
}
