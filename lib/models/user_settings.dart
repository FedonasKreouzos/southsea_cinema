class UserSettings {
  final String address;
  final String email;
  final String patronNumber;
  final bool receiveNews;

  const UserSettings({
    this.address = '',
    this.email = '',
    this.patronNumber = '',
    this.receiveNews = false,
  });
}