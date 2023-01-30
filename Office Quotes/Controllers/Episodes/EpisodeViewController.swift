//
//  EpisodeViewController.swift
//  Office Quotes
//
//  Created by SHAdON . on 1/29/23.
//

import UIKit

class EpisodeViewController: UIViewController {
    
    var episodeController = EpisodeController()
    var episode: Episode?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var getQuoteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialViews()
    }
    
    private func initialViews() {
        getQuoteButton.backgroundColor = UIColor(hue: 180/60, saturation: 56/100, brightness: 53/100, alpha: 1.0)
        getQuoteButton.tintColor = .white
        getQuoteButton.layer.cornerRadius = 8.0
        
        titleLabel.text = ""
        descriptionLabel.text = ""
        dateLabel.text = ""
    }
    
    
    @IBAction func getRandomQuote(_ sender: UIButton) {
        episodeController.fetchQuote { result in
            DispatchQueue.main.async {
                do {
                    self.episode = try result.get()
                    self.updateViews()
                } catch {
                    let alertController = UIAlertController(title: "No Data", message: "No Episodes", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "well darn it", style: .default, handler: nil)
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                }
            }
        }
    }
    
    private func updateViews() {
        guard let episode = episode else {
            return
        }
        
        titleLabel.text = "\"\(episode.title)\""
        descriptionLabel.text = "\(episode.description)"
        let rawDate = episode.airDate.split(separator: "T")[0]
        var date = String(rawDate)
        date = date.replacingOccurrences(of: "-", with: "/")
        dateLabel.text = "Date aired: \(date)"
    }
    
}
