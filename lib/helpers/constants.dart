class AppImages{
  static const logo = "assets/images/logo.svg";
  static const homePersonMan = "assets/images/men.png";
  static const homePersonWomen = "assets/images/adaptive.png";
  static const success = "assets/images/success.png";
  static const avatar = "assets/images/avatar.jpeg";
}

class Server{
  static const baseUrl = "https://snap-api.thype.in";
  // static const baseUrl = "http://192.168.1.19:4000";
  static const login = "/user/login";
  static const start = '/user/start';
  static const stop = '/user/stop';

  static const signup = "/user/signup";
  static const verifySignup = "/user/signup/verify";
  static const userProfile = "/user";
  static const register = "/user/register";
  static const mediaUpload = "/media/upload";
  static const candidateProfiles = "/user/explore";
  static const postJob = "/jobs/";
  static const postedJobs = "/jobs/history";
  static const applicants = "/jobs/applications";
  static const myApplications = "/jobs/applications/my";
  static const applyToJob = "/jobs/apply";
  static const updateApplicationStatus = "/jobs/applications/status/update";

}