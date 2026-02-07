// Database calls are here
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Creates a new lobby. Called when host clicks on create lobby
  /// Database Directory = ServerLobby/.doc '' fields
  Future<void> createLobby({
    required int lobbyCode, 
    required String genre, 
    required int hostUserId,
  }) async {
    await _db.collection('ServerLobby').doc(lobbyCode.toString()).set({
      'lobbyCode': lobbyCode,
      'PlayerGenres': genre,
      'PlayerPhase': 'waiting',
      'round': 1,
      'hostUserId': hostUserId,
      'serverTimerStart': null, // Initialized as null to start off
    });
  }

  //Adds a player to the specific lobby
  //is is called when a player joins a lobby
  Future<void> addPlayer({
  required int lobbyCode,
  required int userId,
  required String name,
}) async {
  await _db
    .collection('ServerLobby')
    .doc(lobbyCode.toString())
    .collection('Players')
    .doc(userId.toString())
    .set({
      'name': name,
      'role': 'crewmate', // or imposter later
      'isAlive': true,
      'isReady': false,
      'joinedAt': FieldValue.serverTimestamp(),
    });
}

  /// 
  /// It moves the game into the writing phase and starts the timer
  /// Called when the host presses start writing
  Future<void> startWriting(int lobbyCode) async {
    await _db.collection('ServerLobby').doc(lobbyCode.toString()).update({
      'PlayerPhase': 'writing',
      'serverTimerStart': FieldValue.serverTimestamp(),
      'writingDuration': 60,
    });
  }

  //stores one writing submission per player
  //Called when player submits their writing
  Future<void> submitText(
    int lobbyCode,
    int userID,
    String text,
  ) async{
    await _db
      .collection('ServerLobby')
      .doc(lobbyCode.toString())
      .collection('Texts')
      .doc(userID.toString())
      .set({
        'Text' : text,
        ///'submittedAt': Timestamp.now(),
      });
  }

 //Transitions into the voting phase
 //Called after writing ends
  Future<void> startVoting(int lobbyCode) async {
    await _db.collection('ServerLobby').doc(lobbyCode.toString()).update({
      'PlayerPhase': 'voting',
    });
  }

  //Records one vote per alive player
  //called when player clicks the vote button
  Future<void> vote({
    required int lobbyCode,
    required int voterID,
    required String votedForID,
  }) async {
    final server = _db.collection('ServerLobby').doc(lobbyCode.toString());
    
    // run a transaction with the server to cross-reference. More consistency
    return _db.runTransaction((transaction) async {
      final voteDoc = server.collection('Votes').doc(voterID.toString());
      transaction.set(voteDoc, {
        'votedFor': votedForID,
        'timestamp': FieldValue.serverTimestamp(),
      });
    });
  }

  //Marks a player as eliminated
  //Called after votes have been tallied
  Future<void> eliminatePlayer(
    int lobbyCode,
    int userID,
  ) async {
    await _db
      .collection('ServerLobby')
      .doc(lobbyCode.toString())
      .collection('Players')
      .doc(userID.toString())
      .update({
        'isAlive': false,
      });
  }

  //creates a real time listener for lobby changes
  //Called as soon as user enters a lobby screen
  Stream<QuerySnapshot> listenToPlayers(int lobbyCode) {
    return _db
        .collection('ServerLobby')
        .doc(lobbyCode.toString())
        .collection('Players')
        .snapshots();
  }

//Randomly picks one impostor
//Assigns role, personal genre, resets isAlive
//Called when host clicks on Start Game
Future<void> assignRolesAndGenres({
  required int lobbyCode,
  required String mainGenre,
  required String impostorGenre,
}) async {
  final playersRef = _db
      .collection('ServerLobby')
      .doc(lobbyCode.toString())
      .collection('Players');
  final snapshot = await playersRef.get();
  final players = snapshot.docs;
  if (players.length < 3) {
    throw Exception('Not enough players');
  }

  // Pick random impostor
  players.shuffle();
  final impostorId = players.first.id;
  for (var player in players) {
    final isImpostor = player.id == impostorId;
    await playersRef.doc(player.id).update({
      'role': isImpostor ? 'impostor' : 'crewmate',
      'genre': isImpostor ? impostorGenre : mainGenre,
      'isAlive' : true,
    });
  }
}

