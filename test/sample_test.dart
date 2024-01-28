// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:expensetracker/core/utils/firebase_query_handler.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// class MockCollectionReference extends Mock implements CollectionReference {}

// class MockDocumentReference extends Mock implements DocumentReference {}

// void main() {
//   group('addDocumentToCollection', () {
//     late MockCollectionReference mockCollectionReference;
//     late MockDocumentReference mockDocumentReference;

//     setUp(() {
//       mockCollectionReference = MockCollectionReference();
//       mockDocumentReference = MockDocumentReference();
//       when(mockCollectionReference.add(any))
//           .thenAnswer((_) async => mockDocumentReference);
//       when(mockDocumentReference.id).thenReturn('documentID');
//       FirebaseQueryHelper.firebaseFireStore =
//           MockFirebaseFirestore(mockCollectionReference);
//     });

//     test('adds document to collection', () async {
//       // Arrange
//       final data = {'name': 'John', 'age': 30};
//       const collectionID = 'users';

//       // Act
//       await FirebaseQueryHelper.addDocumentToCollection(
//           data: data, collectionID: collectionID);

//       // Assert
//       verify(mockCollectionReference.add(data)).called(1);
//       expect(mockDocumentReference.id, 'documentID');
//     });

//     test('handles error', () async {
//       // Arrange
//       final data = {'name': 'John', 'age': 30};
//       const collectionID = 'users';
//       const errorMessage = 'Error adding document to collection';

//       // Set up mock to throw error
//       when(mockCollectionReference.add(any)).thenThrow(errorMessage);

//       // Act
//       await FirebaseQueryHelper.addDocumentToCollection(
//           data: data, collectionID: collectionID);

//       // Assert
//       verify(mockCollectionReference.add(data)).called(1);
//       expect(
//         () async => await FirebaseQueryHelper.addDocumentToCollection(
//             data: data, collectionID: collectionID),
//         throwsA(errorMessage),
//       );
//     });
//   });
// }
