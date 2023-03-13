import 'dart:convert';

import 'exceptions.dart';

typedef ProgressCallback = void Function(double progressPercent);

class DirectUploadResponse {
  final String signedId;
  final String uploadUrl;
  final Map<String, String> headers;

  DirectUploadResponse({
    required this.signedId,
    required this.uploadUrl,
    required this.headers,
  });

  factory DirectUploadResponse.fromJson(String utf8Text) {
    try {
      var parsed = json.decode(utf8Text);
      return DirectUploadResponse(
        signedId: parsed['signedId'],
        uploadUrl: parsed['direct_upload']['url'],
        headers: Map<String, String>.from(parsed['direct_upload']['headers']),
      );
    } on FormatException catch (e) {
      throw InvalidDataReceived(e.message);
    }
  }
}

class DirectUploadRequest {
  final String fileName;
  final String contentType;
  final int byteSize;
  final String checksum;

  DirectUploadRequest({
    required this.fileName,
    required this.contentType,
    required this.byteSize,
    required this.checksum,
  });

  String toJson() => json.encode({
        'blob': {
          'filename': fileName,
          'content_type': contentType,
          'byte_size': byteSize,
          'checksum': checksum,
        }
      });
}
