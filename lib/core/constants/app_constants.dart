class AppConstants {
  static AppConstants? _instance;

  static AppConstants get instance => _instance ??= AppConstants._init();

  AppConstants._init();

  String appTitle = "Qr Yoklama Uygulaması";

  String supabaseURL = 'https://lbogfvutuiklzanebhmk.supabase.co';

  String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imxib2dmdnV0dWlrbHphbmViaG1rIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NTE4MjEyODYsImV4cCI6MTk2NzM5NzI4Nn0.ExN0vre4bXxfCGAi9dOoOfwAmxHl3n80G3dmr5zeztE';
}
