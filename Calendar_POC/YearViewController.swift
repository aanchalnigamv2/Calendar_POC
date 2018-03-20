//
//  ViewController.swift
//  Calendar_POC
//
//  Created by aanchal on 06/03/18.
//  Copyright © 2018 aanchal. All rights reserved.
//

import UIKit

class YearViewController: UIViewController, YearCalendarViewProtocol {
    
    @IBOutlet weak var labelWithMonthAndYear: UIBarButtonItem!
    var viewCalendarYear: YearCalendarView?
    var dateString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(self, selector: #selector(YearViewController.dateChanged(_:)), name: NSNotification.Name(rawValue: "DateManager.DateChanged"), object: nil)
        edgesForExtendedLayout = []
        addCalendars()
        updateLabelWithMonthAndYear()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - DateManager Notification
    @objc func dateChanged(_ notification: Notification) {
        updateLabelWithMonthAndYear()
    }
    
    func updateLabelWithMonthAndYear() {
        let comp: DateComponents? = Date.componentsOf(date: DateManager.shared().currentDate!)
        dateString = String(describing: (comp?.year)!)
        labelWithMonthAndYear.title = dateString
        labelWithMonthAndYear.tintColor = UIColor.red
    }

    func addCalendars() {
        let frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height)
        viewCalendarYear = YearCalendarView(frame: frame)
        viewCalendarYear?.yearCalendarViewProtocol = self
        view.addSubview(viewCalendarYear!)
    }
    
    func showMonthCalendar() {
        performSegue(withIdentifier: "YearToMonth", sender: self)
    }
    
    @IBAction func todayButtonTapped(_ sender: UIBarButtonItem) {
        DateManager.shared().setCurrentDate(_currentDate: Date.dateWithYear(year: Date.componentsOfCurrentDate().year!, month: Date.componentsOfCurrentDate().month!, day: Date.componentsOfCurrentDate().day!))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "YearToMonth" {
            let monthViewController = segue.destination as! MonthViewController
            monthViewController.date = DateManager.shared().currentDate
            let backItem = UIBarButtonItem()
            backItem.title = dateString
            navigationItem.backBarButtonItem = backItem
            navigationItem.backBarButtonItem?.tintColor = UIColor.red
        }
    }

}

