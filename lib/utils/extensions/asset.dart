library image_extension;

extension AssetsExtension on String {
  //Icons
  String get svgT => 'assets/icons/$this.svg';
  String get svgB => 'assets/icons/bulk/$this.svg';
  //Images
  String get imgPng => 'assets/images/$this.png';
  String get imgJpg => 'assets/images/$this.jpg';
  String get imgSvg => 'assets/images/$this.svg';
}
