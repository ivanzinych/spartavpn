//
//  CountdownTimerViewModel.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 25.09.2024.
//

import Foundation

protocol CountdownTimerViewModelDelegate: AnyObject {

    func countdownTimerViewModelDidStart(_ timerViewModel: CountdownTimerViewModel)
    func countdownTimerViewModelDidFinish(_ timerViewModel: CountdownTimerViewModel)
    func countdownTimerViewModel(_ timerViewModel: CountdownTimerViewModel, didUpdate timeString: String)
}

class CountdownTimerViewModel {

    static var shared: CountdownTimerViewModel? = CountdownTimerViewModel()

    // MARK: - Properties
    
    weak var delegate: CountdownTimerViewModelDelegate?
        
    var previousContext = [String]()
    
    var updateInterval: TimeInterval = 0.5

    // MARK: - Private Properties
    
    private var timer: Timer?
    private var expiration: Date?
    
    // MARK: - Public Methods
    
    public func start(remainingTime: TimeInterval) {
        guard remainingTime > 0 else {
            delegate?.countdownTimerViewModelDidFinish(self)
            return
        }
        self.expiration = Date(timeIntervalSinceNow: remainingTime)
        self.timer?.invalidate()
        let timer = Timer(timeInterval: updateInterval,
                          target: self,
                          selector: #selector(CountdownTimerViewModel.handleFireEvent),
                          userInfo: nil,
                          repeats: true)
        RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
        self.timer = timer

        delegate?.countdownTimerViewModelDidStart(self)
        handleFireEvent()
    }

    public func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - Private Methods
    
    private func formattedRemainingTimeString(now: Date, expiration: Date) -> String {
        let dateComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: now, to: expiration)

        guard let hours = dateComponents.hour,
            let minutes = dateComponents.minute,
            let seconds = dateComponents.second else {
                assertionFailure("Something wrong with now and expiration dates")
                return ""
        }

        let remainingTimeString: String
        if hours > 0 {
            remainingTimeString = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            remainingTimeString = String(format: "%02d:%02d", minutes, seconds)
        }

        return remainingTimeString
    }
    
    // MARK: - Actions
    
    @objc private func handleFireEvent() {
        guard let expiration = expiration else {
            assertionFailure("Expiration date must exist!")
            return
        }

        let now = Date()
        if now < expiration {
            delegate?.countdownTimerViewModel(self, didUpdate: formattedRemainingTimeString(now: now, expiration: expiration))
        } else {
            stop()
            previousContext.removeAll()
            delegate?.countdownTimerViewModelDidFinish(self)
        }
    }
}

