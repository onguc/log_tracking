flutter packages pub run build_runner build // modeller seriliaze için kullanılır. Hive için adapter oluşturma için de geçerlidir
flutter packages pub run build_runner build --delete-conflicting-outputs  // yukardaki çalışmadığında

 dart  pub run build_runner build --delete-conflicting-outputs  // yeni sürümde

// paket yayınlama
dart pub publish --dry-run  // hata kontrol
dart pub publish  //yayınlama