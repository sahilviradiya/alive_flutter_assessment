/// Central registry of asset paths so widgets never hardcode strings.
class AppAssets {
  AppAssets._();

  static const String _icons = 'assets/icons';
  static const String _images = 'assets/images';

  static const String appLogo = '$_images/app_logo.svg';
  static const String avatarPlaceholder = '$_images/avatar_placeholder.svg';

  static const List<String> streamPlaceholders = [
    '$_images/placeholder_stream_1.svg',
    '$_images/placeholder_stream_2.svg',
    '$_images/placeholder_stream_3.svg',
    '$_images/placeholder_stream_4.svg',
  ];

  static const String icGoogle = '$_icons/ic_google.svg';
  static const String icFacebook = '$_icons/ic_facebook.svg';
  static const String icHome = '$_icons/ic_home.svg';
  static const String icParty = '$_icons/ic_party.svg';
  static const String icGoLive = '$_icons/ic_golive.svg';
  static const String icChats = '$_icons/ic_chats.svg';
  static const String icProfile = '$_icons/ic_profile.svg';
  static const String icBell = '$_icons/ic_bell.svg';
  static const String icWallet = '$_icons/ic_wallet.svg';
  static const String icEye = '$_icons/ic_eye.svg';

  static const String flagGlobal = '$_icons/flag_global.svg';
  static const String flagIndia = '$_icons/flag_india.svg';
  static const String flagPhilippines = '$_icons/flag_philippines.svg';
  static const String flagBrazil = '$_icons/flag_brazil.svg';
}
