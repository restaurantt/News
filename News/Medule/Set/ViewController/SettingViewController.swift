//
//  SettingViewController.swift
//  News
//
//  Created by Gu Jiajun on 2017/6/21.
//  Copyright © 2017年 gjj. All rights reserved.
//

import UIKit
import SCLAlertView

class SettingViewController: BaseViewController, UITableViewDelegate,UITableViewDataSource {

    let tableView: UITableView = UITableView(frame: UIScreen.main.bounds,style:.plain)
    let options = ["About","powered by NewsAPI.org"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Setting"
        
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.left.right.bottom.equalTo(self.view);
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = options[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)

        switch indexPath.row {
        case 0:
            showAbout()
        case 1:
            gotoNewsAPI()
        default:
            break
        }
        
    }

    func showAbout() {
        let appearance = SCLAlertView.SCLAppearance(
            
            kCircleIconHeight: 55.0,
            showCircularIcon: false
            
        )
        let alertView = SCLAlertView(appearance: appearance)
        let alertViewIcon = UIImage(named: "logo") //Replace the IconImage text with the image name
        alertView.iconTintColor = .white
        alertView.showInfo("About", subTitle: "Headline News is an app which contains headlines of many presses.", closeButtonTitle: "close", duration: 0, colorStyle: 0x000000, colorTextButton: 0xffffff, circleIconImage: alertViewIcon, animationStyle: .noAnimation)
        //alertView.showInfo("Custom icon", subTitle: "This is a nice alert with a custom icon you choose", circleIconImage: alertViewIcon)
    }
    
    func gotoNewsAPI() {
        let webView = BaseWKWebViewController()
        webView.load_UrlSting(string: "https://newsapi.org/")
        navigationController?.pushViewController(webView, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
