abstract class SocialAppStates{}

class SocialAppIntialState extends SocialAppStates{}

class SocialAppLoadingState extends SocialAppStates{}

class SocialAppSuccessState extends SocialAppStates{}

class SocialAppErrorState extends SocialAppStates{
  final error;

  SocialAppErrorState(this.error);
}


class GetPostsLoadingState extends SocialAppStates{}

class GetPostsSuccessState extends SocialAppStates{}

class GetPostsErrorState extends SocialAppStates{
  final error;

  GetPostsErrorState(this.error);
}


class GetUsersLoadingState extends SocialAppStates{}

class GetUsersSuccessState extends SocialAppStates{}

class GetUsersErrorState extends SocialAppStates{
  final error;

  GetUsersErrorState(this.error);
}


class LikePostSuccess extends SocialAppStates{}

class LikePostError extends SocialAppStates{}

class CommentPostSuccess extends SocialAppStates{}

class CommentPostError extends SocialAppStates{}


class SocialBottomNavBarState extends SocialAppStates{}

class SocialImagePirckerState extends SocialAppStates{}

class UploadProfileImageSuccess extends SocialAppStates{}

class UploadProfileImageError extends SocialAppStates{}

class UploadCoverImageSuccess extends SocialAppStates{}

class UploadCoverImageError extends SocialAppStates{}

class UploadPostLoading extends SocialAppStates{}

class UploadPostSuccess extends SocialAppStates{}

class UploadPostError extends SocialAppStates{}

class RemoveImageState extends SocialAppStates{}