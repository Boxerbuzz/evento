library image_extension;

extension AssetsExtension on String {
  //Icons
  String get svg => 'assets/icons/$this.svg';
  String get png => 'assets/icons/$this.png';
  //Images
  String get imgPng => 'assets/images/$this.png';
  String get imgJpg => 'assets/images/$this.jpg';
  String get imgSvg => 'assets/images/$this.svg';
}
