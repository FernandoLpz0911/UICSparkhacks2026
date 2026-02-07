// Database calls are here
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Starts the first step of the game by creating user instances
  Future<void> createGame({
    required String title, //title of the game
    required String description, // decription/how to play option
    required String playerName, //Saves the player's name
    required int userID, //A unique number(10 digits) generated for the user easily find user
  }) async {
    await _db.collection('projects').add({
      'title': title,
      'description': description,
      'ownerId': userID,
      'ownerName': playerName,
    });
  }

  // Create a new lobby
  Future<void> createLobby({
    required int lobbyCode, //this keeps track of the lobby code that is generated for other users to join
    required String genre, //this is the genre that everyone gets randomly assignes
    required int hostUserId, //this is the host's ID
  }) async {
    await _db.collection('ServerLobby').doc(lobbyCode.toString()).set({
      'lobbyCode': lobbyCode,
      'genre': genre,
      'phase': 'waiting', //what phase the game is at either waiting, writing, voting or ended
      'round': 1, //The round increases if the imposter has not been voted out, until there are only two people left
      'hostUserId': hostUserId,
      'alivePlayers': [hostUserId], //This is where players who are still alive can be stored
      'eliminatedPlayers': [], //This is where players who get eliminated can be stored
    });
  }

  // Join an existing lobby, to join an existing lobby you'll need the host's ID and lobby code
  Future<void> joinLobby({
    required int lobbyCode, //The code required to join another's user's lobby
    required String userId, //The host's userID
  }) async {
    await _db.collection('Server lobby').doc(lobbyCode.toString()).update({
      'alivePlayers': FieldValue.arrayUnion([userId]),// after another user join's, the user is added to the alive players list
    });
  }
}