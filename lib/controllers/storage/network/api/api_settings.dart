
class ApiSettings{

  static const _baseURL = 'https://www.msdr.news/';


  static const _apiURL = _baseURL + 'api/';

  static const _authURL = _apiURL + 'auth/';
  static const login = _authURL + 'login';
  static const logout = _authURL + 'logout';
  static const register = _authURL + 'register';
  static const updateProfile = _authURL + 'update-profile';


  static const missionURL = _apiURL + 'missions';
  static const remainingMissionURL = missionURL + '/remaining';
  static const completedMissionURL = missionURL + '/completed';
  static const getDoMissionURL = _apiURL + 'domissions';
  static const storeDoMissionURL = _apiURL + 'domissions';
  static const pointsUrl = _apiURL + 'points';
  static const missionsCountUrl = _apiURL + 'missions_counts';
  static const moneyUrl = _apiURL + 'money';
  static const paymentGatWayUrl = _apiURL + 'payment_gateways';
  static const rankUrl = _apiURL + 'my-rank';
  static const payoutsUrl = _apiURL + 'payouts';
  static const giftsUrl = _apiURL + 'gifts';


}