//
//  EnterEmailViewController.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 24.09.2024.
//

import UIKit
import SnapKit

class EnterEmailViewController: BaseViewController {
    
    private let viewModel: EnterEmailViewModel
    
    init(viewModel: EnterEmailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Авторизация"
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = AppFont.bold40
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите ваш адрес эл. почты и мы отправим вам код для  авторизации"
        label.textColor = UIColor.appColor(.secondaryTextColor)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = AppFont.regular14
        return label
    }()
    
    private(set) lazy var emailTextField: TextFieldView = {
        let textField = TextFieldView()
        textField.textField.attributedPlaceholder = NSAttributedString(
            string: "Эл. почта",
            attributes: [.foregroundColor: UIColor.appColor(.extraSecondaryTextColor)])
        textField.roundCorners(12)
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "close_button"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private(set) lazy var sendCodeButton: GradientButton = {
        let button = GradientButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Отправить код", for: [])
        button.titleLabel?.font = AppFont.semibold14
        button.setGradientBackground(with: GradientParams(startColor: UIColor.appColor(.textFieldBackground),
                                                          endColor: UIColor.appColor(.textFieldBackground),
                                                          startPoint: CGPoint(x: 0.2, y: 0.5),
                                                          endPoint: CGPoint(x: 1, y: 0.5)))
        button.roundCorners(15)
        button.setTitleColor(UIColor.appColor(.secondaryTextColor), for: [])
        button.tintColor = .white
        button.addTarget(self, action: #selector(sendCodeButtonDidTap), for: .touchUpInside)
        button.isEnabled = false
        
        return button
    }()
    
    private lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        return tapGestureRecognizer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addKeyboardObserver()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextField.textField.becomeFirstResponder()
    }
    
    deinit {
        removeKeyboardObserver()
    }
    
    override func keyboardWillShow(_ info: KeyboardInfo) {
        updateSendCodeButtonConsstraints(offset: info.keyboardFrame.height)
    }
    
    private func setup() {
        view.backgroundColor = UIColor.appColor(.backgroundColor)
        addTitleLabel()
        addCloseButton()
        addDescriptionLabel()
        addEmailTextField()
        addSendCodeButton()
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func addTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(80)
        }
    }
    
    private func addDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
        }
    }
    
    private func addCloseButton() {
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
        }
    }
    
    private func addEmailTextField() {
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(64)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(65)
        }
    }
    
    private func addSendCodeButton() {
        view.addSubview(sendCodeButton)
        updateSendCodeButtonConsstraints(offset: 40)
    }
    
    private func updateSendCodeButtonConsstraints(offset: CGFloat) {
        sendCodeButton.snp.remakeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(64)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-offset)
        }
    }
    
    // MARK: - Navigation
    
    private func showEnterCode(with email: String) {
        let viewController = EnterCodeViewController(viewModel: EnterCodeViewModel(authApi: DIService.authAPIService, authKeychainService: DIService.authKeychainService))
        viewController.email = email
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Actions
    
    @objc
    private func closeButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func handleTap() {
        view.endEditing(true)
    }
    
    @objc
    private func sendCodeButtonDidTap() {
        let email = emailTextField.textField.text ?? ""
        if email.isEmpty {
            showErrorMsg("Введите эл. почту")
            return
        }
        if !Validate.isValidEmail(email) {
            showErrorMsg("Введите корректную эл. почту")
            return
        }
        
        Loader.start()
        viewModel.sendCode(email: email) { [weak self] in
            Loader.stop()
            self?.showEnterCode(with: email)
        } errorCompletion: { [weak self] error in
            Loader.stop()
            self?.showErrorMsg(error.localizedDescription)
        }
    }
}

// MARK: - TextFieldViewDelegate

extension EnterEmailViewController: TextFieldViewDelegate {
    
    func textFieldViewDidBeginEditing(_ view: TextFieldView) {
        
    }
    
    func textFieldViewDidValueChanged(_ view: TextFieldView) {
        if (view.textField.text ?? "").isEmpty {
            sendCodeButton.isEnabled = false
            sendCodeButton.setTitleColor(UIColor.appColor(.secondaryTextColor), for: [])
            sendCodeButton.setGradientBackground(with: GradientParams(startColor: UIColor.appColor(.textFieldBackground),
                                                                      endColor: UIColor.appColor(.textFieldBackground),
                                                                      startPoint: CGPoint(x: 0.2, y: 0.5),
                                                                      endPoint: CGPoint(x: 1, y: 0.5)))
        } else {
            sendCodeButton.isEnabled = true 
            sendCodeButton.setTitleColor(.white, for: [])
            sendCodeButton.setGradientBackground(with: GradientParams(startColor: UIColor.appColor(.colorTwo),
                                                                      endColor: UIColor.appColor(.colorOne),
                                                                      startPoint: CGPoint(x: 0.2, y: 0.5),
                                                                      endPoint: CGPoint(x: 1, y: 0.5)))
        }
    }
}
