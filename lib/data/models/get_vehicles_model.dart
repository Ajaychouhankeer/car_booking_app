class GetVehicles {
  bool? success;
  int? total;
  List<Data>? data;
  Grouped? grouped;

  GetVehicles({this.success, this.total, this.data, this.grouped});

  GetVehicles.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    total = json['total'];

    /// ✅ SAFE LIST PARSING
    if (json['data'] != null) {
      data = List<Data>.from(
        json['data'].map((v) => Data.fromJson(v)),
      );
    } else {
      data = [];
    }

    grouped = json['grouped'] != null
        ? Grouped.fromJson(json['grouped'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['success'] = success;
    data['total'] = total;

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }

    if (grouped != null) {
      data['grouped'] = grouped!.toJson();
    }

    return data;
  }
}

class Data {
  dynamic loadingEfficiency; // ✅ FIXED
  String? sId;
  String? vehicleName;
  String? brand;
  String? vehicleType;
  String? category;
  String? travelType;
  String? usageType;
  int? pricePerKm;
  int? pricePerDay;
  int? seats;
  String? fuelType;
  bool? ac;
  String? imageUrl;
  List<String>? features;
  int? loadingCapacityKg;
  bool? driverAvailable;
  int? driverCharge;
  bool? available;
  String? description;
  double? rating;
  int? totalTrips;
  String? location;
  String? createdAt;
  String? updatedAt;

  Data({
    this.loadingEfficiency,
    this.sId,
    this.vehicleName,
    this.brand,
    this.vehicleType,
    this.category,
    this.travelType,
    this.usageType,
    this.pricePerKm,
    this.pricePerDay,
    this.seats,
    this.fuelType,
    this.ac,
    this.imageUrl,
    this.features,
    this.loadingCapacityKg,
    this.driverAvailable,
    this.driverCharge,
    this.available,
    this.description,
    this.rating,
    this.totalTrips,
    this.location,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    loadingEfficiency = json['loadingEfficiency'];
    sId = json['_id'];
    vehicleName = json['vehicleName'];
    brand = json['brand'];
    vehicleType = json['vehicleType'];
    category = json['category'];
    travelType = json['travelType'];
    usageType = json['usageType'];
    pricePerKm = json['pricePerKm'];
    pricePerDay = json['pricePerDay'];
    seats = json['seats'];
    fuelType = json['fuelType'];
    ac = json['ac'];
    imageUrl = json['imageUrl'];

    /// ✅ SAFE FEATURES LIST
    if (json['features'] != null) {
      features = List<String>.from(json['features']);
    } else {
      features = [];
    }

    loadingCapacityKg = json['loadingCapacityKg'];
    driverAvailable = json['driverAvailable'];
    driverCharge = json['driverCharge'];
    available = json['available'];
    description = json['description'];

    /// ✅ SAFE DOUBLE CONVERSION
    rating = (json['rating'] as num?)?.toDouble();

    totalTrips = json['totalTrips'];
    location = json['location'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['loadingEfficiency'] = loadingEfficiency;
    data['_id'] = sId;
    data['vehicleName'] = vehicleName;
    data['brand'] = brand;
    data['vehicleType'] = vehicleType;
    data['category'] = category;
    data['travelType'] = travelType;
    data['usageType'] = usageType;
    data['pricePerKm'] = pricePerKm;
    data['pricePerDay'] = pricePerDay;
    data['seats'] = seats;
    data['fuelType'] = fuelType;
    data['ac'] = ac;
    data['imageUrl'] = imageUrl;
    data['features'] = features;
    data['loadingCapacityKg'] = loadingCapacityKg;
    data['driverAvailable'] = driverAvailable;
    data['driverCharge'] = driverCharge;
    data['available'] = available;
    data['description'] = description;
    data['rating'] = rating;
    data['totalTrips'] = totalTrips;
    data['location'] = location;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;

    return data;
  }
}

class Grouped {
  List<Data>? family;
  List<Data>? transport;
  List<Data>? large; // ✅ FIXED

  Grouped({this.family, this.transport, this.large});

  Grouped.fromJson(Map<String, dynamic> json) {
    if (json['Family'] != null) {
      family = List<Data>.from(
        json['Family'].map((v) => Data.fromJson(v)),
      );
    } else {
      family = [];
    }

    if (json['Transport'] != null) {
      transport = List<Data>.from(
        json['Transport'].map((v) => Data.fromJson(v)),
      );
    } else {
      transport = [];
    }

    if (json['Large'] != null) {
      large = List<Data>.from(
        json['Large'].map((v) => Data.fromJson(v)),
      );
    } else {
      large = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (family != null) {
      data['Family'] = family!.map((v) => v.toJson()).toList();
    }

    if (transport != null) {
      data['Transport'] = transport!.map((v) => v.toJson()).toList();
    }

    if (large != null) {
      data['Large'] = large!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}