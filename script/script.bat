dart run build_runner build // modeller seriliaze için kullanılır. Hive için adapter oluşturma için de geçerlidir
dart run build_runner build --delete-conflicting-outputs  // yukardaki çalışmadığında

// paket yayınlama
dart pub publish --dry-run  // hata kontrol
dart pub publish  //yayınlama