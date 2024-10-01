//
//  PinEntryView.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 25.09.2024.
//

import UIKit


protocol PinEntryViewDelegate: AnyObject {

    func pinEntryView(_ view: PinEntryView, didUpdateCode code: String, isFinished: Bool)
}

class PinEntryView: UIView {

    private struct Constants {
        static let defaultText = ""
    }
    
    // MARK: - Public Properties

    weak var delegate: PinEntryViewDelegate?

    /// Default number of fields
    var length: Int = 4

    /// Default spacing between fields
    var spacing: CGFloat = 24

    var entryFieldsFont: UIFont = UIFont.systemFont(ofSize: 24)

    var entryFieldsBorderColor = UIColor.black {
        didSet {
            updateViewSelectionStyle()
        }
    }

    var selectedEntryFieldsBorderColor = UIColor.blue {
        didSet {
            updateViewSelectionStyle()
        }
    }

    var selectedEntryFieldsTitleColor = UIColor.black {
        didSet {
            updateViewSelectionStyle()
        }
    }

    var entryFieldsTitleColor = UIColor.black {
        didSet {
            updateViewSelectionStyle()
        }
    }
    
    // MARK: - Private Properties

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = spacing

        return stackView
    }()

    private(set) lazy var textField: UITextField = {
        let textField = UITextField(frame: bounds)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        textField.delegate = self
        textField.isHidden = true
        textField.roundCorners(12)
        
        return textField
    }()

    private var entryViews = [PinEntryItemView]()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        initView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initView() {
        addStackView()
        addTextField()
        addButtons()

        textField.becomeFirstResponder()
    }

    // MARK: - Public Methods

    func clear() {
        textField.text = ""

        for view in entryViews {
            view.setTitle(Constants.defaultText)
            updateViewSelectionStyle(view: view, isSelected: view.tag == 1)
        }
    }

    // MARK: - Add Subviews

    private func addStackView() {
        self.addSubview(stackView)

        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func addTextField() {
        addSubview(textField)
    }

    private func addButtons() {
        for i in 0..<length {
            let itemView = PinEntryItemView()
            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.delegate = self
            itemView.tag = i + 1
            itemView.configure(with: PinEntryItemView.ButtonParams(font: entryFieldsFont, text: Constants.defaultText))
          
            entryViews.append(itemView)
            stackView.addArrangedSubview(itemView)
        }
    }

    // MARK: - Update

    private func updateViewSelectionStyle() {
        for view in entryViews {
            updateViewSelectionStyle(view: view, isSelected: view.tag == 1)
        }
    }
    
    private func updateViewSelectionStyle(view: PinEntryItemView, isSelected: Bool) {
        view.update(with: PinEntryItemView.ColorParams(borderColor: isSelected ? selectedEntryFieldsBorderColor : entryFieldsBorderColor,
                                                       titleColor: isSelected ? selectedEntryFieldsTitleColor : entryFieldsTitleColor))
    }
}

// MARK: - UITextFieldDelegate

extension PinEntryView: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return false
        }
        
        let shouldDelete = range.location == text.count - 1 && range.length == 1 && string.isEmpty
        let length = shouldDelete ? text.count : text.count + 1
        let replacementLength = shouldDelete ? 0 : 1
        let resLength =  length + (shouldDelete ? -1 : 0)
        
        for view in entryViews {
            if view.tag == length {
                view.setTitle(shouldDelete ? Constants.defaultText : string)
            }

            let isSelected = view.tag <= length + replacementLength
            updateViewSelectionStyle(view: view, isSelected: isSelected)
        }
        
        if resLength <= self.length {
            delegate?.pinEntryView(self, didUpdateCode: "\(text)\(string)", isFinished: resLength == self.length)
        }
        
        return resLength <= self.length
    }
}

// MARK: - PinEntryItemViewDelegate

extension PinEntryView: PinEntryItemViewDelegate {
    
    func pinEntryItemViewDidTap(_ view: PinEntryItemView) {
        textField.becomeFirstResponder()
    }
}
