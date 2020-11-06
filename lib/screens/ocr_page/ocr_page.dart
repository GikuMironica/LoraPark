import 'package:camera/camera.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/config/router/application.dart';
import 'package:lorapark_app/config/router/routes.dart';
import 'package:lorapark_app/controller/ocr_controller/ocr_controller.dart';
import 'package:lorapark_app/utils/ui/text_detector_painter.dart';
import 'package:provider/provider.dart';

class OcrPage extends StatefulWidget {
  @override
  _OcrPageState createState() => _OcrPageState();
}

class _OcrPageState extends State<OcrPage> with SingleTickerProviderStateMixin {
  OcrController _ocrController;

  @override
  void dispose() {;
    _ocrController.closeCameraAndStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _ocrController = Provider.of<OcrController>(
      context,
      listen: false,
    );

    return Scaffold(
      body: FutureBuilder(
        future: _ocrController.initializeCamera(),
        builder: (context, snapshot) => Stack(
          fit: StackFit.expand,
          children: [
            _ocrController.isCameraInitialized
                ? Container(
                    height: MediaQuery.of(context).size.height - 150,
                    child: CameraPreview(_ocrController.camera),
                  )
                : Container(color: Colors.black),
            Consumer<OcrController>(
              builder: (_, __, ___) => _ocrController.isCameraInitialized &&
                  _ocrController.isStreaming
                  ? _buildResults()
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResults() {
    if (_ocrController.detectedText != null) {
      var imageSize = Size(
        _ocrController.cameraHeight - 100,
        _ocrController.cameraWidth,
      );
      var painter = TextDetectorPainter(imageSize, _ocrController.detectedText);

      if (_ocrController.detectedTextFollowsPattern()) {
        _navigateToSensorPage();
      }

      return CustomPaint(painter: painter);
    }

    return Container();
  }

  void _navigateToSensorPage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _ocrController.closeCameraAndStream();
      Application.router.navigateTo(
        context,
        Routes.sensorPage + _ocrController.recognizedSensorNumber,
        replace: true,
        transition: TransitionType.cupertino,
      );
    });
  }
}
