require "google_drive"
require 'mail'
require 'gmail'
require 'gmail_xoauth'

session = GoogleDrive::Session.from_config("config.json")
ws = session.spreadsheet_by_key("18UrlX3LS7nw__konCtFRygXWFeJ3ZMahVDoNfSUGA6o").worksheets[0] #connexion au spreedsheet contenant les emails scrappés
gmail = Gmail.connect("login", "mdp") #config du compte gmail sender
for i in (1..180) do #boucle for
  sleep(30) if i%10==0  #Attendre 1 minute à chaque 5 mails envoyés
mail = ws[i, 2] #variable mail qui cherche la deuxième colonne
townhall_name = ws[i, 1] #variable ville qui cherche la premiere colonne


email = gmail.compose do
  to mail #appel de la variable mail
    subject "#{townhall_name}, Apprenez le code gratuitement avc THP!" #appel le nom de la mairie
    body "Bonjour #{townhall_name},
    Je m'appelle Zinho, je suis élève à une formation de code gratuite, ouverte à tous, sans restriction géographique, ni restriction de niveau.
    La formation s'appelle The Hacking Project (http://thehackingproject.org/).
    Nous apprenons l'informatique via la méthode du peer-learning : nous faisons des projets concrets qui nous sont assignés tous les jours, sur lesquel nous planchons en petites équipes autonomes.
    Le projet du jour est d'envoyer des emails à nos élus locaux pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation gratuite.

    Nous vous contactons pour vous parler du projet, et vous dire que vous pouvez ouvrir une cellule, où vous pouvez former gratuitement 6 personnes (ou plus), qu'elles soient débutantes, ou confirmées. Le modèle d'éducation de The Hacking Project n'a pas de limite en terme de nombre de moussaillons (c'est comme cela que l'on appelle les élèves), donc nous serions ravis de travailler avec vous!"
end
gmail.deliver(email) #envoie du mail
end
