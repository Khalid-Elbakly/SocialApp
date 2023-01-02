import 'package:socialapp/cubit/states.dart';

abstract class SocialAppStates{}

class SocialAppIntialState extends SocialAppStates{}

class SocialAppLoadingState extends SocialAppStates{}

class SocialAppSuccessState extends SocialAppStates{}

class SocialAppErrorState extends SocialAppStates{
  final error;

  SocialAppErrorState(this.error);
}

class SocialBottomNavBarState extends SocialAppStates{}

class SocialImagePirckerState extends SocialAppStates{}

class UploadProfileImageSuccess extends SocialAppStates{}

class UploadProfileImageError extends SocialAppStates{}

class UploadCoverImageSuccess extends SocialAppStates{}

class UploadCoverImageError extends SocialAppStates{}

class RemoveImageState extends SocialAppStates{}