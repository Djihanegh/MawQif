class Strings {
  // Generic strings
  static const String ok = 'OK';
  static const String cancel = 'Cancel';

  // Logout
  static const String logout = 'Logout';
  static const String logoutAreYouSure =
      'Are you sure that you want to logout?';
  static const String logoutFailed = 'Logout failed';

  // Sign In Page
  static const String signIn = 'Se connecter';
  static const String signInWithEmailPassword =
      'Sign in with email and password';
  static const String signInWithEmailLink = 'Sign in with email link';
  static const String signInWithFacebook = 'Sign in with Facebook';
  static const String signInWithGoogle = 'Sign in with Google';
  static const String goAnonymous = 'Go anonymous';
  static const String or = 'or';
  static const String passez = "Passez";

  // Email & Password page
  static const String register = 'Register';
  static const String forgotPassword = 'Forgot password';
  static const String forgotPasswordQuestion = 'Mot de passe oublié?';
  static const String createAnAccount = 'Créer un compte';
  static const String needAnAccount = "Pas enregistré ? S\'enregistrer ici";
  static const String haveAnAccount = 'Have an account? Sign in';
  static const String signInFailed = 'Erreur';
  static const String registrationFailed = 'Enregistrement non réussi';
  static const String passwordResetFailed = 'Password reset failed';
  static const String sendResetLink = 'Envoyer le lien';
  static const String backToSignIn = 'Se connecter';
  static const String resetLinkSentTitle = 'Renvoyer le lien';
  static const String resetLinkSentMessage =
      'Check your email to reset your password';
  static const String emailLabel = 'Email';
  static const String emailHint = 'test@test.com';
  static const String password8CharactersLabel = 'Mot de passe (8+ characteres)';
  static const String passwordLabel = 'Mot de passe';
  static const String invalidEmailErrorText = 'Email no valide';
  static const String invalidEmailEmpty = 'Le champs Email est obligatoire';
  static const String invalidPasswordTooShort = 'Mot de passe trés court';
  static const String invalidPasswordEmpty = 'Le champs mot de passe est obligatoire';

  // Email link page
  static const String submitEmailAddressLink =
      'Submit your email address to receive an activation link.';
  static const String checkYourEmail = 'Check your email';
  static String activationLinkSent(String email) =>
      'We have sent an activation link to $email';
  static const String errorSendingEmail = 'Error sending email';
  static const String sendActivationLink = 'Send activation link';
  static const String activationLinkError = 'Email activation error';
  static const String submitEmailAgain =
      'Please submit your email address again to receive a new activation link.';
  static const String userAlreadySignedIn =
      'Received an activation link but you are already signed in.';
  static const String isNotSignInWithEmailLinkMessage =
      'Invalid activation link';

  // Home page
  static const String homePage = 'Home Page';

  // Developer menu
  static const String developerMenu = 'Developer menu';
  static const String authenticationType = 'Authentication type';
  static const String firebase = 'Firebase';
  static const String mock = 'Mock';
}
