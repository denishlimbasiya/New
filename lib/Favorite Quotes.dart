import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Import localization package
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share/share.dart';
import 'package:task/controller.dart';
import 'package:url_launcher/url_launcher.dart';



class FavoriteQuotesApp extends StatefulWidget {
  const FavoriteQuotesApp({Key? key}) : super(key: key);

  @override
  _FavoriteQuotesAppState createState() => _FavoriteQuotesAppState();
}

class _FavoriteQuotesAppState extends State<FavoriteQuotesApp> {
  bool isDarkMode = false;
  List<Quote> quotes = [];
  List<Quote> favoriteQuotes = [];
  double userRating = 0.0;
  FlutterTts flutterTts = FlutterTts();
  List<String> supportedLanguages = ["en", "hi", "gu"];
  String selectedLanguage = "gu"; // Default language


  @override
  void initState() {
    super.initState();
    // Call the function to fetch data from the API when the app starts
    fetchDataFromAPI();
  }

  Future<void> fetchDataFromAPI() async {
    const apiUrl = 'https://development.frontbitsolutions.com/my_api/api.php?package_name=com.Eventplanner&api_key=Denish123'; // Replace with your API endpoint
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final quotesFromApi = List<Quote>.from(data.map((quoteData) {
          return Quote(
            quoteData['text'],
            quoteData['author'],
            isFavorite: false,
            deletable: true,
          );
        }));

        setState(() {
          quotes = quotesFromApi;
        });
      } else {
        throw Exception('Failed to load quotes from the API');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favorite Quotes',
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      // Define supported locales and localizationsDelegates
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('hi', 'IN'),
        const Locale('gu', 'IN'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale(selectedLanguage),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppTranslations.of(context, 'app_title')), // Use localization
            actions: [
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.language), // Language selection button
                onPressed: () {
                  _showLanguageSelectionDialog(context);
                },
              ),
              IconButton(
                icon: const Icon(Icons.star),
                onPressed: _openGooglePlayStore,
              ),
            ],
            bottom: TabBar(
              tabs: [
                Tab(text: AppTranslations.of(context, 'all_quotes_tab')), // Use localization
                Tab(text: AppTranslations.of(context, 'favorites_tab')),  // Use localization
                Tab(text: AppTranslations.of(context, 'random_quotes_tab')),  // Use localization
              ],
            ),
          ),
          body: TabBarView(
            children: [
              QuoteListScreen(
                quotes: quotes,
                toggleFavorite: toggleFavorite,
                openPlayStorePage: _openGooglePlayStore,
                shareQuote: shareQuote,
                refresh: refresh,
                speakQuote: _speakQuote,
              ),
              FavoritesPage(
                favoriteQuotes: favoriteQuotes,
                deleteFavorite: deleteFavorite,
                shareQuote: shareQuote,
                refresh: refresh,
                speakQuote: _speakQuote,
              ),
              RandomQuotePage(quotes: quotes),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showAddQuoteDialog(context);
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  void toggleFavorite(Quote quote) {
    setState(() {
      quote.isFavorite = !quote.isFavorite;
      if (quote.isFavorite) {
        favoriteQuotes.add(quote);
      } else {
        favoriteQuotes.remove(quote);
      }
    });
  }

  void deleteFavorite(Quote quote) {
    setState(() {
      quote.isFavorite = false;
      favoriteQuotes.remove(quote);
    });
  }

  void refresh() {
    setState(() {});
  }

  void _showAddQuoteDialog(BuildContext context) {
    final TextEditingController textController = TextEditingController();
    final TextEditingController authorController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppTranslations.of(context, 'add_quote_dialog_title')), // Use localization
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textController,
                decoration: InputDecoration(labelText: AppTranslations.of(context, 'quote_text')), // Use localization
              ),
              TextField(
                controller: authorController,
                decoration: InputDecoration(labelText: AppTranslations.of(context, 'author')), // Use localization
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppTranslations.of(context, 'cancel')), // Use localization
            ),
            TextButton(
              onPressed: () {
                final text = textController.text;
                final author = authorController.text;
                if (text.isNotEmpty && author.isNotEmpty) {
                  final quote = Quote(text, author,
                      isFavorite: false, deletable: true);
                  setState(() {
                    quotes.add(quote);
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text(AppTranslations.of(context, 'save')), // Use localization
            ),
          ],
        );
      },
    );
  }

  void _openGooglePlayStore() async {
    const playStoreUrl =
        "https://play.google.com/store/apps/details?id=com.instagram.android&hl=en-IN";
    if (await canLaunch(playStoreUrl)) {
      await launch(playStoreUrl);
    } else {
      throw "Could not launch $playStoreUrl";
    }
  }

  void shareQuote(Quote quote) {
    final textToShare = '${quote.text} - ${quote.author}';
    Share.share(textToShare);
  }

  Future<void> _speakQuote(String text) async {
    await flutterTts.setLanguage(selectedLanguage);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  void _showLanguageSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppTranslations.of(context, 'select_language')), // Use localization
          content: DropdownButton<String>(
            value: selectedLanguage,
            onChanged: (newValue) {
              setState(() {
                selectedLanguage = newValue!;
              });
              Navigator.of(context).pop(); // Close the dialog
            },
            items: supportedLanguages.map((lang) {
              return DropdownMenuItem<String>(
                value: lang,
                child: Text(lang),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(AppTranslations.of(context, 'cancel')), // Use localization
            ),
          ],
        );
      },
    );
  }
}

