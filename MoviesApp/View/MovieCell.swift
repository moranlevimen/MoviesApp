

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var buttonCell: UIButton!
    @IBOutlet weak var yearLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setMovieCell(movie:Movie,indexArray:Int)  {
        self.movieNameLabel.text = movie.name
        self.yearLabel.text = movie.year
        self.buttonCell.tag = indexArray
        if movie.imageUrl != nil{
            getImage(url: movie.imageUrl!)
        }
        else{
        ServerManager.getServerManager().getMovieJson(url: Constants.getSpesificMovieUrl(id: movie.id)) { (data) in
                if let movieData = data{
                    DataManager.getDataManager().addMovieData(movie: movieData, indexArray: indexArray)
                    self.getImage(url: movieData.imageUrl!)
                }
            }
        }
    }

    func getImage(url:String) {
        DispatchQueue.global(qos: .background).async {
            if let imageUrl = URL(string: url){
                do{
                    let imageData = try Data(contentsOf: imageUrl);
                    DispatchQueue.main.async {
                        self.movieImage.image = UIImage(data: imageData, scale: 1.0);
                        if self.movieImage.image == nil{
                            
                            self.movieImage?.image = UIImage(named: "noIcon")
                        }
                    }
                }
                catch{}
            }
        }
    }
   
}
