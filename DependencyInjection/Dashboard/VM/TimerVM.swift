//
//  TimerVM.swift
//  Moreyeah
//
//  Created by Lalit Kant on 06/04/21.
//

import Foundation

class TimerVM {
    
    var timer : Timer!
    var timerData = Bindable<[TimerDataModal]>()
    let timerListData = TimerDataInject(fileData: LoadDataFromJsonServiceManager())
    /// Example of Dependency Injection - means you can get data from both means like json file or Api
    let timerListApiData = TimerDataInject(fileData: LoadDataFromApiServiceManager())
    
    let updateTimer = Bindable<Bool>()
    let showAlert = Bindable<Int>()
    var isAlertOpen = false
    
    init() {
        getTimerData()
    }
    
    private func getTimerData() {
        timerListData.getTimerData { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let result) :
                self.timerData.value = result
                self.startTimer()
                break
            case .failure( _) :
                self.invalidateTimer()
                break
            }
        }
    }
   

    
    @objc func invalidateTimer()  {
        if timer != nil {
            timer.invalidate()
        }
        updateTimer.value = false
    }
    
}

//MARK: Timer Methods
extension TimerVM {
    
    func startTimer() {
        let value = self.timerData.value?.max(by:{$1.timeRemaining ?? "" > $0.timeRemaining ?? ""})
        let timeIntervalInSec = TimerUtility().createTimeStringToTimeSeconds(dateString: value?.timeRemaining)
        Timer.init().perform(#selector(invalidateTimer), with: nil, afterDelay: TimeInterval(timeIntervalInSec))
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    }
    
    @objc private func runTimedCode() {
        self.timerData.value =  self.timerData.value?.map{ data -> TimerDataModal in
            var newData = data
            newData.timeRemaining = TimerUtility().minusTimeByOnSec(dateString: newData.timeRemaining)
            if newData.timeRemaining == "00:00:00" && newData.showAlert == nil && newData.alertCancelled == nil
            {
                newData.showAlert = true
            }
            return newData
        }
        DispatchQueue.main.async {
            self.updateTimer.value = true
        }
        showPopupMethod()
    }

}

//MARK: Updating Timer Object on Alertview click
extension TimerVM {
    
    func deleteObject() {
        self.timerData.value?.remove(at: self.showAlert.value!)
        isAlertOpen = false
    }
    
    func alertCancelled() {
        self.timerData.value?[self.showAlert.value!].alertCancelled = true
    }
    
    private func showPopupMethod() {
        if isAlertOpen == false {
            let index = self.timerData.value!.firstIndex{$0.showAlert == true && $0.alertCancelled == nil}
            if index != nil {
                DispatchQueue.main.async {
                    self.showAlert.value = index
                }
            }
        }
    }
}
