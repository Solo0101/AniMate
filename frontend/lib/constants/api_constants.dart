class ApiConstants {
  static const String baseUrl = 'animate.clipe.ro';

  static const String appRegisterEndpoint = 'api/User/register';
  static const String appLoginEndpoint = 'api/User/login';

  // TODO: Figure all endpoints exact links with (eg. /{id} ...)
  static const String appGetAllUsersEndpoint = 'api/User/getAll';
  static const String appGetUserByIdEndpoint = 'api/User/';
  static const String appUpdateUserByIdEndpoint = 'api/User/';
  static const String appDeleteUserByIdEndpoint = 'api/User/';
  static const String appGetUserByEmailEndpoint = 'api/User/get/email/';

  static const String appGetAllPetsEndpoint = 'api/Pet/getAll';
  static const String appGetPetByIdEndpoint = 'api/Pet/';
  static const String appUpdatePetByIdEndpoint = 'api/Pet/';
  static const String appDeletePetByIdEndpoint = 'api/Pet/';
  static const String appGetPetByUserIdEndpoint = 'api/Pet/owner/';
  static const String appGetPetByTypeEndpoint = 'api/Pet/type/';
  static const String appGetPetByBreedEndpoint = 'api/Pet/breed/';
  static const String appGetPetByAgeEndpoint = 'api/Pet/age/';
  static const String appGetPetByGenderEndpoint = 'api/Pet/gender/';
  static const String appCreatePetEndpoint = 'api/Pet/create/';

  static const String petResources = 'https://$baseUrl/resources/pets/';
  static const String userResources = 'https://$baseUrl/resources/users/';
  static const String otherResources = 'https://$baseUrl/resources/';
  // TODO: Add more endpoints
}