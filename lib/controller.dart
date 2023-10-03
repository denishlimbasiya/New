import 'package:flutter/widgets.dart';

class AppTranslations {
  final Locale locale;
  AppTranslations(this.locale);

  static Map<String, Map<String, String>> translations = {
    'en': {
      'app_title': 'Favorite Quotes',
      'all_quotes_tab': 'All Quotes',
      'favorites_tab': 'Favorites',
      'random_quotes_tab': 'Random Quotes',
      'add_quote_dialog_title': 'Add Quote',
      'quote_text': 'Quote Text',
      'author': 'Author',
      'cancel': 'Cancel',
      'save': 'Save',
      'no_quotes_available': 'No Quotes Available',
      'random_quote': 'Random Quote',
      'select_language': 'Select Language',
    },
    'hi': {
      'app_title': 'पसंदीदा कथन',
      'all_quotes_tab': 'सभी कथन',
      'favorites_tab': 'पसंदीदा',
      'random_quotes_tab': 'रैंडम कथन',
      'add_quote_dialog_title': 'कथन जोड़ें',
      'quote_text': 'कथन पाठ',
      'author': 'लेखक',
      'cancel': 'रद्द करें',
      'save': 'सहेजें',
      'no_quotes_available': 'कोई कथन उपलब्ध नहीं है',
      'random_quote': 'रैंडम कथन',
      'select_language': 'भाषा चुनें',
    },
    'gu': {
      'app_title': 'મનપસંદ ઉકિલો',
      'all_quotes_tab': 'બધા ઉકિલો',
      'favorites_tab': 'મનપસંદ',
      'random_quotes_tab': 'રેન્ડમ ઉકિલો',
      'add_quote_dialog_title': 'ઉકિલો ઉમેરો',
      'quote_text': 'ઉકિલો ટેક્સ્ટ',
      'author': 'લેખક',
      'cancel': 'રદ્દ કરો',
      'save': 'સેવ કરો',
      'no_quotes_available': 'કોઈ ઉકિલો ઉપલબ્ધ નથી.',
      'random_quote': 'રેન્ડમ ઉકિલો',
      'select_language': 'ભાષા પસંદ કરો',
    },
  };

  static String of(BuildContext context, String key) {
    final Map<String, String>? languageMap =
    translations[Localizations.localeOf(context).languageCode];
    if (languageMap != null) {
      return languageMap[key] ?? key;
    }
    return key;
  }
}
