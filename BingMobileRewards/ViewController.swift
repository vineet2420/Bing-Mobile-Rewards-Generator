//
//  AppDelegate.swift
//  BingMobileRewards
//
//  Created by Vinny Malhotra on 5/28/19.
//  Copyright © 2019 Vinny Malhotra. All rights reserved.
//

import UIKit
import WebKit


/**
 * Automated searches for the Bing search engine
 * Preset button availale or accepting user input
 * Confroms to dark mode in iOS 13+
 * Time complexity - O(2*K) where K is the number of searches occuring. 2 is the delay time within each search iteration.
 */

class ViewController: UIViewController {
    @IBOutlet weak var userSearchInputTextField: UITextField!
    @IBOutlet weak var webView: WKWebView!
    var url = URL(string: "https://www.bing.com")!
    let randomStringLength = 6
    
    /* --------------------------------------------------------------------------------------------------------- */
    //let the user enter their own number of searches
    @IBAction func UserCustomSearches(_ sender: Any) {
        view.endEditing(true) //hide the keyboard

        if(!(userSearchInputTextField.text?.isEmpty ?? true)){
            let userInputNumber = Int(userSearchInputTextField.text!) //grab the integer from the textfield
            loadSearches(count: userInputNumber!) //start searching
        }
        
    }
    
    /* --------------------------------------------------------------------------------------------------------- */
    //immediately search 20x
    @IBAction func SearchPresetInput(_ sender: Any) {
        view.endEditing(true)
        loadSearches(count: 20)
    }
    
    /* --------------------------------------------------------------------------------------------------------- */
    //running the search function
    private func loadSearches(count: Int){
        userSearchInputTextField.text = "" //clear the textfield, so the user doesnt have to
        //iterate tot he count +1.. the last iteration will show a done message
        for iterator in 0...count {
            //need to have an async delay so the loop does not complete before the searches do
            delayWithSeconds(Double(2*iterator)) {
                self.url = URL(string: "https://www.bing.com/search?q=\(self.randomString(self.randomStringLength))")!
                self.webView.load(URLRequest(url: self.url))
            }
            
            //show the done message on the last message
            if(iterator == count){
               delayWithSeconds(Double(2*iterator)) {
                    self.url = URL(string: "https://www.bing.com/search?q=done")!
                    self.webView.load(URLRequest(url: self.url))
                }
            }
            
        }
        
    }
    
    /* --------------------------------------------------------------------------------------------------------- */
    
    //random string generator
    private func randomString(_ length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    /* --------------------------------------------------------------------------------------------------------- */

    //timer function
    private func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
    /* --------------------------------------------------------------------------------------------------------- */
    
    //load the urls and update the webkit view
     private func loadWebView(){
         webView.load(URLRequest(url: url))
         webView.allowsBackForwardNavigationGestures = true
     }
     
    /* --------------------------------------------------------------------------------------------------------- */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView() //intial bing site load
    }
    
    /* --------------------------------------------------------------------------------------------------------- */

}
