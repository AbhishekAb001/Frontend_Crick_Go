import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cricket_management/controllers/live_score_controller.dart';

class LiveScoreAdminScreen extends StatefulWidget {
  const LiveScoreAdminScreen({super.key});

  @override
  State<LiveScoreAdminScreen> createState() => _LiveScoreAdminScreenState();
}

class _LiveScoreAdminScreenState extends State<LiveScoreAdminScreen> {
  final LiveScoreController _liveScoreController =
      Get.put(LiveScoreController());
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final _score1Controller = TextEditingController();
  final _score2Controller = TextEditingController();
  final _overs1Controller = TextEditingController();
  final _overs2Controller = TextEditingController();
  final _wickets1Controller = TextEditingController();
  final _wickets2Controller = TextEditingController();

  // New match form controllers
  final _team1Controller = TextEditingController();
  final _team2Controller = TextEditingController();
  final _venueController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  String? selectedMatchId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Live Score Admin Panel',
          style: GoogleFonts.lato(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1A237E),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddMatchDialog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Match Selection Dropdown
            Obx(() => DropdownButtonFormField<String>(
                  value: selectedMatchId,
                  decoration: InputDecoration(
                    labelText: 'Select Match',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: _liveScoreController.liveMatches.map((match) {
                    return DropdownMenuItem<String>(
                      value: match['id'],
                      child: Text('${match['team1']} vs ${match['team2']}'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMatchId = value;
                      if (value != null) {
                        final match =
                            _liveScoreController.getMatchDetails(value);
                        if (match != null) {
                          _score1Controller.text = match['score1'];
                          _score2Controller.text = match['score2'];
                          _overs1Controller.text = match['overs1'];
                          _overs2Controller.text = match['overs2'];
                          _wickets1Controller.text =
                              match['wickets1'].toString();
                          _wickets2Controller.text =
                              match['wickets2'].toString();
                        }
                      }
                    });
                  },
                )),
            const SizedBox(height: 20),
            // Score Update Form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _score1Controller,
                          decoration: InputDecoration(
                            labelText: 'Team 1 Score',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter score';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _score2Controller,
                          decoration: InputDecoration(
                            labelText: 'Team 2 Score',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter score';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _overs1Controller,
                          decoration: InputDecoration(
                            labelText: 'Team 1 Overs',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter overs';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _overs2Controller,
                          decoration: InputDecoration(
                            labelText: 'Team 2 Overs',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter overs';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _wickets1Controller,
                          decoration: InputDecoration(
                            labelText: 'Team 1 Wickets',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter wickets';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _wickets2Controller,
                          decoration: InputDecoration(
                            labelText: 'Team 2 Wickets',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter wickets';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              selectedMatchId != null) {
                            _liveScoreController.updateScore(
                              selectedMatchId!,
                              score1: _score1Controller.text,
                              score2: _score2Controller.text,
                              overs1: _overs1Controller.text,
                              overs2: _overs2Controller.text,
                              wickets1:
                                  int.tryParse(_wickets1Controller.text) ?? 0,
                              wickets2:
                                  int.tryParse(_wickets2Controller.text) ?? 0,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Score updated successfully')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A237E),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                        ),
                        child: Text(
                          'Update Score',
                          style: GoogleFonts.lato(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (selectedMatchId != null) {
                            _liveScoreController
                                .completeMatch(selectedMatchId!);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Match marked as completed')),
                            );
                            setState(() {
                              selectedMatchId = null;
                              _clearForm();
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                        ),
                        child: Text(
                          'Complete Match',
                          style: GoogleFonts.lato(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (selectedMatchId != null) {
                            _liveScoreController.deleteMatch(selectedMatchId!);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Match deleted successfully')),
                            );
                            setState(() {
                              selectedMatchId = null;
                              _clearForm();
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                        ),
                        child: Text(
                          'Delete Match',
                          style: GoogleFonts.lato(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _clearForm() {
    _score1Controller.clear();
    _score2Controller.clear();
    _overs1Controller.clear();
    _overs2Controller.clear();
    _wickets1Controller.clear();
    _wickets2Controller.clear();
  }

  void _showAddMatchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Add New Match',
          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _team1Controller,
                decoration: const InputDecoration(labelText: 'Team 1'),
              ),
              TextField(
                controller: _team2Controller,
                decoration: const InputDecoration(labelText: 'Team 2'),
              ),
              TextField(
                controller: _venueController,
                decoration: const InputDecoration(labelText: 'Venue'),
              ),
              TextField(
                controller: _dateController,
                decoration:
                    const InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
              ),
              TextField(
                controller: _timeController,
                decoration: const InputDecoration(labelText: 'Time (HH:MM)'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _clearNewMatchForm();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_team1Controller.text.isNotEmpty &&
                  _team2Controller.text.isNotEmpty &&
                  _venueController.text.isNotEmpty &&
                  _dateController.text.isNotEmpty &&
                  _timeController.text.isNotEmpty) {
                _liveScoreController.createMatch({
                  'team1': _team1Controller.text,
                  'team2': _team2Controller.text,
                  'venue': _venueController.text,
                  'date': _dateController.text,
                  'time': _timeController.text,
                  'status': 'Live',
                  'battingTeam': _team1Controller.text,
                  'bowlingTeam': _team2Controller.text,
                });
                Navigator.pop(context);
                _clearNewMatchForm();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('New match added successfully')),
                );
              }
            },
            child: const Text('Add Match'),
          ),
        ],
      ),
    );
  }

  void _clearNewMatchForm() {
    _team1Controller.clear();
    _team2Controller.clear();
    _venueController.clear();
    _dateController.clear();
    _timeController.clear();
  }

  @override
  void dispose() {
    _score1Controller.dispose();
    _score2Controller.dispose();
    _overs1Controller.dispose();
    _overs2Controller.dispose();
    _wickets1Controller.dispose();
    _wickets2Controller.dispose();
    _team1Controller.dispose();
    _team2Controller.dispose();
    _venueController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }
}
