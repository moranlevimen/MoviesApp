
import Foundation
class  ServerManager {
    private static var sharedInstance:ServerManager?;//singletone- one instance-allow me to do a single instance.need to init only one time.
    private init(){}
    public  static func getServerManager()->ServerManager
    {
        if ServerManager.sharedInstance == nil{
            ServerManager.sharedInstance = ServerManager();
        }
        return ServerManager.sharedInstance!
    }
    //escapint in order to use from outside.
    //all movie
    
    //prepefe for request- creates the func' but yet not call it
    func getMoviesListJson(completion:@escaping(MoviesList?)->())  {
        guard let url = URL(string: Constants.allMoviesUrl) else {return}
        URLSession.shared.dataTask(with: url){(data,respose,error) in
            if error != nil {
                // handle the transport error
                completion(nil)
                return
            }
            do{
                let moviesList = try JSONDecoder().decode(MoviesList.self, from: data!);
                completion(moviesList)
            }
            catch{
                print("error")
                completion(nil)
            }
            }.resume()
    }
    //spe' movie
    func getMovieJson(url:String,completion: @escaping (Movie?) -> ())  {
        guard let url = URL(string: url) else {return}
        URLSession.shared.dataTask(with: url){(data,respose,error) in
            if error != nil {
                // handle the transport error
                completion(nil)
                return
            }
            do{
                let movie = try JSONDecoder().decode(Movie.self, from: data!);
                completion(movie)
            }
            catch{
                print("error")
                completion(nil)
            }
            }.resume()
    }
}
