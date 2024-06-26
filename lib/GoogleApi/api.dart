import 'dart:typed_data';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:gcloud/storage.dart';
import 'package:mime/mime.dart';

class CloudApi {
  final auth.ServiceAccountCredentials _credentials;
  auth.AutoRefreshingAuthClient? _client;

  CloudApi(String json)
      : _credentials = auth.ServiceAccountCredentials.fromJson(json);

  Future<ObjectInfo> save(String name, Uint8List imgBytes, Map<String, String> metadata) async {
    // Create a client
    _client ??= await auth.clientViaServiceAccount(_credentials, Storage.SCOPES);

    // Instantiate objects to cloud storage
    var storage = Storage(_client!, 'Image Upload Google Storage');
    var bucket = storage.bucket('imagestore_camera');

    // Save to bucket
    final type = lookupMimeType(name);
    return await bucket.writeBytes(name, imgBytes,
        metadata: ObjectMetadata(
          contentType: type,
          custom: metadata,
        ));
  }

  Future<Map<String, String>?> getMetadata(String name) async {
    _client ??= await auth.clientViaServiceAccount(_credentials, Storage.SCOPES);

    var storage = Storage(_client!, 'Image Upload Google Storage');
    var bucket = storage.bucket('imagestore_camera');

    final info = await bucket.info(name);
    return info.metadata.custom;
  }
}