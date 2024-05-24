// String base_url = "http://192.168.1.7:8000/";
String base_url = "http://15.206.185.144:8000/";
String api_version = "api/v1/";
String event = "event/";
String user = "user/";
String player = "player/";
String organization = "organization/";
String org_application_service = "org-application-service/";
String request = "request/";

//
String all_events = base_url + api_version + event + "all";

// EXTERNAL USER
String register_user = base_url + api_version + user + "register";

// Login
String login_user = base_url + api_version + user + "login";

// GET USER
String get_user = base_url + api_version + user + "status/get";

// UPDATE USER
String update_user = base_url + api_version + user + "update/";

// CREATE PLAYER
String create_player = base_url + api_version + player + "add";

// GET PLAYER BY GUARDIAN
String get_player_by_guardian = base_url + api_version + player + "guardian/";

// GET TOKEN BY ID
String get_token_by_id = base_url + api_version + player + "token/";

// GET MESAUREMENT REQUESTS
String get_measurement_requests =
    base_url + api_version + request + "get-measurement/";

// GET TOKEN BY ID
String get_organization = base_url + api_version + organization + "get";

// GET DASHBOARD SERVICES
String get_dashboard_services =
    base_url + api_version + org_application_service + "my-services";

// SUBMIT MEASUREMENT
String submit_measurement =
    base_url + api_version + request + "submit-measurement";
