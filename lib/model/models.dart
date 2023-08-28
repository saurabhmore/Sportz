// models.dart
class Match {
  final String teamA;
  final String teamB;
  final String matchDate;
  final String venue;

  Match({
    required this.teamA,
    required this.teamB,
    required this.matchDate,
    required this.venue,
  });
}

class Player {
  final String name;
  final String role;
  final String battingStyle;
  final String bowlingStyle;

  Player({
    required this.name,
    required this.role,
    required this.battingStyle,
    required this.bowlingStyle,
  });
}

class Squad {
  final String teamName;
  final List<Player> players;

  Squad({
    required this.teamName,
    required this.players,
  });
}

// class Squad {
//   final String teamName;
//   final players;

//   Squad({
//     required this.teamName,
//     required this.players,
//   });

//   factory Squad.fromJson(Map<String, dynamic> json) => Squad(
//         teamName: json["Name_Full"].toString(),
//         players: json["Players"],
//       );
// }
