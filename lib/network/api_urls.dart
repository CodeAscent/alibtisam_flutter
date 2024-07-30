String BASEURL = "http://52.66.197.219:8000/";
// String BASEURL = "http://192.168.29.116:8000/";
String api_version = "api/v1/";
String socket_base_url = BASEURL;
String base_url = BASEURL + api_version;
String event = "event/";
String user = "user/";
String coach = "coach/";
String player = "player/";
String organization = "organization/";
String org_application_service = "org-application-service/";
String request = "request/";
String chat = "chat/";
String monitoring = "monitoring/";
String playerApproval = "player-approval/";
String collection = "collection/";
String game = "game/";
String team = "team/";
String attendance = "attendance/";

//
String all_events = base_url + event + "all";

// EXTERNAL USER
String register_user = base_url + user + "register";

// Login
String login_user = base_url + user + "login";

// Logout
String logout_user = base_url + user + "logout";

// GET USER
String get_user = base_url + user + "status/get";

// UPDATE USER
String update_user = base_url + user + "update/";

// CREATE PLAYER
String create_player = base_url + player + "add";

// GET PLAYER BY GUARDIAN
String get_player_by_guardian = base_url + player + "guardian/";

// GET TOKEN BY ID
String get_token_by_id = base_url + player + "token/";

// GET MESAUREMENT REQUESTS
String get_players_requests = base_url + request + playerApproval + "get/";

// GET ORGANIZATION DROPDOWN
String get_organization_dropdown = base_url + organization + "dropdown";

// GET ORGANIZATION
String get_organization = base_url + organization + "get";

// GET DASHBOARD SERVICES
String get_dashboard_services =
    base_url + org_application_service + "my-services";

// SUBMIT MEASUREMENT
String submit_measurement = base_url + request + "submit-measurement";

// GET CHAT MESSAGES
String get_chat_messages = base_url + chat + "";

// GET CHATS LIST
String get_chats_list = base_url + chat + "get";

// GET COLLECTIONS BY GAME FILTER
String get_collection_by_game_filter = base_url + collection + "get";

// GET MONITORING BY PLAYER ID
String get_monitoring_by_playerId = base_url + monitoring + "get/";

// GET MONITORING BY PLAYER ID
String update_monitoring_by_playerId = base_url + monitoring + "update/";

// GET ALL GAMES
String get_all_games = base_url + game + "dropdown";

// GET ALL GAMES
String get_player_reports = base_url + monitoring + "get-report/";

// GET TEAMS BY COACH
String get_teams_by_coach = base_url + team + "get-by-coach";

// ADD ATTENDANCE
String add_attendance = base_url + attendance + "add";

// MARK ATTENDANCE
String mark_attendance = base_url + attendance + "mark/";

// GET MARKED ATTENDANCE
String get_marked_attendance = base_url + attendance + "get-marked/";

// GET COMPLETED ATTENDANCE
String get_completed_attendance = base_url + attendance + "get-completed/";

// GET COMPLETED ATTENDANCE
String get_all_completed_attendance =
    base_url + attendance + "get-all-completed/";

// GET PLAYER ATTENDANCE
String get_player_attendance = base_url + attendance + "player/";

// GET PLAYER ATTENDANCE
String get_player_attendance_statistics =
    base_url + attendance + "player-statistics";

// UPDATE USER BY ID
String update_user_by_id = base_url + user + "update/";
// UPDATE USER BY ID
String age_category = base_url + coach + "age-categories";
String players_by_age_and_stage = base_url + coach;
