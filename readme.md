Dé
  Placez le bouton PayPal dans votre application mobile si votre processus d'achat commence et finit avec les écrans de votre application mobile. Dans ce flot de programmation, vous intégrez uniquement les pages mobiles Express Paiement Commander dans une vue web.
  1. Chercher un jeton dispositif de la bibliothèque, juste avant d'afficher l'écran de l'application mobile, où vous montrez un bouton PayPal.
  Inclure un pointeur vers votre méthode de délégué qui reçoit le jeton appareil.
  2. Obtenez un bouton PayPal à partir de la bibliothèque, et placez-le sur l'écran de votre application mobile. Inclure un pointeur vers votre méthode de délégué qui gère l'événement clic de bouton.
  3. Lorsque les acheteurs sélectionnez le bouton PayPal, votre méthode de délégué est appelé:
  a. Appel d'une routine sur votre serveur web mobile, en passant les informations de paiement.
  b. Sur votre serveur web mobile, envoyez une demande SetExpressCheckout avec les informations de paiement sur ​​le site PayPal.
  c. Passer le jeton caisse retournée dans la réponse SetExpressCheckout de votre serveur web mobile à votre application mobile.
  d. Ouvrez une vue web, et de rediriger le navigateur vers le site PayPal avec le commandement mobile, le jeton dispositif, et le jeton de caisse comme paramètres d'URL.
  https://www.paypal.com/cgi-bin/webscr?cmd=_express-checkout- mobile et drt = valueFromMobileExpressCheckoutLibrary & token = valueFromSetExpr essCheckoutResponse
  4. Surveiller l'affichage Web d'une redirection à partir de PayPal à votre retour ou annuler URL.
  5. Si PayPal redirige l'affichage Web à l'URL de votre retour, appeler des routines de substitution sur votre serveur web mobile qui envoient GetExpressCheckoutDetails et demandes DoExpressCheckoutPayment à PayPal pour effectuer le paiement.
  IMPORTANT: Ne jamais envoyer de demandes express Commander partir de votre application mobile directement à PayPal. Les demandes nécessitent vos informations d'authentification API PayPal. Placer vos identifiants sur mobile

* /