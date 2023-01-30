//
//  ViewController.swift
//  Office Quotes
//
//  Created by SHAdON . on 1/27/23.
//

import UIKit

class QuoteViewController: UIViewController {
    
    var quoteController = QuoteController()
    var quote: Quote?
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var getQuoteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialViews()
    }
    
    private func initialViews() {
        getQuoteButton.backgroundColor = UIColor(hue: 180/60, saturation: 56/100, brightness: 53/100, alpha: 1.0)
        getQuoteButton.tintColor = .white
        getQuoteButton.layer.cornerRadius = 8.0
        
        quoteLabel.text = ""
        characterLabel.text = ""
    }

    @IBAction func getRandomQuote(_ sender: UIButton) {
        quoteController.fetchQuote { result in
            DispatchQueue.main.async {
                do {
                    self.quote = try result.get()
                    self.updateViews()
                } catch {
                    let alertController = UIAlertController(title: "No Data", message: "No Quotes", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "well darn it", style: .default, handler: nil)
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                }
            }
        }
    }
    
    private func updateViews() {
        guard let quote = quote else {
            return
        }
        
        quoteLabel.text = "\"\(quote.quote)\""
        characterLabel.text = "-\(quote.firstName) \(quote.lastName)"
        characterImageView.image = UIImage(named: quote.firstName.lowercased())
    }
    
}

