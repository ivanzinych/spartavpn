//
//  PinEntryItemView.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 25.09.2024.
//

import UIKit

protocol PinEntryItemViewDelegate: AnyObject {
    func pinEntryItemViewDidTap(_ view: PinEntryItemView)
}

class PinEntryItemView: UIView {
    
    struct ColorParams {
        let borderColor: UIColor
        let titleColor: UIColor
    }
    
    struct ButtonParams {
        let font: UIFont
        let text: String
    }
    
    weak var delegate: PinEntryItemViewDelegate?
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.roundCorners(12)

        return view
    }()
    
    // MARK: - Public
    
    func setTitle(_ title: String) {
        button.setTitle(title, for: [])
    }
    
    func update(with params: ColorParams) {
        containerView.backgroundColor = .textFieldBackground
        button.setTitleColor(params.titleColor, for: [])
    }
    
    func configure(with params: ButtonParams) {
        button.setTitle(params.text, for: [])
        button.titleLabel?.font = params.font
        button.addTarget(self, action: #selector(entryButtonTap(sender:)), for: .touchUpInside)
        stackView.addArrangedSubview(button)
    }
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        initView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initView() {
        setupContainerView()
        setupStackView()
    }
    
    private func setupStackView() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupContainerView() {
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Actions

    @objc
    private func entryButtonTap(sender: UIButton) {
        delegate?.pinEntryItemViewDidTap(self)
    }
}
