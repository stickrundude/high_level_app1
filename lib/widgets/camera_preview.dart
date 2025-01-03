import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';

class CameraPreviewWidget extends StatelessWidget {
  final bool isGalleryImageSelected;
  final String? selectedImagePath;
  final CameraController controller;
  final double containerWidth;
  final double containerHeight;

  const CameraPreviewWidget({
    required this.isGalleryImageSelected,
    required this.selectedImagePath,
    required this.controller,
    required this.containerWidth,
    required this.containerHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isGalleryImageSelected
          ? LayoutBuilder(
              builder: (context, constraints) {
                return Image.file(
                  File(selectedImagePath!),
                  fit: BoxFit.contain,
                  width: containerWidth,
                  height: containerHeight,
                );
              },
            )
          : _buildCameraContainer(context),
    );
  }

  Widget _buildCameraContainer(BuildContext context) {
    return Container(
      width: containerWidth,
      height: containerHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: CameraPreview(controller),
      ),
    );
  }
}
