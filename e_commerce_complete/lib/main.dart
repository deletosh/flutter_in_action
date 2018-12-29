import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_complete/app.dart';
import 'package:e_commerce_complete/blocs/app_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_repository/catalog_service.dart';
import 'package:flutter_firebase_repository/populate_firestore.dart';

/// In this app, we initialize the Firestore, AppBloc, and ServiceProvider
/// right from the start, then inject them into the app.
Future<void> main() async {
  /// Initialize the Firestore database.
  // Todo: Update with my api info
  final FirebaseApp app = await FirebaseApp.configure(
      name: 'e_commerce',
      options: const FirebaseOptions(
        googleAppID: '1:79601577497:ios:5f2bcc6ba8cecddd',
        gcmSenderID: '79601577497',
        apiKey: 'AIzaSyArgmRGfB5kiQT6CunAOmKRVKEsxKmy6YI-G72PVU',
        projectID: 'flutter-firestore',
      ));
  var firestore = new Firestore(app: app);

  /// This method will populate the database with seed data
  /// if and only if there isn't already data in the 'catalog' collection
  populateFirestore(firestore);

  /// Produce services to provide
  var catalogService = new FlutterCatalogService(firestore);

  /// Wrap the app in the AppBloc
  /// An inherited widget which keeps track of
  /// the state of the app, including the
  /// active page, and acts as a Firestore provider throughout the app
  /// And
  /// Give AppBloc the ServiceProvider
  /// Then throughout the App you can access your Firestore Database by calling
  /// var _service = AppBloc.of(context).provider.catalogService
  runApp(
    AppBloc(
      provider: new ServiceProvider(
        catalogService: catalogService,
      ),
      child: ECommerceApp(),
    ),
  );
}
