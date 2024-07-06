class OAuthConfigurations {
  //Okta constants
  static const oktaCallback = "com.okta.dev-40025834:/callback";
  static const oktaCallbackScheme = "com.okta.dev-40025834";
  static const oktaClientId = "0oa6dfpi4llNzimwP5d7";
  static const organizationUrl = "dev-40025834.okta.com";
  static const responseType = "id_token";
  static const codeChallengeMethod = "S256";

  //Azure Constants
  static const azureClientId = 'b50218fa-e04b-4569-bcd3-0e4973f63a7c'; //
  static const azureAuthority = '/organizations/oauth2/v2.0/authorize';
  static const azureRedirect =
      'msalb50218fa-e04b-4569-bcd3-0e4973f63a7c://auth';
  static const azureRedirectScheme = 'msalb50218fa-e04b-4569-bcd3-0e4973f63a7c';
}
