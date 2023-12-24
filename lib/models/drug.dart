class Drug{
  final String id;
  final String tagId;
  final String imgUrl;
  final String dose;
  final String quantity;
  final String price;
  final String expiryDate;
  final String englishTradeName;
  final String arabicTradeName;
  final String englishScientificName;
  final String arabicScientificName;
  final String englishCompany;
  final String arabicCompany;
  final String englishDoseUnit;
  final String arabicDoseUnit;

  Drug({
    required this.id,
    required this.tagId,
    required this.imgUrl,
    required this.dose,
    required this.quantity,
    required this.price,
    required this.expiryDate,
    this.englishTradeName = '',
    this.arabicTradeName = '',
    this.englishScientificName = '',
    this.arabicScientificName = '',
    this.englishCompany = '',
    this.arabicCompany = '',
    this.englishDoseUnit = '',
    this.arabicDoseUnit = '',
});
}