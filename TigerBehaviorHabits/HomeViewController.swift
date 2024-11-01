//
//  HomeViewController.swift
//  TigerBehaviorHabits
//
//  Created by Julien Long on 2024/10/31.
//

import UIKit
import StoreKit

class HomeViewController: UIViewController {

    @IBOutlet weak var opView: UIView!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        loadingIndicator.hidesWhenStopped = true
        requestQuizConfig()
    }
    
    private func requestQuizConfig() {
        if tbNeedShowAdv() {
            opView.isHidden = true
            loadingIndicator.startAnimating()
            if TBNetReachabilityManager.shared().isReachable {
                execRequestConfig()
            } else {
                TBNetReachabilityManager.shared().setReachabilityStatusChange { [weak self] status in
                    if TBNetReachabilityManager.shared().isReachable {
                        self?.execRequestConfig()
                        TBNetReachabilityManager.shared().stopMonitoring()
                    }
                }
                TBNetReachabilityManager.shared().startMonitoring()
            }
        }
    }
    
    private func execRequestConfig() {
        normalNetworkRequest { [weak self] config in
            if let config = config,
               let adsData = config["jsonObject"] as? [String: Any],
               let adsUr = adsData["data"] as? String {
                
                let userDefaults = UserDefaults.standard
                
                if let cacheData = userDefaults.object(forKey: "QuizConfigsCache") as? [String: Any],
                   let cacheUr = cacheData["data"] as? String,
                   !cacheUr.isEmpty,
                   let needud = adsData["needud"] as? Int, needud == 0 {
                    self?.tbShowAdvViewC(cacheUr)
                    return
                } else if !adsUr.isEmpty {
                    userDefaults.set(adsData, forKey: "QuizConfigsCache")
                    self?.tbShowAdvViewC(adsUr)
                    return
                }
            }
            self?.loadingIndicator.stopAnimating()
            self?.opView.isHidden = false
        }
    }
    
    private func normalNetworkRequest(_ completion: @escaping ([String: Any]?) -> Void) {
        guard let bundleId = Bundle.main.bundleIdentifier else {
            completion(nil)
            return
        }
        
        let url = URL(string: "https://o\(self.tbHttpAppUrl())/open/getQuiz")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String: Any] = [
            "des": "0",
            "appChannel": "iOS",
            "appKey": "b6dcb7a39bc448e7a156393e66145c83",
            "appPackageId": bundleId,
            "appVersion": Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? ""
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            debugPrint("Failed to serialize JSON:", error)
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    debugPrint("Request error:", error ?? "Unknown error")
                    completion(nil)
                    return
                }
                
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    if let resDic = jsonResponse as? [String: Any] {
                        let dictionary: [String: Any]? = resDic["data"] as? Dictionary
                        if let dataDic = dictionary {
                            debugPrint("Response data:", data)
                            completion(dataDic)
                            return
                        }
                    }
                    debugPrint("Response JSON:", jsonResponse)
                    completion(nil)
                } catch {
                    debugPrint("Failed to parse JSON:", error)
                    completion(nil)
                }
            }
        }
        
        task.resume()
    }
    
    @IBAction func behaviourBtnAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BehaviourHomeViewController") as! BehaviourHomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func habitBtnAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HealthHomeViewController") as! HealthHomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func shareBtnAction(_ sender: Any) {
        let objectsToShare = ["TigerBehaviorHabits"]
        let activityVController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVController.popoverPresentationController?.sourceView = self.view
        activityVController.popoverPresentationController?.sourceRect = CGRect(x: 100, y: 200, width: 300, height: 300)
        self.present(activityVController, animated: true, completion: nil)
    }
    
    @IBAction func rate(_ sender: Any) {
        SKStoreReviewController.requestReview()
    }

    @IBAction func showPrivacyPolicyAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TBPrivacyPolicyViewController") as! TBPrivacyPolicyViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
