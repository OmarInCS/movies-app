

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';

class WatchListProvider with ChangeNotifier {

  StreamSubscription<QuerySnapshot>? _moviesSubscription;
  List<Movie> _movies = [];
  List<Movie> get movies => _movies;
  String deviceId;

  WatchListProvider(this.deviceId) {
    _moviesSubscription = FirebaseFirestore.instance
        .collection(deviceId)
        .snapshots()
        .listen((snapshot) {
      _movies = [];
      for (final document in snapshot.docs) {
        var movie = Movie.fromJson(document.data());
        _movies.add(
            movie
        );
      }

      notifyListeners();
    });
  }

  void addMovie({required Movie movie}) {
    FirebaseFirestore
        .instance
        .collection(deviceId)
        .doc(movie.id.toString())
        .set(movie.toJson());
  }

  void deleteMovie({required int movieId}) {
    FirebaseFirestore.instance
        .collection(deviceId)
        .doc(movieId.toString())
        .delete();
  }

  bool isInWatchList({required int movieId}) => movies.where((movie) => movie.id == movieId).isNotEmpty;

}