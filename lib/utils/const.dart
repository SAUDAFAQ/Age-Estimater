class Application {
  static const String baseUrl = "https://api.agify.io";

  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}
