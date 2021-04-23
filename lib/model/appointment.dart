class Appointment {
  String driverId;
  String centerId;
  String status;
  String date;
  String time;
  String centerName;
  String serviceName;
  String centerMobile;
  String id;

  Appointment(
      {this.centerId,
      this.id,
      this.centerMobile,
      this.date,
      this.time,
      this.driverId,
      this.status,
      this.centerName,
      this.serviceName});
}
