class APIPath {
  static String job(String uid, String jobid) => 'users/$uid/jobs/$jobid';
  static String jobs(String uid) => 'users/$uid/jobs';
}
