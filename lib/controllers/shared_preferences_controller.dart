import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

ValueNotifier<int> favouritesCount = ValueNotifier(SharedPreferencesController.instance.favouriteIDs.length);

class SharedPreferencesController{
  //shared preferences (app cache) state storage key
  static String get sharedPrefsKey => "PokedexUserStateSPKey";

  //Making the singleton
  //1. Internal constructor
  SharedPreferencesController._internal();
  //2. static instance variable
  static SharedPreferencesController instance = SharedPreferencesController._internal();
  //3. properties and factory constructor
  List<int> favouriteIDs = [];
  String? firebaseUID = "";
  factory SharedPreferencesController({List<int>? favouriteIDs, String? firebaseUID}){
    instance.favouriteIDs = favouriteIDs ?? instance.favouriteIDs;
    instance.firebaseUID = firebaseUID ?? instance.firebaseUID;
    return instance;
  }

  //serialization methods
  static Map<String, dynamic> toMap() => {"ids" : instance.favouriteIDs.toList(), "firebaseUID": instance.firebaseUID ?? FirebaseAuth.instance.currentUser?.uid};

  static void fromJson(String? jsonMap){
    try{
      if (jsonMap != null){
        instance.favouriteIDs.clear();
        final localFavourites = json.decode(jsonMap);
        if (localFavourites["firebaseUID"] != null && localFavourites['firebaseUID'] == FirebaseAuth.instance.currentUser?.uid){
          localFavourites['ids']?.forEach((id){instance.favouriteIDs.add(id);});
        }
        else {
          instance.favouriteIDs.clear();
          deleteState();
        }
      }
      else instance.favouriteIDs.clear();
    }
    catch (e,trace){
      print("[USER] - fromJson error $e\n$trace");
    }
  }

  // for new user
  static void setUserId(String? uid) async {
    if (uid != null) instance.firebaseUID = uid;
    await saveState();
  }

  //functions for adding/removing favourite
  static void addFavourite(int? id) async {
    if (id != null && !instance.favouriteIDs.contains(id))
      instance.favouriteIDs.add(id);
    favouritesCount.value = instance.favouriteIDs.length;
    await saveState();
  }

  static void removeFavourite(int? id) async {
    if (id != null && instance.favouriteIDs.contains(id))
      instance.favouriteIDs.remove(id);
    favouritesCount.value = instance.favouriteIDs.length;
    await saveState();
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
        fromJson(prefs.getString(sharedPrefsKey));
        print("[User] - state read");
      }
    }
    catch (e,trace){
      print("[User] - read state error: $e");
      print("[User] - read state error: $trace");
    }
  }
}
