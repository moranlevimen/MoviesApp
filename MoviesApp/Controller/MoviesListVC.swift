
import UIKit

class  MoviesListVC: UIViewController {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var selectedMovie:(movieObj:Movie?,image:UIImage?)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VCInit()
        getData()
        self.table.tableFooterView = UIView()
    }
    
    func VCInit()  {
        self.activityIndicator.startAnimating()
        self.table.rowHeight = UITableView.automaticDimension
        self.table.estimatedRowHeight = 120
        let nib = UINib(nibName: "MovieCell", bundle: nil);
        self.table.register(nib, forCellReuseIdentifier: "MovieCell");
    }
    
    func getData()  {
        DispatchQueue.global(qos: .background).async {
            ServerManager.getServerManager().getMoviesListJson { (data) in
                if  let moviesList = data{ //if the data exsit 
                    DataManager.getDataManager().setMoviesArray(moviesList: moviesList)
                    DispatchQueue.main.async {
                        self.table.reloadData()
                self.activityIndicator.stopAnimating()
                    }
                }
                else{
                    print("No Data")
                }
            }
        }
    }
    
    @IBAction func clickButtonCell(_ sender: UIButton) {
       self.selectedMovie.movieObj = DataManager.getDataManager().getMoviesArray()[sender.tag]
        let indexPath = IndexPath(item: sender.tag, section: 0)
        let cell = self.table.cellForRow(at: indexPath) as! MovieCell;
        self.selectedMovie.image = cell.movieImage.image;
        
        
         performSegue(withIdentifier: Constants.movieVCSegue, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let VC = segue.destination as! MovieVC;
           VC.movie = self.selectedMovie
    
    }
}

extension MoviesListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.getDataManager().getMoviesArray().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell;
        cell.setMovieCell(movie: DataManager.getDataManager().getMoviesArray()[indexPath.row], indexArray: indexPath.row)
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
   
}