/// 
/// Setter for the players being ready to begin playing. Sets based off the
/// parameters using the lobbyCode, userID for specific users, and isReady as
/// a boolean to state if that user is ready to play
Future<void> setPlayerReady(int lobbyCode, int userID, bool isReady) async {
    await _db
        .collection('ServerLobby')
        .doc(lobbyCode.toString())
        .collection('Players')
        .doc(userID.toString())
        .update({'isReady': isReady});
  }

// Checks if the writing timer has expired
// Allows host to suto transition phases
// Called periodically by the host UI
Future<bool> isWritingTimeOver(int lobbyCode) async {
  final lobbyDoc = await _db
      .collection('ServerLobby')
      .doc(lobbyCode.toString())
      .get();
  
  final Timestamp? start = lobbyDoc['serverTimerStart'];
  if (start == null) return false;

  final int duration = lobbyDoc['writingDuration'];
  final now = DateTime.now(); 
  
  return now.difference(start.toDate()).inSeconds >= duration;
}

//Fetches all submitted texts for the round
//Called after writing phase ends
Future<List<Map<String, dynamic>>> getAllTexts(int lobbyCode) async {
  final snapshot = await _db
      .collection('ServerLobby')
      .doc(lobbyCode.toString())
      .collection('Texts')
      .get();
  return snapshot.docs.map((doc) {
    return {
      'userID': doc.id,
      'Text': doc['Text'],
    };
  }).toList();
}

//Counts votes and returns the most voted userID
//Called after voting ends
Future<String?> tallyVotes(int lobbyCode) async {
  final snapshot = await _db
      .collection('ServerLobby')
      .doc(lobbyCode.toString())
      .collection('Votes')
      .get();
  final Map<String, int> voteCount = {};
  for (var doc in snapshot.docs) {
    final votedFor = doc['votedFor'];
    voteCount[votedFor] = (voteCount[votedFor] ?? 0) + 1;
  }
  if (voteCount.isEmpty) return null;
  return voteCount.entries
      .reduce((a, b) => a.value > b.value ? a : b)
      .key;
}

//Crewmates win if no impostor is alive
//The Impostor eins if there's only one more crewmate left
//Called after elimination
Future<String?> checkWinCondition(int lobbyCode) async {
  final playersSnapshot = await _db
      .collection('ServerLobby')
      .doc(lobbyCode.toString())
      .collection('Players')
      .get();
  final alivePlayers = playersSnapshot.docs
      .where((p) => p['isAlive'] == true)
      .toList();
  final aliveImpostors = alivePlayers.where((p) => p['role'] == 'impostor').toList();
  if (aliveImpostors.isEmpty) {
    return 'crewmate';
  }
  if (alivePlayers.length == 2 && aliveImpostors.length == 1) {
    return 'impostor';
  }
  return null; // game continues
}

//Prepares for next round
//Prevents data leaks
//Called between rounds
Future<void> clearRoundData(int lobbyCode) async {
  final texts = await _db
      .collection('ServerLobby')
      .doc(lobbyCode.toString())
      .collection('Texts')
      .get();
  for (var doc in texts.docs) {
    await doc.reference.delete();
  }
  final votes = await _db
      .collection('ServerLobby')
      .doc(lobbyCode.toString())
      .collection('Votes')
      .get();
  for (var doc in votes.docs) {
    await doc.reference.delete();
  }
}

//Increments round number
//Restarts writing phase
//Resets timer
//Called if no win condition is met
Future<void> nextRound(int lobbyCode) async {
  await _db.collection('ServerLobby').doc(lobbyCode.toString()).update({
    'round': FieldValue.increment(1),
    'PlayerPhase': 'writing',
    'startedWritingAt': Timestamp.now(),
  });
}
}