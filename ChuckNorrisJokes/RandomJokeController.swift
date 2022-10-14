//
//  RandomJokeController.swift
//  ChuckNorrisJokes
//
//  Created by Konstantin Bolgar-Danchenko on 14.10.2022.
//

import UIKit

class RandomJokeController: UIViewController {

    @IBOutlet weak var jokeLabel: UILabel!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var refreshButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        shareButton.isEnabled = false
    }

    @IBAction func shareButtonAction(_ sender: Any) {
        let ac = UIActivityViewController(
            activityItems: [jokeLabel.text!],
            applicationActivities: nil
        )
        present(ac, animated: true)
    }

    @IBAction func refreshButtonAction(_ sender: Any) {
        refreshButton.isEnabled = false

        getRandomJoke { joke in
            DispatchQueue.main.async {
                self.refreshButton.isEnabled = true
                if let joke {
                    self.jokeLabel.text = joke
                    self.shareButton.isEnabled = true
                } else {
                    self.jokeLabel.text = "Something went wrong. Tap Refresh button."
                    self.shareButton.isEnabled = false
                }
            }
        }
    }



}
