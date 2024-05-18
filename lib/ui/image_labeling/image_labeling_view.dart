import 'package:flutter/material.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:yz_app_jam/common/utils.dart';
import 'package:yz_app_jam/ui/Sorgulama/sorgu_view.dart';
import 'package:yz_app_jam/ui/image_labeling/detector_view.dart';
import 'package:yz_app_jam/ui/login/login_view.dart';

class ImageLabelingView extends StatefulWidget {
  const ImageLabelingView({super.key});

  @override
  State<ImageLabelingView> createState() => _ImageLabelingViewState();
}

class _ImageLabelingViewState extends State<ImageLabelingView> {
  late ImageLabeler _imageLabeler;
  bool _canProccess = false;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;

  @override
  void initState() {
    super.initState();
    _initializeLabeler();
  }

  @override
  void dispose() {
    _canProccess = false;
    _imageLabeler.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff20AE67),
      body: Container(
        child: DetectorView(
          title: "Image Labeler",
          customPaint: _customPaint,
          text: _text,
          onImage: _processImage,
        ),
      ),
    );
  }

  Future<void> _initializeLabeler() async {
    final path = 'assets/lite-model_models_mushroom-identification_v1_1.tflite';
    final modelPath = await getAssetPath(path);
    final options = LocalLabelerOptions(modelPath: modelPath);
    _imageLabeler = ImageLabeler(options: options);

    _canProccess = true;
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProccess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final labels = await _imageLabeler.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = LabelDetectorPainter(labels);
      _customPaint = CustomPaint(painter: painter);
    } else {
      String text = 'Labels found: ${labels.length}\n\n';
      for (final label in labels) {
        text += 'Label: ${label.label}, '
            'Confidence: ${label.confidence.toStringAsFixed(2)}\n\n';
      }
      _text = text;
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
