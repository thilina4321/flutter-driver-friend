class ServiceCenter {
  String id;
  String address;
  int mobile;
  String about;
  String openingTime;
  String closingTime;
  String profileImageUrl;
  String location;
  double rating;
  String name;

  ServiceCenter(
      {this.about,
      this.id,
      this.name,
      this.rating,
      this.address,
      this.closingTime,
      this.location,
      this.mobile,
      this.openingTime,
      this.profileImageUrl});
}
