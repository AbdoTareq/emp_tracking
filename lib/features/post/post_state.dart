import '../../models/post.dart';

class PostState {
  final bool isLoading;
  final List<Post>? data;
  final String? error;

  const PostState({
    this.isLoading = false,
    this.data,
    this.error,
  });

  PostState copyWith({
    bool? isLoading,
    List<Post>? data,
    String? error,
  }) {
    return PostState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data ?? [],
      error: error ?? this.error,
    );
  }
}
