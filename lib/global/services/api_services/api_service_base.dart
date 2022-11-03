import 'package:dio/dio.dart';

class ApiService {
  ApiService._();

  static const String protocol = 'https://';
  static const String baseUrl = 'api2.dhanva.icu/';
  static const String baseUrl2 = 'api3.dhanva.icu/';
  // static const String baseUrlNgrok = 'https://e78e-115-99-14-128.in.ngrok.io/';

  static const String loginApi = 'otp/otpLogin/';
  static const String otpVerificationApi = 'otp/otpVerify/';
  static const String servicesApi = 'services/get/62a8bfd832236f090fb89daa';

  /// +@PatientId required
  /// files/docs/{PatientId}
  static const String medicalRecordsApi = 'files/docs/';
  static const String upcomingMedicalAppointmentsApi =
      'appointment/patient/all/';

  /// +@hospitalId/+@serviceId required to work
  static const String allDoctorsApi = 'employee/doctors/';

  /// +@hospitalId/+@serviceId
  static const String doctorsByHospitalAndServiceApi = 'employee/doctors/';

  /// +@OnlinehospitalId required to work
  static const String allTimeSlotsApi = 'appointment/get_all_time_slots/';

  /// +@docId required
  /// +@hospitalId/+@docId
  static const String timeSlotsByDoctorApi = 'appointment/get_time_slots/';

  /// +@PatientId required
  /// patient/getPatientRelations/{PatientId}
  static const String patientRelationsApi = 'patient/getPatientRelations/';
  static Dio dio = Dio();
}
