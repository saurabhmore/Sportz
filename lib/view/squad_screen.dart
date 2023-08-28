import 'package:flutter/material.dart';

import '../controller/api_service.dart';
import '../model/models.dart';

class SquadScreen extends StatefulWidget {
  @override
  _SquadScreenState createState() => _SquadScreenState();
}

class _SquadScreenState extends State<SquadScreen> {
  late Future<List<Squad>> _squads;
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _squads = APIService.fetchSquads(
      'https://demo.sportz.io/sapk01222019186652.json',
    );
  }

  List<Player> getFilteredPlayers(List<Player> players) {
    if (_selectedFilter == 'All') {
      return players;
    } else {
      return players.where((player) => player.role == _selectedFilter).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0.0,
        title: const Text(
          "Teams",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        
      ),
      body: FutureBuilder<List<Squad>>(
        future: _squads,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading squads'));
          } else {
            final squads = snapshot.data!;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: _selectedFilter,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedFilter = newValue!;
                      });
                    },
                    items: <String>[
                      'All',
                      'Batsman',
                      'Bowler',
                      'All-rounder',
                      'Wicket Keeper',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: squads.length,
                    itemBuilder: (context, index) {
                      final squad = squads[index];
                      final filteredPlayers = getFilteredPlayers(squad.players);
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                squad.teamName,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Divider(),
                            for (final player in filteredPlayers)
                              ListTile(
                                title: Text(player.name),
                                subtitle: Text(player.battingStyle),
                                trailing: Text(player.bowlingStyle),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(player.name),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                'Batting Style: ${player.battingStyle}'),
                                            Text(
                                                'Bowling Style: ${player.bowlingStyle}'),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Close'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
