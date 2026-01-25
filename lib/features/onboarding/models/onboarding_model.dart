class OnboardingModel {
  final String imagePath;
  final String title;
  final String description;
  final String buttonText;

  const OnboardingModel({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.buttonText,
  });

  OnboardingModel copyWith({
    String? imagePath,
    String? title,
    String? description,
    String? buttonText,
  }) {
    return OnboardingModel(
      imagePath: imagePath ?? this.imagePath,
      title: title ?? this.title,
      description: description ?? this.description,
      buttonText: buttonText ?? this.buttonText,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'title': title,
      'description': description,
      'buttonText': buttonText,
    };
  }

  factory OnboardingModel.fromJson(Map<String, dynamic> json) {
    return OnboardingModel(
      imagePath: json['imagePath'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      buttonText: json['buttonText'] as String,
    );
  }

  @override
  String toString() {
    return 'OnboardingModel(imagePath: $imagePath, title: $title, description: $description, buttonText: $buttonText)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OnboardingModel &&
        other.imagePath == imagePath &&
        other.title == title &&
        other.description == description &&
        other.buttonText == buttonText;
  }

  @override
  int get hashCode {
    return imagePath.hashCode ^
        title.hashCode ^
        description.hashCode ^
        buttonText.hashCode;
  }
}