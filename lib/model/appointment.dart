class Appointment {
  String driverId;
  String centerId;
  String status;
  String date;
  String time;
  String centerName;
  String serviceName;
  String centerMobile;

  Appointment(
      {this.centerId,
      this.centerMobile,
      this.date,
      this.time,
      this.driverId,
      this.status,
      this.centerName,
      this.serviceName});
}
