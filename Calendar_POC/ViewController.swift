//
//  ViewController.swift
//  Calendar_POC
//
//  Created by aanchal on 06/03/18.
//  Copyright © 2018 aanchal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, YearCalendarViewProtocol {
    
    @IBOutlet weak var labelWithMonthAndYear: UIBarButtonItem!
    var viewCalendarYear: YearCalendarView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.dateChanged(_:)), name: NSNotification.Name(rawValue: "DateManager.DateChanged"), object: nil)
        
        addCalendars()
        updateLabelWithMonthAndYear()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - FFDateManager Notification
    @objc func dateChanged(_ notification: Notification) {
        updateLabelWithMonthAndYear()
    }
    
    func updateLabelWithMonthAndYear() {
        let comp: DateComponents? = Date.componentsOf(date: DateManager.shared().currentDate!)
        let string: String = String(describing: (comp?.year)!)
        labelWithMonthAndYear.title = string
        labelWithMonthAndYear.tintColor = UIColor.red
    }

    func addCalendars() {
        let frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height)
        viewCalendarYear = YearCalendarView(frame: frame)
        viewCalendarYear?.yearCalendarViewProtocol = self
        view.addSubview(viewCalendarYear!)
    }
    
    func showMonthCalendar() {
        updateLabelWithMonthAndYear()
    }
    
    @IBAction func todayButtonTapped(_ sender: UIBarButtonItem) {
        DateManager.shared().setCurrentDate(_currentDate: Date.dateWithYear(year: Date.componentsOfCurrentDate().year!, month: Date.componentsOfCurrentDate().month!, day: Date.componentsOfCurrentDate().day!))
    }
}

