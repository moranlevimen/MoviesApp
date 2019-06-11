
import Foundation

class DataManager {
    private static var sharedInstance:DataManager?;
    private init(){}
    //singletone
    public  static func getDataManager()->DataManager
    {
        if DataManager.sharedInstance == nil{
            DataManager.sharedInstance = DataManager();
        }
        return DataManager.sharedInstance!
    }
    
    private var movies:[Movie] = []//an array of movie
    
    func setMoviesArray(moviesList:MoviesList)  {
        self.movies = moviesList.movies.sorted(by: {$0.year > $1.year})
    }
    func getMoviesArray() -> [Movie] {
        return self.movies
    }
    func addMovieData(movie:Movie,indexArray:Int)  {
        self.movies[indexArray] = movie
    }
}
