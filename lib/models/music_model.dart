import 'package:audio_metadata_reader/audio_metadata_reader.dart';

class MusicModel {
  String? id;
  String? title;
  String? artist;
  String? album;
  String? genre;
  int? year;
  String? duration;
  String? filePath;
  Picture? coverImage;

  MusicModel({
    this.id,
    this.title,
    this.artist,
    this.album,
    this.genre,
    this.year,
    this.duration,
    this.filePath,
    this.coverImage,
  });

  MusicModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    artist = json['artist'];
    album = json['album'];
    genre = json['genre'];
    year = json['year'];
    duration = json['duration'];
    filePath = json['filePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['artist'] = artist;
    data['album'] = album;
    data['genre'] = genre;
    data['year'] = year;
    data['duration'] = duration;
    data['filePath'] = filePath;
    return data;
  }
}
