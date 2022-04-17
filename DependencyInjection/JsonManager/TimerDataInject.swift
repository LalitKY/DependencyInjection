//
//  TimerDataInject.swift

//
//  Created by Lalit Kant on 06/04/21.
//

import Foundation

class TimerDataInject {
    var timerFileData: GetTimerFileData
    
    init(fileData: GetTimerFileData) {
        self.timerFileData = fileData
    }
    
    func getTimerData(completion: @escaping (Result<[TimerDataModal]?, Error>) -> ()) {
        self.timerFileData.getTimerData(completion: completion)
    }
}
