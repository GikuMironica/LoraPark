import 'package:camera/camera.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/config/router/application.dart';
import 'package:lorapark_app/config/router/routes.dart';
import 'package:lorapark_app/controller/ocr_controller/ocr_controller.dart';
import 'package:provider/provider.dart';
import 'package:lorapark_app/utils/ui/inverted_rectangle_clipper.dart';

class OcrPage extends StatefulWidget {
  @override
  _OcrPageState createState() => _OcrPageState();
}

class _OcrPageState extends State<OcrPage> with SingleTickerProviderStateMixin {
  OcrController _ocrController;

  @override
  void dispose() async {
    super.dispose();
    await _ocrController.closeCameraAndStream();
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
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 80,
                height: MediaQuery.of(context).size.width - 80,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Container(
              child: ClipPath(
                clipper: InvertedRectangleClipper(),
                child: Container(
                  color: Color.fromRGBO(0, 0, 0, 0.7),
                ),
              ),
            ),
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      color: Colors.white54,
                      size: 30,
                    ),
                    onPressed: () {
                      Application.router.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Consumer<OcrController>(
              builder: (_, __, ___) => _checkDetectedText(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _checkDetectedText() {
    if (_ocrController.isCameraInitialized && _ocrController.isStreaming) {
      if (_ocrController.detectedText != null &&
          _ocrController.detectedTextFollowsPattern()) {
        if (_ocrController.recognizedSensorIsUnavailable()) {
          return _sensorUnavailableWidget();
        } else {
          _navigateToSensorPage();
        }
      }
    }

    return Container();
  }

  Widget _sensorUnavailableWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Color(0xffd35668),
            size: 36,
          ),
          const SizedBox(width: 5),
          Text(
            'Sensor unavailable',
            style: TextStyle(
              color: Color(0xffd35668),
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
            overflow: TextOverflow.visible,
          ),
        ],
      ),
    );
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
