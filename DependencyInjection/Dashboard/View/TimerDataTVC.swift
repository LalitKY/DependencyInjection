//
//  TimerDataTVC.swift
//  Moreyeah
//
//  Created by Lalit Kant on 06/04/21.
//

import UIKit

class TimerDataTVC: UITableViewCell {

    @IBOutlet private weak var timerImgVW: UIImageView!
    @IBOutlet private weak var timerLbl: UILabel!
    @IBOutlet private weak var timerTimeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(dataToReflect: TimerDataModal) {
        timerLbl.text = dataToReflect.text
        timerImgVW.downloaded(from: dataToReflect.imageUrl ?? "", contentMode: .scaleAspectFit)
        timerTimeLbl.text = dataToReflect.timeRemaining
    }
    
    func updateTimerTimeText(dataToReflect: TimerDataModal) {
        timerTimeLbl.text = dataToReflect.timeRemaining
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