class Quote {
  final String text;
  final String author;
  bool isFavorite;
  bool deletable;

  Quote(this.text, this.author,
      {this.isFavorite = false, this.deletable = true});
}

class QuoteListScreen extends StatelessWidget {
  final List<Quote> quotes;
  final Function(Quote) toggleFavorite;
  final VoidCallback openPlayStorePage;
  final Function(Quote) shareQuote;
  final Function refresh;
  final Function(String) speakQuote;

  const QuoteListScreen({
    Key? key,
    required this.quotes,
    required this.toggleFavorite,
    required this.openPlayStorePage,
    required this.shareQuote,
    required this.refresh,
    required this.speakQuote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: quotes.length,
      itemBuilder: (context, index) {
        final quote = quotes[index];
        return ListTile(
          title: Text(quote.text),
          subtitle: Text(quote.author),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  quote.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: quote.isFavorite ? Colors.red : null,
                ),
                onPressed: () {
                  toggleFavorite(quote);
                  refresh();
                },
              ),
              if (quote.deletable)
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    quotes.remove(quote);
                    if (quote.isFavorite) {
                      toggleFavorite(quote);
                    }
                    refresh();
                  },
                ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  shareQuote(quote);
                },
              ),
              IconButton(
                icon: const Icon(Icons.volume_up),
                onPressed: () {
                  speakQuote(quote.text);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class FavoritesPage extends StatelessWidget {
  final List<Quote> favoriteQuotes;
  final Function(Quote) deleteFavorite;
  final Function(Quote) shareQuote;
  final Function refresh;
  final Function(String) speakQuote;

  const FavoritesPage({
    Key? key,
    required this.favoriteQuotes,
    required this.deleteFavorite,
    required this.shareQuote,
    required this.refresh,
    required this.speakQuote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favoriteQuotes.length,
      itemBuilder: (context, index) {
        final quote = favoriteQuotes[index];
        return ListTile(
          title: Text(quote.text),
          subtitle: Text(quote.author),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  deleteFavorite(quote);
                  refresh();
                },
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  shareQuote(quote);
                },
              ),
              IconButton(
                icon: const Icon(Icons.volume_up),
                onPressed: () {
                  speakQuote(quote.text);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class RandomQuotePage extends StatelessWidget {
  final List<Quote> quotes;

  const RandomQuotePage({
    Key? key,
    required this.quotes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (quotes.isEmpty) {
      return Center(
        child: const Text(
          ( 'no_quotes_available'), // Use localization
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    final random = Random();
    final randomIndex = random.nextInt(quotes.length);
    final randomQuote = quotes[randomIndex];

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            ("random_quote"), // Use localization
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 16),
          Text(
            randomQuote.text,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            '- ${randomQuote.author}',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
class AppTranslationsKeys {
  static const String appTitle = 'app_title';
  static const String allQuotesTab = 'all_quotes_tab';
  static const String favoritesTab = 'favorites_tab';
  static const String randomQuotesTab = 'random_quotes_tab';
  static const String addQuoteDialogTitle = 'add_quote_dialog_title';
  static const String quoteText = 'quote_text';
  static const String author = 'author';
  static const String cancel = 'cancel';
  static const String save = 'save';
  static const String selectLanguage = 'select_language';
  static const String noQuotesAvailable = 'no_quotes_available';
  static const String randomQuote = 'random_quote';
}
