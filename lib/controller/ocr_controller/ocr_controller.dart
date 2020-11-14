import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/config/router/application.dart';
import 'package:lorapark_app/config/router/routes.dart';
import 'package:lorapark_app/utils/scanner_utils/scanner_utils.dart';

class OcrController extends ChangeNotifier {
  final TextRecognizer _textRecognizer =
      FirebaseVision.instance.textRecognizer();
  final CameraLensDirection _direction = CameraLensDirection.back;

  CameraController _camera;
  bool _isDetecting = false;
  VisionText _detectedText;
  String _recognizedSensorNumber;

  CameraController get camera => _camera;

  bool get isCameraInitialized => _camera != null;

  VisionText get detectedText => _detectedText;

  String get recognizedSensorNumber => _recognizedSensorNumber;

  double get cameraHeight => _camera.value.previewSize.height;

  double get cameraWidth => _camera.value.previewSize.width;

  bool get isStreaming => _camera.value.isStreamingImages;

  Future<void> initializeCamera() async {
    var description = await ScannerUtils.getCamera(_direction);

    _camera = CameraController(
      description,
      ResolutionPreset.high,
      enableAudio: false,
    );
    await _camera.initialize();
    _startDetecting(description);
  }

  Future<void> closeCameraAndStream() async {
    if (_camera.value.isStreamingImages) {
      await _camera.stopImageStream();
    }
    await _camera.dispose();

    _detectedText = null;
  }

  bool detectedTextFollowsPattern() {
    var detectedText =
        _detectedText.text.replaceAll('\n', ' ').trim().toLowerCase();
    var pattern = RegExp('# *\\d\\d+.*lorapark(?:\.de)?');

    if (detectedText.contains(pattern)) {
      _recognizedSensorNumber = _getSensorNumberFromDetectedText(detectedText);
      return true;
    }

    return false;
  }

  bool recognizedSensorIsUnavailable() {
    return Application.router
            .match(Routes.sensorPage + _recognizedSensorNumber) ==
        null;
  }

  void _startDetecting(CameraDescription description) {
    _camera.startImageStream((image) {
      if (_isDetecting) {
        return;
      }

      _isDetecting = true;

      ScannerUtils.detect(
        image: image,
        detectInImage: _getDetectionMethod(),
        imageRotation: description.sensorOrientation,
      ).then((scanResult) {
        if (scanResult != null) {
          _detectedText = scanResult;
        }
        notifyListeners();
      }).whenComplete(() => _isDetecting = false);
    });
  }

  Future<VisionText> Function(FirebaseVisionImage image) _getDetectionMethod() {
    return _textRecognizer.processImage;
  }

  String _getSensorNumberFromDetectedText(String detectedText) {
    var numberPattern = RegExp('# *\\d\\d+');
    var number = numberPattern.stringMatch(detectedText).replaceAll(' ', '');
    return number.split('#').last;
  }
}
