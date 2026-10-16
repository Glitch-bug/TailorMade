import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_made/core/utils/logger.dart';

class SizeConfigState {
  final double screenWidth;
  final double screenHeight;
  final double blockWidth;
  final double blockHeight;

  final double textMultiplier;
  final double imageSizeMultiplier;
  final double heightMultiplier;
  final double widthMultiplier;
  final bool isPortrait;
  final bool isMobilePortrait;


  const SizeConfigState({
    this.screenWidth = 0,
    this.screenHeight = 0,
    this.blockWidth = 0,
    this.blockHeight = 0,
    this.textMultiplier = 0,
    this.imageSizeMultiplier = 0,
    this.heightMultiplier = 0,
    this.widthMultiplier = 0,
    this.isPortrait = false,
    this.isMobilePortrait = false,
  });

}

class SizeConfigCubit extends Cubit<SizeConfigState> {
  SizeConfigCubit() : super(const SizeConfigState());

  Orientation? _currentOrientation;
  BoxConstraints? _currentConstraints;

  void update(BoxConstraints constraints, Orientation orientation) {

    if (_currentOrientation != orientation ||
    _currentConstraints != constraints) {

      _currentConstraints = constraints;
      _currentOrientation = orientation;

      double screenWidth;
      double screenHeight;
      bool isPortrait;


      if (orientation == Orientation.portrait) {
        screenWidth = constraints.maxHeight;
        screenHeight = constraints.maxWidth;
        isPortrait = true;
      } else {
        screenWidth = constraints.maxWidth;
        screenHeight = constraints.maxHeight;
        isPortrait = false;
      }

      final blockWidth = screenWidth / 100;
      final blockHeight = screenHeight / 100;

      logger.d("height: $blockHeight");
      logger.d("width: $blockWidth");

      emit(SizeConfigState(
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        textMultiplier: blockHeight,
        imageSizeMultiplier: blockWidth,
        heightMultiplier: blockHeight,
        widthMultiplier: blockWidth,
        isPortrait: isPortrait,
        isMobilePortrait: isPortrait && (screenWidth < 450)
      ));

    }
  }
}