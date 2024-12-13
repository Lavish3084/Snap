class User {
  static User user=User();
  static var userToken="";
  String? id;
  bool? active;
  String? profilePicture;
  String? firstName;
  String? lastName;
  String? designation;
  String? phoneNumber;
  String? alternatePhoneNumber;
  String? address;
  String? city;
  String? state;
  String? pincode;
  String? batchNumber;
  String? vehicleNumber;
  String? vehicleName;
  String? passwordHash;

  User({
    this.id,
    this.profilePicture,
    this.firstName,
    this.lastName,
    this.designation,
    this.phoneNumber,
    this.alternatePhoneNumber,
    this.address,
    this.city,
    this.state,
    this.pincode,
    this.batchNumber,
    this.vehicleNumber,
    this.vehicleName,
    this.passwordHash,
    this.active
  });

  // Factory constructor to create a User from a JSON map
  factory User.fromJson(Map<String, dynamic> json) {
    print("hell there $json");
    return User(
      id: json['_id']??"",
      profilePicture: json['profilePicture']??"",
      firstName: json['firstName']??"",
      lastName: json['lastName']??"",
      designation: json['designation']??"",
      phoneNumber: json['phoneNumber']??"",
      alternatePhoneNumber: json['alternatePhoneNumber']??"",
      address: json['address']??"",
      city: json['city']??"",
      state: json['state']??"",
      pincode: json['pincode']??"",
      batchNumber: json['batchNumber']??"",
      vehicleNumber: json['vehicleNumber']??"",
      vehicleName: json['vehicleName']??"",
      passwordHash: json['passwordHash']??"",
      active: json['active']??false
    );
  }

  static setStaticUser(v){
    User.user=v;
  }

  // Method to convert a User instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'profilePicture': profilePicture,
      'firstName': firstName,
      'lastName': lastName,
      'designation': designation,
      'phoneNumber': phoneNumber,
      'alternatePhoneNumber': alternatePhoneNumber,
      'address': address,
      'city': city,
      'state': state,
      'pincode': pincode,
      'batchNumber': batchNumber,
      'vehicleNumber': vehicleNumber,
      'vehicleName': vehicleName,
      'passwordHash': passwordHash,
    };
  }
}
