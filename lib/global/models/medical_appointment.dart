import 'package:dhanva_mobile_app/global/models/doctor.dart';
import 'package:dhanva_mobile_app/global/models/patient.dart';

class MedicalAppointment {
  bool hasConsultation;
  Null approved;
  int status;
  String sId;
  int appointmentId;
  String symptoms;
  String appointmentDate;
  String department;
  Patient patient;
  Doctor doctor;
  String timeSlot;
  Map<String, dynamic> paymentInfo;
  String createdBy;
  int iV;

  MedicalAppointment(
      {this.hasConsultation,
      this.approved,
      this.status,
      this.sId,
      this.appointmentId,
      this.symptoms,
      this.appointmentDate,
      this.department,
      this.patient,
      this.doctor,
      this.timeSlot,
      this.paymentInfo,
      this.createdBy,
      this.iV});

  MedicalAppointment.fromJson(Map<String, dynamic> json) {
    hasConsultation = json['hasConsultation'];
    approved = json['approved'];
    status = json['status'];
    sId = json['_id'];
    appointmentId = json['appointmentId'];
    symptoms = json['symptoms'];
    appointmentDate = json['appointmentDate'];
    department = json['department'];
    patient = json['patient_id'] != null
        ? Patient.fromJson(json['patient_id'])
        : null;
    doctor = json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
    timeSlot = json['time_slot'];
    paymentInfo = json['payment_info'];
    createdBy = json['created_by'];
    iV = json['__v'];
  }
}
