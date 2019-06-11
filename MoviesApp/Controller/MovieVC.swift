
import UIKit

class MovieVC: UIViewController {
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    var movie:(movieObj:Movie?,image:UIImage?)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initVC()
        
    }
    
    func initVC() {
        if let movieData = self.movie.movieObj {
            self.movieNameLabel.text = movieData.name
            if let description = movieData.description{
                self.movieDescriptionLabel.text = description
            }
        }
        if let image = self.movie.image {
            self.movieImageView.image = image
        }
    }
}
