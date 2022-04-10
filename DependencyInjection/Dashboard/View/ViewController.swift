//
//  ViewController.swift
//  Moreyeah
//
//  Created by Lalit Kant on 06/04/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timerTableView: UITableView!
    let vm = TimerVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        vm.updateTimer.bind { (returnValue) in
            if returnValue == true {
                self.updateUI()
            }
        }
        vm.showAlert.bind { (index) in
            self.showAlert(rowNumber: index!)
            self.vm.isAlertOpen = true
        }
        super.viewDidAppear(true)
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.timerData.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tvc = tableView.dequeueReusableCell(withIdentifier: "TimerDataTVC") as! TimerDataTVC
        let timerData = vm.timerData.value!
        tvc.setData(dataToReflect: timerData[indexPath.row])
        tvc.tag = indexPath.row
        return tvc
    }
    
}

extension ViewController {
    
    private func updateUI() {
        let visibleIndexPath = timerTableView.visibleCells
        let timerData = vm.timerData.value!
        DispatchQueue.global(qos: .userInitiated).async {
            for cell in visibleIndexPath {
                DispatchQueue.main.async {
                    let updateCell = cell as! TimerDataTVC
                    updateCell.updateTimerTimeText(dataToReflect: timerData[updateCell.tag])
                }
            }
        }
    }
    
}


extension ViewController {
    
    private func showAlert(rowNumber: Int) {
        // create the alert
        let alert = UIAlertController(title: "Row number \(rowNumber) is to be deleted as its remaining time is 00:00:00", message: "Are you sure to delete", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.vm.deleteObject()
            let indexPath = IndexPath(item: rowNumber, section: 0)
            self.timerTableView.deleteRows(at: [indexPath], with: .fade)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { action in
            self.vm.alertCancelled()
            self.vm.isAlertOpen = false
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
