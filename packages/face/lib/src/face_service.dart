import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_face_api/face_api.dart' as regula;
import 'package:flutter_face_api/face_api.dart';
import 'package:meta_club_api/meta_club_api.dart';

class FaceService {

  FaceService(){
    _initPlatformState();
  }

  void captureFromFaceApi({required bool isRegistered,String? regImage, required MetaClubApiClient metaClubApiClient,required Function(String) onCaptured,required Function(bool) isSimilar}){
    regula.FaceSDK.presentFaceCaptureActivity().then((result) {
      var response = regula.FaceCaptureResponse.fromJson(json.decode(result))!;
      if (response.image != null && response.image!.bitmap != null){
        var image2 = response.image!.bitmap!.replaceAll("\n", "");
        onCaptured(image2);
        var registeredImage = regula.MatchFacesImage();
        registeredImage.imageType = ImageType.LIVE;
        var currentImage = regula.MatchFacesImage();
        registeredImage.imageType = ImageType.LIVE;
        if(isRegistered){
          registeredImage.bitmap = regImage;
          currentImage.bitmap = image2;
          _matchFaces(registeredImage: registeredImage, currentFace: currentImage, isSimilar: isSimilar);
        }else{
          isSimilar(false);
        }
      }
    });
  }

  void _matchFaces({required regula.MatchFacesImage registeredImage,required regula.MatchFacesImage currentFace, required Function(bool) isSimilar}) {
    var request =  regula.MatchFacesRequest();
    request.images = [registeredImage, currentFace];
    regula.FaceSDK.matchFaces(jsonEncode(request)).then((value) {
      var response = regula.MatchFacesResponse.fromJson(json.decode(value));
      regula.FaceSDK.matchFacesSimilarityThresholdSplit(jsonEncode(response!.results), 0.75).then((str) {
        var split = regula.MatchFacesSimilarityThresholdSplit.fromJson(json.decode(str));
        isSimilar(split!.matchedFaces.isNotEmpty);
      });
      onFaceAPiException(exception: response.exception);
    });
  }

  void onFaceAPiException({required regula.MatchFacesException? exception}){
    if (exception != null) {
      switch (exception.errorCode) {
        case LivenessErrorCode.CANCELLED:
          debugPrint('User cancelled the processing.');
          break;
        case LivenessErrorCode.NO_LICENSE:
          debugPrint('Web Service is missing a valid License.');
          break;
        case LivenessErrorCode.PROCESSING_TIMEOUT:
          debugPrint('Reached the number of possible attempts. See `Liveliness Configuration.attemptsCount` for more information.');
          break;
        case LivenessErrorCode.PROCESSING_FAILED:
          debugPrint('Bad input data.');
          break;
        case LivenessErrorCode.API_CALL_FAILED:
          debugPrint('Web Service API call failed due to networking error or backend internal error.');
          break;
        case LivenessErrorCode.CONTEXT_IS_NULL:
          debugPrint('Provided context is null.');
          break;
        case LivenessErrorCode.IN_PROGRESS_ALREADY:
          debugPrint('Liveness has already started.');
          break;
        case LivenessErrorCode.ZOOM_NOT_SUPPORTED:
          debugPrint('Camera zoom support is required.');
          break;
      }
    }
  }

  Future<void> _initPlatformState() async {
    regula.FaceSDK.init().then((json) {
      var response = jsonDecode(json);
      if (!response["success"]) {
        debugPrint("face initialization failed $json");
      }else{
        debugPrint("face initialization success $json");
      }
    });
  }
}