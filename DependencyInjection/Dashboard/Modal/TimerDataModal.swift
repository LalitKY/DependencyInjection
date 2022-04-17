//
//  TimerDataModal.swift

//
//  Created by Lalit Kant on 06/04/21.
//

import Foundation

struct TimerDataModal: Codable {
    var imageUrl: String?
    var timeRemaining: String?
    var text: String?
    var showAlert: Bool?
    var alertCancelled: Bool?
}


