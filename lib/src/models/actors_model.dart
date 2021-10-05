
class Cast{
  List<Actor> actors = [];
  Cast.fromJsonList(List<dynamic> jsonList){
    if (jsonList == null) return;
    jsonList.forEach((item) {
      final actor = new Actor.fromJsonMap(item);
      actors.add(actor);
    });
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor(
      {this.castId,
      this.character,
      this.creditId,
      this.gender,
      this.id,
      this.name,
      this.order,
      this.profilePath});

  Actor.fromJsonMap(Map<String, dynamic> json) {
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

  getImg(){
    final _imgUrl = 'https://image.tmdb.org/t/p/w500';
    final _unavailable =
        'https://cdn-a.william-reed.com/var/wrbm_gb_food_pharma/storage/images/3/3/2/7/237233-6-eng-GB/Cosmoprof-Asia-Ltd-SIC-Cosmetics-20132.jpg';
    if (profilePath == null || profilePath == '') {
      return _unavailable;
    }
    return _imgUrl + profilePath;

  }
}
