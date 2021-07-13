import 'package:netflix_clone_app/models/actor_model.dart';

class Movie {
   int movieUid;
   String movieName;
   String director;
   String aboutMovie;
   String trailerUrl;
   String posterUrl;
   List<Actor> actors = [];
   List<String> genres = [];

   getMovieUid() {
     return movieUid;
   }

   setFromMovieTable(int uid, String name, String directorName, String about, String trailer, String poster) {
     movieUid = uid;
     movieName = name;
     director = directorName;
     aboutMovie = about;
     trailerUrl = trailer;
     posterUrl = poster;
   }

   setFromActors( List<Actor> actorsList ) {
     actors = actorsList;
   }

   setFromGenres( List<String> genreList) {
     genres = genreList;
   }
}