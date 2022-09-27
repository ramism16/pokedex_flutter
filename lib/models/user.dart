import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

ValueNotifier<int> favouritesCount = ValueNotifier(User.instance.favouriteIDs.length);

/// This is my approach to client-side state persistence linked to a user account/session
class User{
  //class members
  List<int> favouriteIDs = [];

  //shared preferences (app cache) state storage key
  static String get sharedPrefsKey => "PokedexUserStateSPKey";

  //Making the singleton
  //1. Internal constructor
  User._();
  //2. static instance variable
  static User instance = User._();
  //3. factory constructor
  factory User({List<int>? favouriteIDs}){
    instance.favouriteIDs = favouriteIDs ?? instance.favouriteIDs;
    return instance;
  }

  //serializing
  static void fromJson(String? jsonMap){
    try{
      if (jsonMap != null){
        instance.favouriteIDs.clear();
        final localFavourites = json.decode(jsonMap)['ids'];
        localFavourites?.forEach((id){instance.favouriteIDs.add(id);});
      }
      else{ instance.favouriteIDs.clear(); }
    }
    catch (e,trace){
      print("[USER] - fromJson error $e\n$trace");
    }
  }

  static Map<String, List<int>> toMap() => {"ids" : instance.favouriteIDs.toList()};

  //functions for adding/removing favourite
  static void addFavourite(int id){
    if (!instance.favouriteIDs.contains(id))
      instance.favouriteIDs.add(id);
    favouritesCount.value = instance.favouriteIDs.length;
  }

  static void removeFavourite(int id){
    if (instance.favouriteIDs.contains(id))
      instance.favouriteIDs.remove(id);
    favouritesCount.value = instance.favouriteIDs.length;
  }

  //Functions for cache read,save and delete
  static Future<void> saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(sharedPrefsKey, json.encode(toMap()));
    print("[User] - state saved");
  }

  static Future<void> deleteState() async {
    instance.favouriteIDs = [];

    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(sharedPrefsKey)) {await prefs.remove(sharedPrefsKey);}
    await prefs.clear();
    print("[User] - state deleted");
  }

  static Future readState() async{
    final prefs = await SharedPreferences.getInstance();
    try {
      if (prefs.containsKey(sharedPrefsKey)) {
        User.fromJson(prefs.getString(sharedPrefsKey));
        print("[User] - state read");
      }
    }
    catch (e,trace){
      print("[User] - read state error: $e");
      print("[User] - read state error: $trace");
    }
  }
}