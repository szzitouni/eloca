import 'package:flutter/material.dart';
import '../components/header.dart'; // Import du Header
import '../components/volet.dart'; // Import du Volet

class CguPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > 800;

        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 246, 241, 241),
          body: Row(
            children: [
              // Barre latérale (Volet) pour les grands écrans
              if (isLargeScreen)
                const Volet(

                ),

              // Contenu principal
              Expanded(
                child: SingleChildScrollView(  // Ajout du SingleChildScrollView ici
                  child: Column(
                    children: [
                      // Ajout du Header
                       Header(
                        title: 'Conditions Générales d\'Utilisation',
                        showMenuButton: false,
                       
                      ),

                      // Corps principal de la page
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            // Titre des Mentions Légales
                            const Text(
                              'Mentions Légales et Conditions générales d\'utilisation',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20), // Espacement

                            // Conteneur scrollable pour le texte des Mentions Légales
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              width: double.infinity, // Largeur maximale
                              constraints: BoxConstraints(
                                maxHeight: 750, // La hauteur maximale souhaitée
                              ),
                              child: SingleChildScrollView(
                                child: const Text(
                                  '''
Dernière mise à jour le : 01/09/2019

CONDITIONS GÉNÉRALES D’UTILISATION ET MENTIONS LÉGALES / E-LOCA
CE SITE/APPLICATION EST LA PROPRIÉTÉ DU GROUPE SERGIC

Tout téléchargement et visite du Site/application et/ou utilisation des Services doit se faire dans le respect des présentes CGU.

MENTIONS LÉGALES
Société éditrice : SERGIC
6 rue Konrad Adenauer
59290 Wasquehal

S.A.S. au capital de 24 236 056 €
RCS Lille Métropole 428 748 909

Adresse postale : 6 rue Konrad Adenauer CS 71031 59447 WASQUEHAL
n° de téléphone : 03.20.12.50.00
Représentant légal : SAS SERGIC INVEST représentée par Monsieur Etienne DEQUIREZ
Cartes professionnelles : CPI 5906 2016 000 012 977 délivrée par la CCI de Grand Lille, 299 Boulevard de Leeds 59031 LILLE CEDEX

Garant : Compagnie Européenne de Garanties et de Cautions
15 Rue Hoche – Tour Kupka B – TSA 39999 – 92919 LA Défense Cedex
Montant de la garantie : 110 000 € (T) 21 000 000 € (G) 85 000 000€ (S)
Couverture géographique de la garantie :
Assurance RCP : GENERALI IARD – 7, Boulevard Haussman – 75009 PARIS
N° intracommunautaire FR 64 428 748 909
Couverture géographique de la garantie : France Métropolitaine et Collectivités d’Outre Mer

Le Groupe SERGIC exerce la profession d’administrateur de biens. Ses activités de Transaction, Syndic de Copropriété, Gestion et Location immobilière sont régies par la Loi Hoguet n° 70-9 du 2 janvier 1970 et son décret d’application n°72-678 du 20 juillet 1972 (consultable sur legifrance.gouv.fr). Le Groupe est adhérent à l’UNIS en tant qu’organisme professionnel. Elle est soumise au code de déontologie des professions immobilières (décret n° 2015-1090 du 28 août 2015 consultable sur legifrance.gouv.fr).

Directeur de la publication : Etienne Dequirez

Responsable de la rédaction : Direction Marketing SERGIC

Site / Application réalisé par :

SERGIC
6 Rue Konrad ADENAUER
59290 WASQUEHAL
03 20 12 50 00

Site / application hébergé au sein de l’Union Européenne

DÉFINITIONS
Le terme « Données personnelles » désigne l’ensemble des informations permettant d’identifier l’Utilisateur ou qui le rende identifiable.

Le terme « Filiales » désigne les sociétés appartenant au Groupe Sergic au sens de l’article L.233-1 du Code de commerce, et présentant leurs annonces immobilières ou leurs Services sur le Site Internet et/ou Application.
Le terme « Services » désigne l’ensemble des services accessibles via le Site/Application et notamment l’accès aux annonces immobilières et autres outils ou services proposés par le Site/Application ainsi que la présentation de l’ensemble des offres de services d’accompagnement proposé par les Filiales à l’Utilisateur dans le cadre de son projet immobilier.
Le terme « Contenu » désigne sans que cette liste soit limitative, la structure du Site/Application, le contenu éditorial, les dessins, les illustrations, les images, les photographies, les chartes graphiques, les marques, les logos, les sigles, les dénominations sociales, les œuvres audiovisuelles, les œuvres multimédia, les contenus visuels, les contenus audio et sonores, ainsi que tout autre contenu présent au sein du Site/Application, et/ou tout autre élément composant le Site/Application.
Le terme « Utilisateur » ou « Vous » désigne toute personne physique qui accède au Site/Application dans le cadre d’un usage strictement privé.
Le terme « Réglementation relative à la protection des données personnelles » désigne la loi n° 78-17 du 6 janvier 1978 relative à l’informatique, aux fichiers et aux libertés, et le Règlement (EU) 2016/679 du Parlement européen et du Conseil du 27 Avril 2016 relatif à la protection des personnes physiques à l’égard du traitement de données à caractère personnel et à la libre circulation de ces données (RGPD).
Le terme « Site» désigne l’ensemble des produits et services proposés par SERGIC sur Internet depuis l’adresse : https://client.e-loca.com
ACCEPTATION DES CONDITIONS
L’Utilisateur reconnaît avoir pris connaissance au moment de la consultation et de l’utilisation du Site et/ou de l’Application, des présentes conditions générales et déclare expressément les accepter sans réserve.

OBJET
Le Site/Application a pour objet de:

mettre à disposition un outil de messagerie
consulter l’ensemble des documents relatifs au mandat de gestion et à la location
informer sur tout événement lié au mandat de gestion
consulter son compte propriétaire locataire
Cette liste est non exhaustive et peut être modifiée à tout moment par SERGIC sans que sa responsabilité ne puisse être engagée à ce titre par qui que ce soit.

PARCOURS DE SOUSCRIPTION
L’Utilisateur clique sur “activer mon compte” et renseigne son adresse mail. Si le mail est inconnu des services de SERGIC, l’Utilisateur est renvoyé vers le service relations clients. Si le mail est connu des services de SERGIC, l’Utilisateur reçoit un mail contenant une URL qui le redirige vers la création de son mot de passe. Le lien URL n’est valable que 72h.

ACCÈS
Pour accéder au Site/Application et l’utiliser, vous devez posséder un Smartphone, un ordinateur ou une tablette compatible et un accès au réseau Internet.

L’Application est téléchargeable gratuitement depuis les plateformes Apple Store et Google Play Store sur les terminaux mobiles suivants :

Téléphone mobile Iphone d’Apple disposant du système d’exploitation iOS 4.1 et plus
Téléphone mobile disposant du système d’exploitation Android 5.x et plus
CONTENU
Toutes les marques, photographies, textes, commentaires, illustrations, images animées ou non, séquences vidéo, sons, ainsi que toutes les applications informatiques qui pourraient être utilisées pour faire fonctionner le Site/Application et plus généralement tous les éléments reproduits ou utilisés sur le Site/Application sont protégés par les lois en vigueur au titre de la propriété intellectuelle.

Ils sont la propriété pleine et entière de l’éditeur ou de ses partenaires. Toute reproduction, représentation, utilisation ou adaptation, sous quelque forme que ce soit, de tout ou partie de ces éléments, y compris les applications informatiques, sans l’accord préalable et écrit de l’éditeur, sont strictement interdites. Le fait pour l’éditeur de ne pas engager de procédure dès la prise de connaissance de ces utilisations non autorisées ne vaut pas acceptation desdites utilisations et renonciation aux poursuites.

VALIDITÉ DES INFORMATIONS ET RESPONSABILITÉ
Les informations données sur ce site et/ou Application n’ont pas un caractère contractuel.

Les informations fournies, bien que faisant l’objet d’une attention particulière, sont données sous réserve d’erreurs de saisie ou de disponibilité au moment de leur consultation.

L’Editeur ne pourra être tenu responsable des conséquences directe ou indirectes pouvant résulter de l’utilisation la consultation et l’interprétation des informations fournies. L’éditeur ne peut être tenue responsable en cas de mauvaise utilisation du service par le client.

DISPONIBILITÉ
L’éditeur s’engage à faire ses meilleurs efforts pour sécuriser l’accès, la consultation et l’utilisation des Informations et/ou des services du Site/Application. Le Site /Application est accessible 24 heures sur 24, 7 jours sur 7 sauf en cas de force majeure ou de survenance d’un événement hors du contrôle de l’Editeur et sous réserve des éventuelles pannes et interventions de maintenance nécessaires au bon fonctionnement du Site/Application . Les interventions de maintenance pourront être effectuées sans que les Utilisateurs aient été préalablement avertis. A ce titre l’Editeur est tenu d’une obligation de moyen.

En toute hypothèse, l'Éditeur ne saurait être responsable :

en cas d’indisponibilité du Site/Application et des Services pour des raisons telles que la défaillance du réseau public d’électricité, la défaillance des réseaux câblés de télécommunications, la perte de connectivité au réseau Internet due aux opérateurs publics ou privés, notamment de l’Utilisateur et de l’Internaute, dont les causes proviennent notamment de grèves, de tempêtes, de tremblements de terre ou de toute autre cause ayant les caractéristiques de la force majeure ;
en cas d’utilisation du Site/Application et des Services par un Utilisateur et un Internaute dans des conditions non-conformes aux termes des présentes Conditions Générales d’Utilisation ;
L’Utilisateur déclare accepter les caractéristiques et les limites de l’Internet mobile et des systèmes d’exploitation du Site/Application, et en particulier reconnaître que :

son utilisation du Site/Application se fait à ses risques et périls ;
le Site/Application lui sont accessibles “en état” et en fonction de leur disponibilité ;
la protection de ses propres données et/ou logiciels lui incombe et il lui appartient de prendre toutes les mesures appropriées de façon à les protéger des éventuels virus circulant sur le Site/Application, les Informations ou les services ;
les performances techniques de l’Internet Mobile requièrent un temps de traitement nécessaire pour répondre, consulter, interroger ou transférer les Informations.
EVOLUTION DES CONDITIONS GÉNÉRALES D’UTILISATION
Les CGU applicables sont celles en vigueur à la date de la connexion de l’Utilisateur.

L’éditeur se réserve le droit de modifier, à tout moment, tout ou partie, des dispositions des CGU sans préavis ni information préalable des Utilisateurs afin de les adapter aux évolutions des Services, aux évolutions techniques, légales ou jurisprudentielles ou lors de la mise en place de nouvelles prestations.

Si nous modifions les présentes Conditions, nous publierons les Conditions modifiées sur le site/Application https://client.e-loca.com en modifiant la date « Dernière mise à jour » figurant en haut des Conditions.

Nous vous informerons également des modifications lors de votre connexion à votre espace client.

Tout nouveau Service intégrant de nouvelles techniques ou nouvelles caractéristiques améliorant la qualité des Services existants seront aussi soumis aux présentes CGU, sauf disposition expresse contraire.

PROTECTION DES DONNÉES PERSONNELLES
Identité du responsable de traitement : SERGIC SAS, 6 rue Konrad Adenauer - 59290 Wasquehal

Délégué à la protection des données : SERGIC SAS a désigné un Délégué à la protection des données que vous pouvez contacter à l’adresse « dpo@sergic.com ».

Finalités des traitements et bases légales :

Les données à caractère personnel recueillies par SERGIC font l’objet d’un traitement automatisé nécessaire à la passation, à la gestion et à l’exécution du contrat relatif aux biens immobiliers de ses clients, et à la réalisation d’opérations commerciales.
Dans ce contexte, SERGIC traite les données à caractère personnel des Utilisateurs pour les finalités suivantes :

exécution des mandats et traitement des dossiers confiés à SERGIC ;
gestion de la relation client (GRC) ;
réponses aux questions qui nous sont posées (par téléphone ou en ligne) ;
suivi de notre relation commerciale
réponses à nos obligations administratives.
Les données à caractère personnel des utilisateurs font également l’objet d’un traitement automatisé à des fins de communication et de prospection commerciale. Ce traitement est nécessaire à la poursuite par SERGIC de son intérêt légitime de développer la relation commerciale établie avec ses clients.
Dans ce contexte, les utilisateurs sont susceptibles de recevoir :

des communications relatives aux événements organisés par SERGIC, aux animations commerciales de SERGIC, aux vœux et autres félicitations de la part de SERGIC ainsi qu’à des produits et services analogues à ceux fournis par SERGIC ;
les newsletters ou fils d’informations de SERGIC.
Les données à caractère personnel des Utilisateurs font aussi l’objet d’un traitement automatisé à des fins de statistiques (conduite d’enquêtes ou d’analyses dans le cadre d’opérations commerciales mises en place). Ce traitement est nécessaire à la poursuite par SERGIC de son intérêt légitime d’amélioration de ses services.
Données personnelles traitées :

Ce Site/Application collecte les Données personnelles fournies par les Utilisateurs à l’occasion de leur visite sur le Site/Application.

Il peut s’agir :

de celles que l’Utilisateur a volontairement fournies à l’éditeur lors de l’ouverture de son compte personnel sur le Site/Application ainsi que de celles que l’Utilisateur sera amené à transmettre à l’éditeur ultérieurement dans le cadre de l’utilisation de son compte personnel ;
de celles que l’éditeur a pu recueillir à l’occasion de sa navigation sur les sites Internet et/ou Applications du Groupe SERGIC et plus particulièrement sur le site Internet (https://client.e-loca.com/connexion) .
L’Utilisateur s’engage à garantir l’exactitude des Données personnelles fournies et s’engage à informer sans délai l’éditeur en cas de changement. Les Données personnelles ne doivent pas être fausses, imprécises, mensongères et elles ne doivent enfreindre aucune loi ni aucun règlement en vigueur.

Les Données personnelles indispensables à SERGIC pour traiter et exécuter les demandes de l’Utilisateur sont signalées par un astérisque (*). A défaut de la transmission desdites Données personnelles, la demande de l’Utilisateur ne pourra pas être traitée. Les autres informations demandées, pour lesquelles la réponse est facultative, sont destinées à mieux connaître l’Utilisateur et ainsi à améliorer les services qui lui sont proposés.

L’éditeur s’engage à faire ses meilleurs efforts afin de conserver la confidentialité des Données personnelles relatives aux Utilisateurs.

Destinataires des Données personnelles :

Les Données personnelles des Utilisateurs que nous collectons pourront être communiquées aux entités du Groupe SERGIC. Cette communication peut-être nécessaire à la poursuite par SERGIC de son intérêt légitime de développer la relation commerciale établie avec ses clients. Les Données personnelles des Utilisateurs que nous collections pourront également être communiquées aux prestataires dûment autorisés, y compris les sous-traitants liés par contrat.

Si vous ne souhaitez pas que vos Données Personnelle soient transmises, il vous est possible d’exercer votre droit d'opposition à tout moment.

Pour exercer ce droit, l’Utilisateur peut adresser sa demande selon les modalités suivantes :

Lien de désabonnement qui figure dans chaque envoi
Courrier postal : SERGIC – Protection des données - 6 rue Konrad Adenauer, 59 290 WASQUEHAL
Courriel : dpo@sergic.com
Formulaire en ligne accessible à l’adresse URL : http://www.sergic.com/traitement-donnees-personnelles.html
Droits et modalités d’exercice : F

Conformément à la Réglementation relative à la protection des données personnelles et, dans les conditions qu’elle définit, Vous disposez des droits suivants :

Droit d’accès : Vous disposez d’un droit de demander à SERGIC la confirmation que des Données personnelles Vous concernant sont ou non traitées et d’obtenir la copie desdites Données personnelles.
Droit d’opposition : Vous avez le droit de vous opposer à tout moment, pour des raisons tenant à votre situation particulière, à un traitement de vos Données personnelles. SERGIC cessera de traiter les Données vous concernant à moins qu'il ne soit démontré qu'il existe des motifs légitimes pour poursuivre le traitement (notamment la nécessité à des fins de constatation, d'exercice ou de défense de droits en justice, contrat vous liant à SERGIC en cours d’exécution).
Vous pouvez vous opposer, à tout moment, au traitement de vos Données personnelles à des fins de prospection commerciale, notamment en utilisant le lien de désabonnement qui figure dans chaque envoi.

Droit de rectification : Vous pouvez demander la rectification des informations inexactes vous concernant si celles détenues par SERGIC sont obsolètes, erronées ou incomplètes.
L’exercice de ce droit s’exerce auprès de votre interlocuteur habituel, à défaut auprès de la Direction en charge de la relation client de SERGIC (serviceclient@sergic.com).

SERGIC ne pourra se voir reprocher une absence de mise à jour si le client ou le contact n’actualise pas ses données.

Droit à l’effacement : l’Utilisateur peut obtenir l’effacement des Données personnelles le concernant lorsqu’un motif prévu par la Réglementation relative à la protection des données personnelles est satisfait (inutilité des données, retrait du consentement pour les traitements fondés sur ce dernier, traitement illicite, etc.). Le droit à l’effacement ne sera pas applicable lorsque les Données personnelles sont traitées par SERGIC pour respecter les obligations légales et réglementaires auxquelles elle est soumise ou que les Données personnelles sont nécessaires à la constatation, à l'exercice ou à la défense de droits en justice.
Droit à la limitation : ce droit permet de demander la suspension temporaire de l’utilisation de Données personnelles notamment lorsque l’exactitude de ces dernières ou la licéité du traitement sont contestés.
L’Utilisateur est informé que la licéité des traitements mis en œuvre par SERGIC est précisée aux présentes conformément à la Réglementation relative à la protection des données personnelles. En outre, les Données personnelles traitées sont fournies par l’Utilisateur.

Droit à la portabilité : ce droit vous permet d’obtenir la restitution dans un format lisible et exploitable des Données personnelles que Vous avez fournies ou qui résultent de l’utilisation des services que nous Vous fournissons. Toutefois, ce droit ne s’applique que si le traitement est automatisé (les fichiers papiers ne sont pas concernés) et qu’il est mis en œuvre sur la base de Votre consentement ou en exécution d’un contrat vous liant à SERGIC.
Décision individuelle automatisée / Profilage : Bien que l’intégralité de nos activités implique pour l’heure une prise de décision humaine au cours du processus, nous pourrions à l’avenir avoir recours à des technologies entièrement automatisées telles que des systèmes experts ou l’apprentissage machine qui couvriraient le processus de sélection des clients potentiels de bout en bout, s’il y a lieu et conformément aux lois et exigences locales.
S’il y a lieu, SERGIC se conformera aux exigences définies par la Réglementation relative à la protection des données personnelles.

Droit post mortem / droit à l’oubli : Vous disposez du droit de formuler des directives concernant la conservation, l’effacement et la communication de leurs données post-mortem. La communication de directives spécifiques post-mortem et l’exercice de leurs droits s’effectuent selon les d’exercice des droits.
Modalités d’exercice des droits :

Il est rappelé à l’Utilisateur que chacun des droits mentionnés ci-dessous est individuel. En conséquence, seule l’Utilisateur concerné peut les exercer. Pour satisfaire à cette obligation, il est demandé à l’Utilisateur de justifier de son identité par tout moyen lorsqu’il formule sa demande. En cas de doute, une copie d’un titre d’identité pourra vous être demandée.

Pour exercer ces droits, l’Utilisateur peut adresser sa demande selon les modalités suivantes :

Courrier postal : SERGIC – Protection des données - 6 rue Konrad Adenauer, 59 290 WASQUEHAL
Courriel : dpo@sergic.com
Formulaire en ligne accessible à l’adresse URL : http://www.sergic.com/traitement-donnees-personnelles.html
POLITIQUE DE CONFIDENTIALITÉ
Tous nos traitements de données à caractère personnel sont mis en œuvre dans le respect de notre Politique de confidentialité accessible ici .

COOKIES
Qu’est ce qu’un cookie ?

Lors de votre consultation du Site/Application, des informations relatives à votre navigation sur le Site/Application à partir de votre terminal (ordinateur, tablette, smartphone …) sont susceptibles d’être enregistrées dans des petits fichiers textes scriptés appelés « cookies ».

A quoi servent les cookies ?

Il existe 4 types de cookie qui permettent :

D’accéder à certains services du Site/Application comme créer votre compte…. Ces cookies techniques sont absolument indispensables pour le bon fonctionnement de notre Site/Application.
De mémoriser les informations que vous avez saisies afin de simplifier votre navigation et vos recherches. Ces cookies fonctionnels vous permettent d’utiliser le Site/Application de façon plus efficace.
D’établir des statistiques sur les pages consultées et/ou les requêtes effectuées afin d’optimiser la performance du Site/Application et de vous proposer des services toujours appropriés. Il s’agit des cookies analytiques.
De collecter des informations sur vos habitudes de navigation dans le but de vous présenter des publicités adaptées à vos centres d’intérêt. Ce sont les cookies publicitaires. Ils enregistrent votre visite sur notre Site/Application, les pages que vous avez visitées et les liens que vous avez suivis ainsi que votre navigation en dehors de notre site/Application. Ils sont également utilisés pour limiter le nombre de fois où vous voyez une publicité ainsi que pour mesurer l’efficacité des campagnes publicitaires. Ils sont généralement placés par des tiers avec notre permission. Le refus de ce type de cookie n’a pas d’impact sur l’utilisation de notre Site/Application et n’empêche pas l’affichage de la publicité sur notre Site ou sur Internet de manière générale.
Comment accepter ou refuser les cookies ?

Vous pouvez à tout moment activer ou désactiver les cookies en paramétrant votre navigateur internet.

Pour la gestion des cookies, la configuration de chaque navigateur est différente. Elle est décrite dans le menu d’aide de votre navigateur. Voici les liens des principaux navigateurs pour vous aider à modifier ces paramètres :

Internet Explorer™
Safari™
Chrome™
Firefox™
Opera™
Edge™
Cookie des réseaux sociaux

Notre Site/Application utilise des applications informatiques émanant de tiers, qui permettent à l’internaute de partager des contenus de notre Site/Application avec d’autres personnes ou de faire connaître à ces autres personnes son opinion concernant un contenu de notre Site/Application. Tel est notamment le cas des boutons « Partager », « J’aime », issus de réseaux sociaux tels que Facebook, « Google+ », »Twitter », etc.

Le réseau social est susceptible de vous identifier grâce à ce bouton, même si vous ne l’avez pas utilisé lors de votre consultation de notre Site/Application. Ce type de bouton applicatif peut permettre au réseau social concerné de suivre votre navigation sur notre site/Application, du seul fait que votre compte au réseau social était activé sur votre terminal (session ouverte) durant votre navigation sur notre Site/Application.

Nous n’avons aucun contrôle sur le processus employé par les réseaux sociaux pour collecter des informations relatives à votre navigation sur notre site/Application et associées aux données personnelles dont ils disposent. Nous vous invitons à consulter les politiques de protection de la vie privée de ces réseaux sociaux afin de prendre connaissance des finalités d’utilisation, notamment publicitaires, des informations de navigation qu’ils peuvent recueillir grâce à ces boutons applicatifs.

Vous souhaitez avoir plus d’informations sur les cookies ? Rendez-vous sur le site de la CNIL : http://www.cnil.fr/vos-droits/vos-traces/les-cookies/

MÉDIATION DES LITIGES DE LA CONSOMMATION
La procédure de médiation est ouverte aux seuls clients du Groupe Sergic ayant la qualité de consommateur et ne peut s’effectuer qu’après épuisement des voies de recours amiables internes. Le consommateur est défini comme toute personne physique qui agit à des fins qui n’entrent pas dans le cadre de son activité commerciale, industrielle, artisanale ou libérale.

Les voies de recours amiables internes
Toute réclamation peut être adressée par lettre recommandée avec accusé de réception à l’adresse suivante :

GROUPE SERGIC – Service Réclamation, 6, Rue Konrad Adenauer - CS 71031, 59447 WASQUEHAL

La médiation de la consommation
Le recours est considéré comme épuisé si la réponse à votre réclamation ne vous satisfait pas ou si vous n’avez pas reçu de réponse 60 jours après la réception de votre réclamation.

En cas de litige entre le professionnel et le consommateur, ceux-ci s’efforceront de trouver une solution amiable.

A défaut d’accord amiable, le consommateur a la possibilité de saisir gratuitement le médiateur de la consommation dont relève le professionnel, à savoir l’Association des Médiateurs Européens (AME CONSO), dans un délai d’un an à compter de la réclamation écrite adressée au professionnel.

La saisie du médiateur de la consommation devra s’effectuer :

soit en complétant le formulaire prévu à cet effet sur le site internet de l’AME CONSO : www.mediationconso-ame.com
soit par courrier adressé à l’AME CONSO : 11 Place Dauphine – 75001 PARIS.
CRÉDITS PHOTOS
L’ensemble des photos du Site/Application ont été fournies par la banque de photos SERGIC ou ont été achetées sur Fotolia.

LOI APPLICABLE
Les présentes CGU sont soumises à la loi française.

L’Utilisateur et l’Éditeur conviennent de faire leur possible pour résoudre à l’amiable toute contestation susceptible de résulter de l’interprétation, de l’exécution et/ou la cessation des présentes CGU.
''',
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Drawer pour petit écran
          drawer: !isLargeScreen
              ? const Drawer(
                  child: Volet(
                  ),
                )
              : null, // Pas de Drawer si la taille est grande
        );
      },
    );
  }
}
