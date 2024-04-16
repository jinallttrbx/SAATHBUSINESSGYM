class LanguageModel {
  final int id;
  final String name;
  final String languageCode;
  final String languageletter;
  final String status;

  LanguageModel(
    this.id,
    this.name,
    this.languageCode,
      this.languageletter,
      this.status
  );

  static List<LanguageModel> languageList = <LanguageModel>[
    LanguageModel(1, 'English', 'en','A',"0"),
    LanguageModel(2, 'Hindi', 'hi','अ',"1"),
    LanguageModel(2, 'Gujarati', 'gu','અ',"1"),
  ];
}
