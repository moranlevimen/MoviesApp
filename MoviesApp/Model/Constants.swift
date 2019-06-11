

import Foundation

struct Constants {
   static let movieVCSegue = "MovieVCSegue"
   static let allMoviesUrl = "http://x-mode.co.il/exam/allMovies/allMovies.txt"
  static  func getSpesificMovieUrl(id:String)->String  {
        return "http://x-mode.co.il/exam/descriptionMovies/\(id).txt"
    }
}
