import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/api_service.dart';
import '../model/models.dart';

class Player {
  final String name;
  final String role;
  final String battingStyle;
  final String bowlingStyle;

  Player(this.name, this.role, this.battingStyle, this.bowlingStyle);
}

class PlayingEleven extends StatefulWidget {
  @override
  _PlayingElevenState createState() => _PlayingElevenState();
}

class _PlayingElevenState extends State<PlayingEleven> {
  // late Future<List<Squad>> _squads;
  // String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    // _squads = APIService.fetchSquads(
    //   'https://demo.sportz.io/sapk01222019186652.json',
    // );
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: const Color(0xFFFAFAFA),
          elevation: 0.0,
          title: const Text(
            "Teams",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.black,
            dividerColor: Colors.blueAccent,
            tabs: [
              Tab(
                text: 'India',
              ),
              Tab(text: 'New Zealand'),
              Tab(text: 'All Players'),
            ],
          ),
        ),
        body: FutureBuilder<List<Squad>>(
          //future: _squads,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading squads'));
            } else {
              //final squads = snapshot.data!;
              return TabBarView(
                children: [
                  IndiaTab(),
                  NewZealandTab(),
                  AllPlayersTab(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class IndiaTab extends StatelessWidget {
  final List<Player> indiaPlayers = [
    Player('Dhoni', 'Captain/WK', 'Right-hand bat', 'Right-arm medium'),
    Player('Kohli', 'Batting', 'Right-hand bat', 'Right-arm medium'),
    Player('Rohit', 'Batting', 'Right-hand bat', 'Right-arm off-spin'),
    Player('Rahul', 'WK', 'Right-hand bat', 'Right-arm medium'),
    Player('Pant', 'Batting/WK', 'Left-hand bat', 'Right-arm medium'),
    Player('Jadeja', 'Batting/Bowling', 'Left-hand bat', 'Left-arm orthodox'),
    Player('Ashwin', 'Bowling', 'Right-hand bat', 'Right-arm off-spin'),
    Player('Bumrah', 'Bowling', 'Right-hand bat', 'Right-arm fast'),
    Player('Shami', 'Bowling', 'Right-hand bat', 'Right-arm fast-medium'),
    Player('Iyer', 'Batting', 'Right-hand bat', 'Right-arm leg-spin'),
    Player('Chahal', 'Bowling', 'Right-hand bat', 'Right-arm leg-spin'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: indiaPlayers.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(indiaPlayers[index].name),
          subtitle: Text(indiaPlayers[index].role),
          onTap: () {
            _showPlayerDetailsDialog(context, indiaPlayers[index]);
          },
        );
      },
    );
  }
}

class NewZealandTab extends StatelessWidget {
  final List<Player> nzPlayers = [
    Player('Southee', 'Captain/Bowling', 'Right-hand bat',
        'Right-arm fast-medium'),
    Player('Williamson', 'Batting', 'Right-hand bat', 'Right-arm off-spin'),
    Player('Taylor', 'Batting', 'Right-hand bat', 'Right-arm off-spin'),
    Player('Dane', 'WK', 'Right-hand bat', 'N/A'),
    Player(
        'Neesham', 'Batting/Bowling', 'Left-hand bat', 'Right-arm medium-fast'),
    Player('Santner', 'Batting/Bowling', 'Left-hand bat', 'Left-arm orthodox'),
    Player('Blundell', 'Batting', 'Right-hand bat', 'N/A'),
    Player('Conway', 'Batting', 'Left-hand bat', 'N/A'),
    Player('Wagner', 'Bowling', 'Right-hand bat', 'Left-arm fast-medium'),
    Player('Boult', 'Bowling', 'Right-hand bat', 'Left-arm fast'),
    Player('Latham', 'Batting', 'Left-hand bat', 'N/A'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: nzPlayers.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(nzPlayers[index].name),
          subtitle: Text(nzPlayers[index].role),
          onTap: () {
            _showPlayerDetailsDialog(context, nzPlayers[index]);
          },
        );
      },
    );
  }
}

class AllPlayersTab extends StatelessWidget {
  final List<Player> allPlayers = [
    ...IndiaTab().indiaPlayers,
    ...NewZealandTab().nzPlayers,
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allPlayers.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(allPlayers[index].name),
          subtitle: Text(allPlayers[index].role),
          onTap: () {
            _showPlayerDetailsDialog(context, allPlayers[index]);
          },
        );
      },
    );
  }
}

void _showPlayerDetailsDialog(BuildContext context, Player player) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(player.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Batting Style: ${player.battingStyle}'),
            Text('Bowling Style: ${player.bowlingStyle}'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}
