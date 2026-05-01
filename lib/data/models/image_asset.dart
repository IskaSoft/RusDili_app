import 'dart:typed_data';
import '../../core/constants/db_constants.dart';

/// Represents an image stored in the app_images table.
/// Images can be loaded from assets (imagePath) or from BLOB (imageBlob).
class AppImage {
  final int id;
  final String imageKey;
  final String? imagePath;
  final Uint8List? imageBlob;
  final int? width;
  final int? height;
  final String? descriptionTk;

  const AppImage({
    required this.id,
    required this.imageKey,
    this.imagePath,
    this.imageBlob,
    this.width,
    this.height,
    this.descriptionTk,
  });

  factory AppImage.fromMap(Map<String, dynamic> map) {
    return AppImage(
      id: map[DbConstants.colId] as int,
      imageKey: map[DbConstants.colImageKey] as String,
      imagePath: map[DbConstants.colImagePath] as String?,
      imageBlob: map[DbConstants.colImageBlob] as Uint8List?,
      width: map[DbConstants.colWidth] as int?,
      height: map[DbConstants.colHeight] as int?,
      descriptionTk: map[DbConstants.colDescriptionTk] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      DbConstants.colImageKey: imageKey,
      DbConstants.colImagePath: imagePath,
      DbConstants.colImageBlob: imageBlob,
      DbConstants.colWidth: width,
      DbConstants.colHeight: height,
      DbConstants.colDescriptionTk: descriptionTk,
    };
  }

  /// Returns true if this image can be rendered
  bool get hasData => imageBlob != null || imagePath != null;
  bool get hasBlob => imageBlob != null;
  bool get hasAssetPath => imagePath != null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppImage && other.imageKey == imageKey;

  @override
  int get hashCode => imageKey.hashCode;
}
