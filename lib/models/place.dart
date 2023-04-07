import 'dart:io';

import './place_location.dart';

class Place {
  final String id;
  final String title;
  final PlaceLocation? location;
  //cihazda depolanan resimlerle calisacagimiz icin File veri turunu kullandik cunku her image cihazimizdaki bir dosyadir
  final File image;

  Place(
      {required this.id,
      required this.title,
      required this.location,
      required this.image});
}
