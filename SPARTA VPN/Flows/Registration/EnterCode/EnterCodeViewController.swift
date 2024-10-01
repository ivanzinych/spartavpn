//
//  EnterCodeViewController.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 25.09.2024.
//

import UIKit
import SnapKit

class EnterCodeViewController: BaseViewController {
    
    var email: String = ""
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Верификация"
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = AppFont.bold40
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Мы отправили код на адрес"
        label.textColor = UIColor.appColor(.secondaryTextColor)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = AppFont.regular14
        return label
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Код неправильный"
        label.textColor = UIColor.appColor(.errorColor)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = AppFont.regular14
        label.isHidden = true
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        
        return stackView
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
    
    private(set) lazy var resendCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отправить повторно", for: [])
        button.titleLabel?.font = AppFont.semibold14
       
        button.setTitleColor(UIColor.appColor(.colorTwo), for: [])
        button.tintColor = .white
        button.addTarget(self, action: #selector(resendCodeButtonDidTap), for: .touchUpInside)
        button.isHidden = true
        
        return button
    }()
    
    private(set) lazy var pinEntryView: PinEntryView = {
        let view = PinEntryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.entryFieldsTitleColor = UIColor.appColor(.textColor)
        view.selectedEntryFieldsTitleColor = .white
        view.delegate = self
        
        return view
    }()
    
    private let resendCodeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Не получили код?"
        label.textColor = UIColor.appColor(.secondaryTextColor)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = AppFont.regular14

        return label
    }()
    
    private let resendCodeTimerLabel: UILabel = {
        let label = UILabel()
        label.text = "Не получили код?"
        label.textColor = UIColor.appColor(.secondaryTextColor)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = AppFont.regular14

        return label
    }()
        
    private lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        return tapGestureRecognizer
    }()
    
    // MARK: - View Models
   
    private lazy var сountdownTimerViewModel: CountdownTimerViewModel = {
        let viewModel = CountdownTimerViewModel()
        viewModel.delegate = self
        
        return viewModel
    }()
    
    private let viewModel: EnterCodeViewModel

    // MARK: - Lifecycle
        
    init(viewModel: EnterCodeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addKeyboardObserver()
    }
    
    deinit {
        removeKeyboardObserver()
    }
    
    override func keyboardWillShow(_ info: KeyboardInfo) {
        updateSendCodeButtonConsstraints(offset: info.keyboardFrame.height)
    }
    
    override func keyboardWillHide(_ info: KeyboardInfo) {
        updateSendCodeButtonConsstraints(offset: 20)
    }
    
    private func setup() {
        view.backgroundColor = UIColor.appColor(.backgroundColor)
        addTitleLabel()
        addCloseButton()
        addDescriptionLabel()
        addPinEntryView()
        addSendCodeButton()
        addStackView()
        view.addGestureRecognizer(tapGestureRecognizer)
        
        сountdownTimerViewModel.start(remainingTime: 60)
        
        let string = "Мы отправили код на адрес \(email)"
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [.font: AppFont.regular14, .foregroundColor: UIColor.appColor(.secondaryTextColor)])
        
        let range = attributedString.mutableString.range(of: email)
        attributedString.addAttributes([.font: AppFont.bold14, .foregroundColor: UIColor.white], range: range)
        descriptionLabel.attributedText = attributedString
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
    
    private func addPinEntryView() {
        view.addSubview(pinEntryView)
        pinEntryView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(64)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(25)
        }
    }
    
    private func addStackView() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(errorLabel)
        stackView.addArrangedSubview(resendCodeTitleLabel)
        stackView.addArrangedSubview(resendCodeTimerLabel)
        stackView.addArrangedSubview(resendCodeButton)
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pinEntryView.snp.bottom).offset(25)
        }
    }
    
    private func addSendCodeButton() {
        view.addSubview(sendCodeButton)
        updateSendCodeButtonConsstraints(offset: 40)
    }
    
    private func updateSendCodeButtonConsstraints(offset: CGFloat) {
        sendCodeButton.snp.remakeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(64)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-offset)
        }
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
        Loader.start()
        errorLabel.isHidden = true
        viewModel.clientValidation(email: email,
                                   code: pinEntryView.textField.text ?? "") { [weak self] in
            Loader.stop()
            self?.navigationController?.setViewControllers([HomeViewController(viewModel: HomeViewModel(userApi: DIService.userAPIService))], animated: false)
        } errorCompletion: { [weak self] _ in
            Loader.stop()
            self?.errorLabel.isHidden = false
        }
    }
    
    @objc
    private func resendCodeButtonDidTap() {
        if email.isEmpty {
            showErrorMsg("Введите Эл. почту")
            return
        }
        
        resendCodeButton.isHidden = true
        errorLabel.isHidden = true
        сountdownTimerViewModel.start(remainingTime: 60)
        
        Loader.start()
        viewModel.sendCode(email: email) {
            Loader.stop()

        } errorCompletion: { [weak self] error in
            Loader.stop()
            self?.showErrorMsg(error.localizedDescription)
        }
    }
}

// MARK: - CountdownTimerViewModelDelegate

extension EnterCodeViewController: CountdownTimerViewModelDelegate {
    
    func countdownTimerViewModel(_ timerViewModel: CountdownTimerViewModel, didUpdate timeString: String) {
        resendCodeTimerLabel.isHidden = false
        resendCodeTimerLabel.text = "Отправить повторно \(timeString)"
    }
    
    func countdownTimerViewModelDidFinish(_ timerViewModel: CountdownTimerViewModel) {
        resendCodeTimerLabel.isHidden = true
        resendCodeButton.isHidden = false
    }
    
    func countdownTimerViewModelDidStart(_ timerViewModel: CountdownTimerViewModel) {}
}


extension EnterCodeViewController: PinEntryViewDelegate {
    
    func pinEntryView(_ view: PinEntryView, didUpdateCode code: String, isFinished: Bool) {
        sendCodeButton.isEnabled = isFinished
        
        if isFinished {
            sendCodeButton.setTitleColor(.white, for: [])
            sendCodeButton.setGradientBackground(with: GradientParams(startColor: UIColor.appColor(.colorTwo),
                                                                      endColor: UIColor.appColor(.colorOne),
                                                                      startPoint: CGPoint(x: 0.2, y: 0.5),
                                                                      endPoint: CGPoint(x: 1, y: 0.5)))
        } else {
            sendCodeButton.setTitleColor(UIColor.appColor(.secondaryTextColor), for: [])
            sendCodeButton.setGradientBackground(with: GradientParams(startColor: UIColor.appColor(.textFieldBackground),
                                                                      endColor: UIColor.appColor(.textFieldBackground),
                                                                      startPoint: CGPoint(x: 0.2, y: 0.5),
                                                                      endPoint: CGPoint(x: 1, y: 0.5)))
        }
    }
}
