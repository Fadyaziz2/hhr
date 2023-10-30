import 'dart:convert';
import 'package:flutter_face_api/face_api.dart' as regula;
import 'package:meta_club_api/meta_club_api.dart';

class FaceService {

  void captureFromFaceApi({required bool isRegistered,String? regImage, required MetaClubApiClient metaClubApiClient,required Function(String) onCaptured,required Function(bool) isSimilar}){
    regula.FaceSDK.presentFaceCaptureActivity().then((result) {
      var response = regula.FaceCaptureResponse.fromJson(json.decode(result))!;
      if (response.image != null && response.image!.bitmap != null){
        var image2 = response.image!.bitmap!.replaceAll("\n", "");
        onCaptured(image2);
        var registeredImage = regula.MatchFacesImage();
        var currentImage = regula.MatchFacesImage();
        if(isRegistered){
          registeredImage.bitmap = regImage;
          currentImage.bitmap = image2;
          matchFaces(registeredImage: registeredImage, currentFace: currentImage, isSimilar: isSimilar);
        }else{
          isSimilar(false);
        }
      }
    });
  }

  matchFaces({required regula.MatchFacesImage registeredImage,required regula.MatchFacesImage currentFace, required Function(bool) isSimilar}) {
    var request =  regula.MatchFacesRequest();
    request.images = [registeredImage, currentFace];
    regula.FaceSDK.matchFaces(jsonEncode(request)).then((value) {
      var response = regula.MatchFacesResponse.fromJson(json.decode(value));
      regula.FaceSDK.matchFacesSimilarityThresholdSplit(jsonEncode(response!.results), 0.75).then((str) {
        var split = regula.MatchFacesSimilarityThresholdSplit.fromJson(json.decode(str));
        isSimilar(split!.matchedFaces.isNotEmpty);
      });
    });
  }
}