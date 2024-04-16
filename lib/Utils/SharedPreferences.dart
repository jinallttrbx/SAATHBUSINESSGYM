// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';
import 'dart:ui';

import 'package:businessgym/conts/global_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  final _LoggedIn = "_LoggedIn";
  final UserName = "_LoggedIn";
  final _UserType = "_UserType";
  final currentAddress = "currentAddress";
  final _UsetId = "_UsetId";
  final _Latitude = "_Latitude";
  final _Longitude = "_Longitude";
  final _IntroScreen = "_IntroScreen";
  final _MobileIn = "_MobileIn";
  final _UseridIn = "_UseridIn";
  final _UsernameIn = "_UseridIn";
  final _iTokenIn = "_iTokenIn";
  final _PickLocationIn = "_PickLocationIn";
  final _LatLocationIn = "_LatLocationIn";
  final _LongLocationIn = "_LongLocationIn";
  final _VenueidIn = "_VenueidIn";
  final _SportidIn = "_SportidIn";
  final _SportsidIn = "_SportsidIn";
  final _VenuenameIn = "_VenuenameIn";
  final _SporttypeIn = "_SporttypeIn";
  final _idIn = "_idIn";
  final _sportnameIn = "_sportnameIn";
  final _dateIn = "_dateIn";
  final _gameTypeNameIn = "_gameTypeNameIn";
  final _bookingidIn = "_bookingidIn";
  final _LogoIn = "_LogoIn";
  final _TournamentidIn = "_TournamentidIn";
  final _TournamentnameIn = "_TournamentnameIn";
  final _TournamentdescriptionIn = "_TournamentdescriptionIn";
  final _TournamentpriceIn = "_TournamentpriceIn";
  final _TournamentimageIn = "_TournamentimageIn";
  final _TournamentvenueNameIn = "_TournamentvenueNameIn";
  final _TournamentstateIn = "_TournamentstateIn";
  final _TournamentcityNameIn = "_TournamentcityNameIn";
  final _TournamentcreatedAtIn = "_TournamentcreatedAtIn";
  final _TournamentsportsNameIn = "_TournamentsportsNameIn";
  final _TournamentBookidIn = "_TournamentBookidIn";
  final _BecomeSuplier = "_BecomeSuplier";

  bool _loading = false;

  ShowProgress() {
    _loading = true;
    new Future.delayed(new Duration(seconds: 3), HideProgress);
  }

  Future HideProgress() async {
    _loading = false;
  }

  getAllPrefsClear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("_LoggedIn");
    prefs.remove("_UserType");
    prefs.remove("currentAddress");
    prefs.remove("_UsetId");
    prefs.remove("_IntroScreen");
    prefs.remove("_MobileIn");
    prefs.remove("_UseridIn");
    prefs.remove("_iTokenIn");
    prefs.remove("_PickLocationIn");
    prefs.remove("_LatLocationIn");
    prefs.remove("_LongLocationIn");
    prefs.remove("_VenueidIn");
    prefs.remove("_SportidIn");
    prefs.remove("_SportsidIn");
    prefs.remove("_VenuenameIn");
    prefs.remove("_SporttypeIn");
    prefs.remove("_idIn");
    prefs.remove("_sportnameIn");
    prefs.remove("_dateIn");
    prefs.remove("_gameTypeNameIn");
    prefs.remove("_bookingidIn");
    prefs.remove("_LogoIn");
    prefs.remove("_TournamentidIn");
    prefs.remove("_TournamentnameIn");
    prefs.remove("_TournamentdescriptionIn");
    prefs.remove("_TournamentpriceIn");
    prefs.remove("_TournamentimageIn");
    prefs.remove("_TournamentvenueNameIn");
    prefs.remove("_TournamentstateIn");
    prefs.remove("_TournamentcityNameIn");
    prefs.remove("_TournamentcreatedAtIn");
    prefs.remove("_TournamentsportsNameIn");
    prefs.remove("_TournamentBookidIn");
    prefs.remove(USERTOKKEN!);

    prefs.clear();
    print("===>  prefs removed");
  }

  Future<double> isLatituedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_Latitude) ?? 0;
  }

  Future<bool> setLatituedIn(double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(_Latitude, value);
  }

  Future<String> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_LoggedIn) ?? '0';
  }

  Future<bool> setLoggedIn(String value) async {
    print("==> Saving Login Cache");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_LoggedIn, value);
  }

  // Future<bool> setUserName(String value) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.setString(UserName, value);
  // }

  Future<String> isUserType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_UserType) ?? '0';
  }

  Future<bool> setUserType(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_UserType, value);
  }

  Future<String> iscurrentAddressIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(currentAddress) ?? '0';
  }

  Future<bool> setcurrentAddressIn(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(currentAddress, value);
  }

  Future<String> isUsetId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_UsetId) ?? '0';
  }

  Future<bool> setUsetId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_UsetId, value);
  }

  Future<String> isIntroIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_IntroScreen) ?? '0';
  }

  Future<bool> setIntroIn(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_IntroScreen, value);
  }

  Future<String> isMobile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_MobileIn) ?? '0';
  }

  Future<bool> setMobile(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_MobileIn, value);
  }

  Future<String> isUserid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_UseridIn) ?? '0';
  }

  Future<bool> setUserid(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_UseridIn, value);
  }
  Future<String> isUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_UsernameIn) ?? '0';
  }

  Future<bool> setUserName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_UsernameIn, value);
  }

  Future<String> isToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_iTokenIn) ?? '0';
  }

  Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_iTokenIn, value);
  }

  Future<String> isPickLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_PickLocationIn) ?? '0';
  }

  Future<bool> setPickLocation(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_PickLocationIn, value);
  }

  Future<String> isLatLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_LatLocationIn) ?? '0';
  }

  Future<bool> setLatLocation(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_LatLocationIn, value);
  }

  Future<String> isLongLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_LongLocationIn) ?? '0';
  }

  Future<bool> setLongLocation(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_LongLocationIn, value);
  }

  ///Current
  Future<String> isCurrentLatLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_LatLocationIn) ?? '0';
  }

  Future<bool> setCurrentLatLocation(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_LatLocationIn, value);
  }

  Future<String> isCurrentLongLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_LongLocationIn) ?? '0';
  }

  Future<bool> setCurrentLongLocation(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_LongLocationIn, value);
  }

  Future<String> isVenueid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_VenueidIn) ?? '0';
  }

  Future<bool> setVenueid(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_VenueidIn, value);
  }

  Future<String> isSportid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_SportidIn) ?? '0';
  }

  Future<bool> setSportid(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_SportidIn, value);
  }

  Future<String> isSportsid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_SportsidIn) ?? '0';
  }

  Future<bool> setSportsid(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_SportsidIn, value);
  }

  Future<String> isVenuename() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_VenuenameIn) ?? '0';
  }

  Future<bool> setVenuename(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_VenuenameIn, value);
  }

  Future<String> isSporttype() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_SporttypeIn) ?? '0';
  }

  Future<bool> setSporttype(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_SporttypeIn, value);
  }

  Future<String> isid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_idIn) ?? '0';
  }

  Future<bool> setid(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_idIn, value);
  }

  Future<String> issportname() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_sportnameIn) ?? '0';
  }

  Future<bool> setsportname(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_sportnameIn, value);
  }

  Future<String> isDate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_dateIn) ?? '0';
  }

  Future<bool> setDate(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_dateIn, value);
  }

  Future<String> isgameTypeName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_gameTypeNameIn) ?? '0';
  }

  Future<bool> setgameTypeName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_gameTypeNameIn, value);
  }

  Future<String> issetbookingid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_bookingidIn) ?? '0';
  }

  Future<bool> setbookingid(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_bookingidIn, value);
  }

  Future<String> islogo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_LogoIn) ?? '0';
  }

  Future<bool> setlogo(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_LogoIn, value);
  }

  Future<String> istournamentid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_TournamentidIn) ?? '0';
  }

  Future<bool> settournamentid(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_TournamentidIn, value);
  }

  Future<String> istournamentname() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_TournamentnameIn) ?? '0';
  }

  Future<bool> settournamentname(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_TournamentnameIn, value);
  }

  Future<String> istournamentdescription() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_TournamentdescriptionIn) ?? '0';
  }

  Future<bool> settournamentdescription(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_TournamentdescriptionIn, value);
  }

  Future<String> istournamentprice() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_TournamentpriceIn) ?? '0';
  }

  Future<bool> settournamentprice(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_TournamentpriceIn, value);
  }

  Future<String> istournamentimage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_TournamentimageIn) ?? '0';
  }

  Future<bool> settournamentimage(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_TournamentimageIn, value);
  }

  Future<String> istournamentvenueName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_TournamentvenueNameIn) ?? '0';
  }

  Future<bool> settournamentvenueName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_TournamentvenueNameIn, value);
  }

  Future<String> istournamentstate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_TournamentstateIn) ?? '0';
  }

  Future<bool> settournamentstate(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_TournamentstateIn, value);
  }

  Future<String> istournamentcityName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_TournamentcityNameIn) ?? '0';
  }

  Future<bool> settournamentcityName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_TournamentcityNameIn, value);
  }

  Future<String> istournamentcreatedAt() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_TournamentcreatedAtIn) ?? '0';
  }

  Future<bool> settournamentcreatedAt(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_TournamentcreatedAtIn, value);
  }

  Future<String> istournamentsportsName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_TournamentsportsNameIn) ?? '0';
  }

  Future<bool> settournamentsportsName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_TournamentsportsNameIn, value);
  }

  Future<String> istournamentBookid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_TournamentBookidIn) ?? '0';
  }

  Future<String> isBecomeSuplier() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_BecomeSuplier) ?? '0';
  }

  Future<bool> setBecomeSuplier(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_BecomeSuplier, value);
  }

  Future<bool> settournamentBookid(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_TournamentBookidIn, value);
  }
}

String LANGUAGE_CODE = 'languageCode';

const String ENGLISH = 'en';
const String HINDI = 'hi';
const String GUJARATI = 'gu';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(LANGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString(LANGUAGE_CODE) ?? ENGLISH;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return const Locale(ENGLISH, '');
    case HINDI:
      return const Locale(HINDI, '');
    default:
      return const Locale(GUJARATI, '');
  }
}
