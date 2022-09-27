class Pokemon{
  int? id;
  int? height;
  int? weight;
  String? name;
  String? imageURL;
  List<String> types = [];
  List<Stat> stats = [];

  Pokemon.fromMap(Map<String,dynamic> map){
    try {
      id = map['id'];
      height = map['height'];
      weight = map['weight'];
      name = map['name'];
      if (map['types'] != null) {
        map['types']?.forEach((entry) {
          types.add(entry['type']['name']);
        });
      }
      if (map['stats'] != null) {
        map['stats']?.forEach((entry) {
          stats.add(Stat.fromMap(entry));
        });
      }
      if (map['sprites'] != null) {
        imageURL = map['sprites']['other']['official-artwork']['front_default'];
      }
    }
    catch (e,trace){
      print("[MODEL] - fromMap error $e\n$trace");
    }
  }

  Map<String, dynamic> toMap() => {
    'id' : id,
    'height' : height,
    'weight' : weight,
    'name' : name,
    'types' : types.toString(),
    'stats' : stats.map((e) => e.toMap()).toList()
  };
}

class Stat{
  int? value;
  String? name;
  Stat(this.value,this.name);

  Stat.fromMap(Map? map){
    try{
      if (map != null){
        if (map.containsKey("value") && map.containsKey("name")) {
          value = map['value'];
          name = map['name'];
        }
        else {
          value = map['base_stat'];
          name = map['stat']['name'];
        }
      }
    }
    catch (e,trace){
      print("[MODEL] - stat.fromMap error $e\n$trace");
    }
  }

  Map<String,dynamic> toMap() => {
    'value' : value,
    'name' : name
  };
}