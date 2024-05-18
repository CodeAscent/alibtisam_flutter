String base_url = "http://192.168.29.162:8000/";
// String base_url = "http://192.168.1.11:8000/";
String api_version = "api/v1/";
String event = "event/";
String user = "user/";

//
String all_events = base_url + api_version + event + "all";

// EXTERNAL USER
String register_user = base_url + api_version + user + "register";

// Login
String login_user = base_url + api_version + user + "login";

// GET USER
String get_user = base_url + api_version + user + "get";
