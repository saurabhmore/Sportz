import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/models.dart';

class APIService {
  static fetchMatchDetails(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData;
      //   Match(
      //   teamA: jsonData['teamA'].toString(),
      //   teamB: jsonData['teamB'].toString(),
      //   matchDate: jsonData['matchDate'].toString(),
      //   venue: jsonData['venue'].toString(),
      // );
    } else {
      throw Exception('Failed to load match details');
    }
  }

  static Future<List<Squad>> fetchSquads(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final squads = <Squad>[];
      var abc = jsonData['Teams'];
      print(abc.length);

      // for (int i = 0; i < abc.length; i++) {
      //   print("ydfuysddubbdhb");
      //   print(abc[i].Name_Full);
      // }
      for (final teamData in abc) {
      final teamName = teamData['teamName'];
      final playersData = teamData['players'];
      final players = <Player>[];
      print("ydfuysddubbdhb");
      for (final playerData in playersData) {
        players.add(
          Player(
            name: playerData['name'].toString(),
            role: playerData['role'].toString(),
            battingStyle: playerData['battingStyle'].toString(),
            bowlingStyle: playerData['bowlingStyle'].toString(),
          ),
        );
      }

      squads.add(Squad(teamName: teamName, players: players));
      }
      return squads;
    } else {
      throw Exception('Failed to load squads');
    }
  }
}
